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

  /// Fallback localized strings for background tasks
  final Map<String, String> _defaultPrayerNames = {
    'fajr': 'Fajr',
    'dhuhr': 'Dhuhr',
    'asr': 'Asr',
    'maghrib': 'Maghrib',
    'isha': 'Isha',
  };
  final String _defaultNotificationTitle = '🕌 Prayer Time';
  final String _defaultPrayerText = 'It is time for prayer';

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      tz.initializeTimeZones();
      await _setTimezoneFromHive();

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

      // Android 12+ exact alarms
      const platform = MethodChannel('azkark/exact_alarm');
      try {
        final allowed = await platform.invokeMethod<bool>(
          'ensureExactAlarmsAllowed',
        );
        if (allowed == false) {
          log(
            'Exact alarms not permitted by user; skipping scheduling and requesting permission via settings.',
          );
        }
      } catch (e) {
        log('Error checking exact alarm permission: $e');
      }

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();

      log(
        "NotificationService initialized successfully with timezone: ${tz.local.name}",
      );
      _isInitialized = true;

      try {
        await scheduleDailyAzkarReminders();
      } catch (e) {
        log('Error scheduling azkar reminders during init: $e');
      }
    } catch (e) {
      log("Error initializing NotificationService: $e");
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
        log("Using timezone from Hive Meta: $timezoneName");
      } else {
        log("No Meta found in Hive, using default timezone: $timezoneName");
      }

      final location = tz.getLocation(timezoneName);
      tz.setLocalLocation(location);
      log("Timezone set to: $timezoneName");
    } catch (e) {
      log("Error setting timezone from Hive: $e");
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
        log("No prayer times found in Hive");
        return;
      }

      log("Starting prayer scheduling...");
      final prayerTimes = {
        "fajr": _parseTime(prayerTimesHive.timings.fajr),
        "dhuhr": _parseTime(prayerTimesHive.timings.dhuhr),
        "asr": _parseTime(prayerTimesHive.timings.asr),
        "maghrib": _parseTime(prayerTimesHive.timings.maghrib),
        "isha": _parseTime(prayerTimesHive.timings.isha),
      };

      await _setTimezoneFromHive();
      final now = tz_local.TZDateTime.now(tz_local.local);
      int successCount = 0;

      for (final entry in prayerTimes.entries) {
        if (entry.value != null) {
          final scheduled = await _schedulePrayer(entry.key, entry.value!, now);
          if (scheduled) successCount++;
        }
      }

      log(
        "Scheduling completed: $successCount/${prayerTimes.length} prayers scheduled",
      );
    } catch (e) {
      log("ERROR in scheduleDailyPrayers: $e");
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
      log("Error parsing time: $timeStr - $e");
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

      if (scheduleTime.isBefore(now)) {
        scheduleTime = scheduleTime.add(const Duration(days: 1));
      }

      final prayerName = _getLocalizedPrayerName(prayerKey);

      try {
        await flutterLocalNotificationsPlugin.cancel(prayerKey.hashCode);

        await flutterLocalNotificationsPlugin.zonedSchedule(
          prayerKey.hashCode,
          _getLocalizedNotificationTitle(),
          '$_getLocalizedPrayerText $prayerName',
          scheduleTime,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'prayer_channel',
              'Prayer Times',
              channelDescription: 'Daily prayer times notifications',
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
        log("Scheduled prayer: $prayerName at $scheduleTime");
        return true;
      } catch (e) {
        log('Failed scheduling prayer $prayerKey: $e');
        return false;
      }
    } catch (e) {
      log("Failed to schedule $prayerKey: $e");
      return false;
    }
  }

  String _getLocalizedPrayerName(String key) {
    try {
      switch (key) {
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
          return key;
      }
    } catch (_) {
      return _defaultPrayerNames[key] ?? key;
    }
  }

  String _getLocalizedNotificationTitle() {
    try {
      return '🕌 ${S.current.prayer_title}';
    } catch (_) {
      return _defaultNotificationTitle;
    }
  }

  String get _getLocalizedPrayerText {
    try {
      return '${S.current.for_prayer_prefix}';
    } catch (_) {
      return _defaultPrayerText;
    }
  }

  Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    log("🗑️ All notifications cancelled");
  }

  @pragma('vm:entry-point')
  Future<void> scheduleDailyAzkarReminders() async {
    try {
      await _setTimezoneFromHive();
      await cancelAzkarReminders();
      final now = tz_local.TZDateTime.now(tz_local.local);

      Future<void> scheduleAt(
        int id,
        String title,
        String body,
        String sound,
        String channelId,
        String channelName,
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
                channelId,
                channelName,
                channelDescription:
                    'Daily custom azkar reminders for $channelName',
                importance: Importance.max,
                priority: Priority.high,
                playSound: true,
                sound: RawResourceAndroidNotificationSound(sound),
                icon: '@mipmap/launcher_icon',
              ),
              iOS: DarwinNotificationDetails(sound: '$sound.aac'),
            ),
            androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
            matchDateTimeComponents: DateTimeComponents.time,
          );
          log('Azkar reminder scheduled: $title at $hour:$minute');
        } catch (e) {
          log('Failed to schedule azkar reminder $title: $e');
        }
      }

      // Morning
      await scheduleAt(
        _azkarMorningId,
        'Azkar Morning',
        'Time for morning Azkar',
        'azkar_morning',
        'azkar_morning_channel',
        'Azkar Morning Channel',
        9,
        0,
      );

      // Evening
      await scheduleAt(
        _azkarEveningId,
        'Azkar Evening',
        'Time for evening Azkar',
        'eveninig_azkar',
        'azkar_evening_channel',
        'Azkar Evening Channel',
        16,
        30,
      );
    } catch (e) {
      log('ERROR in scheduleDailyAzkarReminders: $e');
    }
  }

  Future<void> cancelAzkarReminders() async {
    try {
      await flutterLocalNotificationsPlugin.cancel(_azkarMorningId);
      await flutterLocalNotificationsPlugin.cancel(_azkarEveningId);
    } catch (e) {}
    log('Azkar reminders cancelled (if existed)');
  }

  Future<void> cancelForPrayer(String prayerKey) async {
    try {
      final id = prayerKey.hashCode;
      await flutterLocalNotificationsPlugin.cancel(id);
      log("Cancelled notification for $prayerKey (id=$id)");
    } catch (e) {
      log(" iled to cancel notification for $prayerKey: $e");
    }
  }
}
