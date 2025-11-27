
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/Features/Home/data/prayers_time_hive_models.dart';
import 'package:azkark/core/utils/cache/hive_keys.dart';
import 'package:azkark/core/utils/cache/hive_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz_local;

class NotificationService {
  NotificationService._privateConstructor();
  static final NotificationService instance =
      NotificationService._privateConstructor();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// تهيئة الإشعارات
  Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
    );

    // طلب إذن runtime على Android 13+
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    log("NotificationService initialized successfully");
  }

  /// جدولة إشعارات الصلوات اليومية
  Future<void> scheduleDailyPrayers() async {
    final hive = sl.get<HiveService>();
    final prayerTimesHive = hive.getData<PrayerDataHiveModel>(
      HiveKeys.prayersBox,
      HiveKeys.prayersTimesTodayKey,
    );

    if (prayerTimesHive == null) return;

    final prayerMap = {
      "Fajr": prayerTimesHive.timings.fajr,
      "Dhuhr": prayerTimesHive.timings.dhuhr,
      "Asr": prayerTimesHive.timings.asr,
      "Maghrib": prayerTimesHive.timings.maghrib,
      "Isha": prayerTimesHive.timings.isha,
    };
    final now = tz_local.TZDateTime.now(tz_local.local);

    for (final entry in prayerMap.entries) {
      final name = entry.key;
      final timeStr = entry.value;
      if (timeStr.isEmpty) continue;

      final normalized = timeStr.contains(":")
          ? timeStr
          : timeStr.replaceAll("-", ":");
      final parts = normalized.split(":");
      if (parts.length < 2) continue;
      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = int.tryParse(parts[1]) ?? 0;

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
        name.hashCode,
        'حان الآن',
        'صلاة $name',
        scheduleTime,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'prayer_channel',
            'Prayer Notifications',
            channelDescription: 'Notifications for prayer times',
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

      log("Scheduled $name at $scheduleTime");
    }
  }

  /// إلغاء كل الإشعارات
  Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    log("All notifications cancelled");
  }
}
