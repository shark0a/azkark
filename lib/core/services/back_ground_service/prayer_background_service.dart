import 'dart:developer';

import 'package:azkark/Features/Home/data/current_location_model.dart';
import 'package:azkark/Features/Home/data/prayers_responses/prayer_time_response_model.dart';
import 'package:azkark/Features/Home/data/prayers_time_hive_models.dart';
import 'package:azkark/Features/Home/domain/repo/home_repo.dart';
import 'package:azkark/core/services/back_ground_service/notification_handler/notification_service.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/hive_keys.dart';
import 'package:azkark/core/utils/cache/hive_service.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:azkark/core/utils/cache/shared_pref_keys.dart';

class PrayerBackgroundService {
  @pragma('vm:entry-point')
  static Future<void> fetchDailyPrayers() async {
    try {
      final homeRepo = sl.get<HomeRepo>();
      final hive = sl.get<HiveService>();
      final prefs = sl.get<SharedPref>();

      final location = hive.getData<CurrentLocationModel>(
        HiveKeys.locationBox,
        HiveKeys.locationKey,
      );
      if (location == null) {
        log("ERROR: No location found in Hive, cannot fetch prayer times");
        return;
      }

      final response = await homeRepo.getPrayersTime(
        location.lat,
        location.long,
      );
      log("Successfully fetched prayer times from API");

      final hiveModel = response.data.toHiveModel();

      // Save Hive & timezone
      await Future.wait([
        hive.putData<PrayerDataHiveModel>(
          HiveKeys.prayersBox,
          HiveKeys.prayersTimesTodayKey,
          hiveModel,
        ),
        prefs.setString(
          SharedPrefKeys.countryName,
          response.data.meta.timezone,
        ),
        prefs.setInt(
          'lastFetchDailyPrayers',
          DateTime.now().millisecondsSinceEpoch,
        ),
      ]);
      log("Prayer times saved to Hive and preferences");
      await NotificationService.instance.init();
      log(
        "-==================================in spalsh screen daily init ==============================",
      );
      await NotificationService.instance.scheduleDailyPrayers();
      log(
        "-==================================in spalsh screen daily success===============================",
      );
      log("Notifications scheduled successfully");
    } catch (e, stackTrace) {
      log("ERROR in fetchDailyPrayers: $e");
      log(
        "-==================================in spalsh screen daily ${e.toString()}===============================",
      );
      log("Stack trace: $stackTrace");
      // Future: Report to Firebase Crashlytics for production visibility
    }
  }
}
