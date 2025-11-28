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

  /// تهيئة الإشعارات
  Future<void> init() async {
    try {
      // تهيئة timezone
      tz.initializeTimeZones();

      // ✅ تحديد الـ timezone من الـ Meta في Hive
      await _setTimezoneFromHive();

      log("🌍 Timezone set to: ${tz.local.name}");

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

      // طلب إذن runtime على Android 13+
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();

      log(
        "✅ NotificationService initialized successfully with timezone: ${tz.local.name}",
      );
    } catch (e) {
      log("❌ Error initializing NotificationService: $e");
      // Fallback: استخدام UTC إذا فشل التعيين
      tz_local.setLocalLocation(tz_local.getLocation('UTC'));
    }
  }

  /// تحديد الـ timezone من الـ Meta في Hive
  Future<void> _setTimezoneFromHive() async {
    try {
      final hive = sl.get<HiveService>();
      final prayerTimesHive = hive.getData<PrayerDataHiveModel>(
        HiveKeys.prayersBox,
        HiveKeys.prayersTimesTodayKey,
      );

      String timezoneName = 'Africa/Cairo'; // افتراضي

      if (prayerTimesHive != null) {
        // ✅ استخدام الـ timezone من الـ Meta في Hive
        timezoneName = prayerTimesHive.meta.timezone;
        log("🎯 Using timezone from Hive Meta: $timezoneName");
      } else {
        log("⚠️ No Meta found in Hive, using default timezone: $timezoneName");
      }

      final location = tz.getLocation(timezoneName);
      tz.setLocalLocation(location);
      log("✅ Timezone set to: $timezoneName");
    } catch (e) {
      log("❌ Error setting timezone from Hive: $e");
      // Fallback إلى توقيت مصر
      final location = tz.getLocation('Africa/Cairo');
      tz.setLocalLocation(location);
    }
  }

  /// جدولة إشعارات الصلوات اليومية
  Future<void> scheduleDailyPrayers() async {
    try {
      // On Android 12+ exact alarms require special permission from the user.
      // Ask platform to ensure exact alarms are allowed before scheduling.
      const platform = MethodChannel('azkark/exact_alarm');
      try {
        final allowed = await platform.invokeMethod<bool>(
          'ensureExactAlarmsAllowed',
        );
        if (allowed == false) {
          log(
            'Exact alarms not permitted by user; skipping scheduling and requesting permission via settings.',
          );
          return;
        }
      } on PlatformException catch (e) {
        log(
          'PlatformException while requesting exact alarm permission: ${e.message}',
        );
        // If we cannot request permission (e.g., in background), abort scheduling to avoid exception
        return;
      } catch (e) {
        log('Unexpected error while checking exact alarm permission: $e');
        return;
      }

      final hive = sl.get<HiveService>();
      final prayerTimesHive = hive.getData<PrayerDataHiveModel>(
        HiveKeys.prayersBox,
        HiveKeys.prayersTimesTodayKey,
      );

      if (prayerTimesHive == null) {
        log("❌ No prayer times found in Hive");
        return;
      }

      log("🕌 Starting prayer scheduling...");
      log(
        "📅 API Times - Fajr: ${prayerTimesHive.timings.fajr}, Dhuhr: ${prayerTimesHive.timings.dhuhr}, Asr: ${prayerTimesHive.timings.asr}, Maghrib: ${prayerTimesHive.timings.maghrib}, Isha: ${prayerTimesHive.timings.isha}",
      );

      // ✅ استخدام الـ prayer keys الإنجليزية علشان نترجمها بعدين
      final prayerTimes = {
        "fajr": _parseTime(prayerTimesHive.timings.fajr),
        "dhuhr": _parseTime(prayerTimesHive.timings.dhuhr),
        "asr": _parseTime(prayerTimesHive.timings.asr),
        "maghrib": _parseTime(prayerTimesHive.timings.maghrib),
        "isha": _parseTime(prayerTimesHive.timings.isha),
      };

      // ✅ التأكد من أن الـ timezone مضبوط من الـ Meta
      await _setTimezoneFromHive();

      final now = tz_local.TZDateTime.now(tz_local.local);

      // ✅ التحقق من الـ timezone والوقت
      log("🌍 Current timezone: ${tz_local.local.name}");
      log("⏰ TZ Current Time: $now");
      log("📱 Device Current Time: ${DateTime.now()}");

      int successCount = 0;

      for (final entry in prayerTimes.entries) {
        if (entry.value != null) {
          final scheduled = _schedulePrayer(entry.key, entry.value!, now);
          if (scheduled) successCount++;
        }
      }

      log(
        "🎉 Scheduling completed: $successCount/${prayerTimes.length} prayers scheduled",
      );
    } catch (e) {
      log("💥 ERROR in scheduleDailyPrayers: $e");
    }
  }

  /// تحويل وقت الصلاة من String إلى TimeOfDay
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
      log("❌ Error parsing time: $timeStr - $e");
      return null;
    }
  }

  /// جدولة صلاة واحدة
  bool _schedulePrayer(
    String prayerKey, // ✅ مفتاح الصلاة (fajr, dhuhr, etc.)
    TimeOfDay prayerTime,
    tz_local.TZDateTime now,
  ) {
    try {
      var scheduleTime = tz_local.TZDateTime(
        tz_local.local,
        now.year,
        now.month,
        now.day,
        prayerTime.hour,
        prayerTime.minute,
      );

      log(
        "🕒 $prayerKey -> API Time: ${prayerTime.hour}:${prayerTime.minute} -> Scheduled: $scheduleTime",
      );

      if (scheduleTime.isBefore(now)) {
        scheduleTime = scheduleTime.add(const Duration(days: 1));
        log("📅 $prayerKey -> Adjusted to tomorrow: $scheduleTime");
      }

      final timeUntilPrayer = scheduleTime.difference(now);
      log("⏱️ $prayerKey -> Will notify in: $timeUntilPrayer");

      // ✅ الحصول على اسم الصلاة المترجم
      final prayerName = _getLocalizedPrayerName(prayerKey);

      flutterLocalNotificationsPlugin.zonedSchedule(
        prayerKey.hashCode,
        _getLocalizedNotificationTitle(), // ✅ عنوان مترجم
        '$_getLocalizedPrayerText$prayerName', // ✅ نص مترجم
        scheduleTime,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'prayer_channel',
            _getLocalizedChannelName(), // ✅ اسم القناة مترجم
            channelDescription:
                _getLocalizedChannelDescription(), // ✅ وصف القناة مترجم
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

      log("✅ SUCCESS: $prayerName scheduled for $scheduleTime");
      return true;
    } catch (e) {
      log("❌ FAILED to schedule $prayerKey: $e");
      return false;
    }
  }

  /// الحصول على اسم الصلاة المترجم
  String _getLocalizedPrayerName(String prayerKey) {
    // ✅ استخدام الـ keys من الـ S.dart
    switch (prayerKey) {
      case 'fajr':
        return S.current.prayer_fajr; // "الفجر" أو "Fajr"
      case 'dhuhr':
        return S.current.prayer_dhuhr; // "الظهر" أو "Dhuhr"
      case 'asr':
        return S.current.prayer_asr; // "العصر" أو "Asr"
      case 'maghrib':
        return S.current.prayer_maghrib; // "المغرب" أو "Maghrib"
      case 'isha':
        return S.current.prayer_isha; // "العشاء" أو "Isha"
      default:
        return prayerKey;
    }
  }

  /// الحصول على عنوان الإشعار المترجم
  String _getLocalizedNotificationTitle() {
    return '🕌 ${S.current.prayer_title}'; // "🕌 مواقيت الصلاة" أو "🕌 Prayer Times"
  }

  /// الحصول على نص الإشعار المترجم
  String get _getLocalizedPrayerText {
    return '${S.current.for_prayer_prefix} '; // "لصلاة " أو "For "
  }

  /// الحصول على اسم القناة المترجم
  String _getLocalizedChannelName() {
    return S.current.prayer_times_label; // "مواقيت الصلاة" أو "Prayer Times"
  }

  /// الحصول على وصف القناة المترجم
  String _getLocalizedChannelDescription() {
    return S.current.prayer_times_label; // "مواقيت الصلاة" أو "Prayer Times"
  }

  /// إلغاء كل الإشعارات
  Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    log("🗑️ All notifications cancelled");
  }
}
