import 'dart:developer';
import 'package:azkark/Features/Home/data/prayers_time_hive_models.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/hive_keys.dart';
import 'package:azkark/core/utils/cache/hive_service.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart' as tz_local;

class NotificationService {
  NotificationService._privateConstructor();
  static final NotificationService instance =
      NotificationService._privateConstructor();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  // Azkar reminder IDs
  static const int _azkarMorningId = 1001;
  static const int _azkarEveningId = 1002;

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      tz.initializeTimeZones();

      await _setTimezoneFromHive();

      print("Timezone set to: ${tz.local.name}");
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/launcher_icon');

      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
          );

      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: androidSettings,
          iOS: iosSettings,
        ),
      );

      // On Android 12+ exact alarms
      const platform = MethodChannel('azkark/exact_alarm');
      try {
        final allowed = await platform.invokeMethod<bool>(
          'ensureExactAlarmsAllowed',
        );
        if (allowed == false) {
          print(
            'Exact alarms not permitted by user; skipping scheduling and requesting permission via settings.',
          );
        }
      } on PlatformException catch (e) {
        print(
          'PlatformException while requesting exact alarm permission: ${e.message}',
        );
      } catch (e) {
        print('Unexpected error while checking exact alarm permission: $e');
      }
      // طلب إذن runtime على Android 13+
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();

      print(
        "NotificationService initialized successfully with timezone: ${tz.local.name}",
      );
      _isInitialized = true;
      // Ensure daily azkar reminders are scheduled (morning & evening)
      try {
        await scheduleDailyAzkarReminders();
      } catch (e) {
        print('Error scheduling azkar reminders during init: $e');
      }
    } catch (e) {
      print("Error initializing NotificationService: $e");
      tz_local.setLocalLocation(tz_local.getLocation('UTC'));
    }
  }

  Future<void> _setTimezoneFromHive() async {
    try {
      final hive = sl.get<HiveService>();
      final prayerTimesHive = hive.getData<PrayerDataHiveModel>(
        HiveKeys.prayersBox,
        HiveKeys.prayersTimesTodayKey,
      );

      String timezoneName = 'Africa/Cairo';

      if (prayerTimesHive != null) {
        timezoneName = prayerTimesHive.meta.timezone;
        print("Using timezone from Hive Meta: $timezoneName");
      } else {
        print("No Meta found in Hive, using default timezone: $timezoneName");
      }

      final location = tz.getLocation(timezoneName);
      tz.setLocalLocation(location);
      print("Timezone set to: $timezoneName");
    } catch (e) {
      print("Error setting timezone from Hive: $e");
      final location = tz.getLocation('Africa/Cairo');
      tz.setLocalLocation(location);
    }
  }

  @pragma('vm:entry-point')
  Future<void> scheduleDailyPrayers() async {
    try {
      final hive = sl.get<HiveService>();
      final prayerTimesHive = hive.getData<PrayerDataHiveModel>(
        HiveKeys.prayersBox,
        HiveKeys.prayersTimesTodayKey,
      );

      if (prayerTimesHive == null) {
        print(" No prayer times found in Hive");
        return;
      }

      print(" Starting prayer scheduling...");
      print(
        "API Times - Fajr: ${prayerTimesHive.timings.fajr}, Dhuhr: ${prayerTimesHive.timings.dhuhr}, Asr: ${prayerTimesHive.timings.asr}, Maghrib: ${prayerTimesHive.timings.maghrib}, Isha: ${prayerTimesHive.timings.isha}",
      );

      final prayerTimes = {
        "fajr": _parseTime(prayerTimesHive.timings.fajr),
        "dhuhr": _parseTime(prayerTimesHive.timings.dhuhr),
        "asr": _parseTime(prayerTimesHive.timings.asr),
        "maghrib": _parseTime(prayerTimesHive.timings.maghrib),
        "isha": _parseTime(prayerTimesHive.timings.isha),
      };

      await _setTimezoneFromHive();

      final now = tz_local.TZDateTime.now(tz_local.local);

      print("Current timezone: ${tz_local.local.name}");
      print(" TZ Current Time: $now");
      print(" Device Current Time: ${DateTime.now()}");

      int successCount = 0;

      for (final entry in prayerTimes.entries) {
        if (entry.value != null) {
          final scheduled = await _schedulePrayer(entry.key, entry.value!, now);
          if (scheduled) successCount++;
        }
      }

      print(
        "Scheduling completed: $successCount/${prayerTimes.length} prayers scheduled",
      );
    } catch (e) {
      print("ERROR in scheduleDailyPrayers: $e");
    }
  }

  TimeOfDay? _parseTime(String timeStr) {
    if (timeStr.isEmpty) return null;

    try {
      final normalized = timeStr.replaceAll("-", ":");
      final parts = normalized.split(':');
      if (parts.length < 2) return null;

      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = int.tryParse(parts[1]) ?? 0;

      if (hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59) {
        return TimeOfDay(hour: hour, minute: minute);
      }
      return null;
    } catch (e) {
      print("Error parsing time: $timeStr - $e");
      return null;
    }
  }

  Future<bool> _schedulePrayer(
    String prayerKey,
    TimeOfDay prayerTime,
    tz_local.TZDateTime now,
  ) async {
    try {
      var scheduleTime = tz_local.TZDateTime(
        tz_local.local,
        now.year,
        now.month,
        now.day,
        prayerTime.hour,
        prayerTime.minute,
      );

      print(
        "🕒 $prayerKey -> API Time: ${prayerTime.hour}:${prayerTime.minute} -> Scheduled: $scheduleTime",
      );

      if (scheduleTime.isBefore(now)) {
        scheduleTime = scheduleTime.add(const Duration(days: 1));
        print("📅 $prayerKey -> Adjusted to tomorrow: $scheduleTime");
      }

      final timeUntilPrayer = scheduleTime.difference(now);
      print("⏱️ $prayerKey -> Will notify in: $timeUntilPrayer");

      final prayerName = _getLocalizedPrayerName(prayerKey);

      try {
        // Cancel any existing notification for this prayer id to avoid duplicates
        try {
          await flutterLocalNotificationsPlugin.cancel(prayerKey.hashCode);
        } catch (_) {}

        await flutterLocalNotificationsPlugin.zonedSchedule(
          prayerKey.hashCode,
          _getLocalizedNotificationTitle(),
          '$_getLocalizedPrayerText$prayerName',
          scheduleTime,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'prayer_channel',
              _getLocalizedChannelName(),
              channelDescription: _getLocalizedChannelDescription(),
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
              sound: RawResourceAndroidNotificationSound('azan'),
              icon: '@mipmap/launcher_icon',
            ),
            iOS: const DarwinNotificationDetails(sound: 'azan.aac'),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
        );

        print("SU: $prayerName scheduled for $scheduleTime");
        return true;
      } on PlatformException catch (e) {
        print(
          'PlatformException scheduling exact alarm: ${e.code} - ${e.message}',
        );
        try {
          await flutterLocalNotificationsPlugin.zonedSchedule(
            prayerKey.hashCode,
            _getLocalizedNotificationTitle(),
            '$_getLocalizedPrayerText$prayerName',
            scheduleTime,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'prayer_channel',
                _getLocalizedChannelName(),
                channelDescription: _getLocalizedChannelDescription(),
                importance: Importance.max,
                priority: Priority.high,
                playSound: true,
                sound: RawResourceAndroidNotificationSound('azan'),
                icon: '@mipmap/launcher_icon',
              ),
              iOS: const DarwinNotificationDetails(sound: 'azan.aac'),
            ),
            // fallback: use inexact scheduling to avoid exact-alarms requirement
            androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
            matchDateTimeComponents: DateTimeComponents.time,
          );
          print('Fallback: scheduled $prayerName with inexact timing');
          return true;
        } catch (e) {
          print('Fallback scheduling failed for $prayerKey: $e');
          return false;
        }
      }
    } catch (e) {
      print("Failed to schedule $prayerKey: $e");
      return false;
    }
  }

  String _getLocalizedPrayerName(String prayerKey) {
    switch (prayerKey) {
      case 'fajr':
        return S.current.prayer_fajr;
      case 'dhuhr':
        return S.current.prayer_dhuhr;
      case 'asr':
        return S.current.prayer_asr;
      case 'maghrib':
        return S.current.prayer_maghrib;
      case 'isha':
        return S.current.prayer_isha;
      default:
        return prayerKey;
    }
  }

  String _getLocalizedNotificationTitle() {
    return '🕌 ${S.current.prayer_title}';
  }

  String get _getLocalizedPrayerText {
    return '${S.current.for_prayer_prefix} ';
  }

  String _getLocalizedChannelName() {
    return S.current.prayer_times_label;
  }

  String _getLocalizedChannelDescription() {
    return S.current.prayer_times_label;
  }

  /// إلغاء كل الإشعارات
  Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    print("🗑️ All notifications cancelled");
  }

  /// Schedule daily azkar reminders at 09:00 AM and 05:00 PM
  @pragma('vm:entry-point')
  Future<void> scheduleDailyAzkarReminders() async {
    try {
      await _setTimezoneFromHive();

      // Cancel existing azkar reminders first to avoid duplicates
      await cancelAzkarReminders();

      final now = tz_local.TZDateTime.now(tz_local.local);

      Future<void> scheduleAt(
        int id,
        String title,
        String body,
        String sound,
        int hour,
        int minute,
      ) async {
        try {
          var scheduleTime = tz_local.TZDateTime(
            tz_local.local,
            now.year,
            now.month,
            now.day,
            hour,
            minute,
          );
          if (scheduleTime.isBefore(now)) {
            scheduleTime = scheduleTime.add(const Duration(days: 1));
          }

          await flutterLocalNotificationsPlugin.zonedSchedule(
            id,
            title,
            body,
            scheduleTime,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'azkar_channel',
                'Azkar Reminders',
                channelDescription: 'Daily morning and evening azkar reminders',
                importance: Importance.max,
                priority: Priority.high,
                playSound: true,
                sound: RawResourceAndroidNotificationSound(sound),
                icon: '@mipmap/launcher_icon',
              ),
              iOS: DarwinNotificationDetails(sound: '$sound.aac'),
            ),
            // use inexact scheduling to avoid exact-alarms permission issues
            androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
            matchDateTimeComponents: DateTimeComponents.time,
          );
          print('Azkar reminder scheduled: $title at $hour:$minute');
        } catch (e) {
          print('Failed to schedule azkar reminder $title: $e');
        }
      }

      // Morning Azkar - 09:00 AM
      await scheduleAt(
        _azkarMorningId,
        'Azkar Morning',
        'Time for morning Azkar',
        'azkar_morning',
        9,
        0,
      );

      // Evening Azkar - 04:30 PM (16:30)
      await scheduleAt(
        _azkarEveningId,
        'Azkar Evening',
        'Time for evening Azkar',
        'eveninig_azkar',
        16,
        30,
      );
    } catch (e) {
      print('ERROR in scheduleDailyAzkarReminders: $e');
    }
  }

  /// Cancel azkar reminders (morning & evening)
  Future<void> cancelAzkarReminders() async {
    try {
      await flutterLocalNotificationsPlugin.cancel(_azkarMorningId);
    } catch (e) {}
    try {
      await flutterLocalNotificationsPlugin.cancel(_azkarEveningId);
    } catch (e) {}
    print('Azkar reminders cancelled (if existed)');
  }

  /// Cancel notification for a specific prayer key
  Future<void> cancelForPrayer(String prayerKey) async {
    try {
      final id = prayerKey.hashCode;
      await flutterLocalNotificationsPlugin.cancel(id);
      print("Cancelled notification for $prayerKey (id=$id)");
    } catch (e) {
      print(" iled to cancel notification for $prayerKey: $e");
    }
  }
}
