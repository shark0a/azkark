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
  /// Fetches full day prayer times from API and stores in Hive
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
        // ignore: unnecessary_null_comparison
        log("No saved location. Skipping fetchDailyPrayers.");
        return;
      }

      final response = await homeRepo.getPrayersTime(
        location.lat,
        location.long,
      );

      if (response.data != null) {
        final hiveModel = response.data.toHiveModel();

        await hive.putData<PrayerDataHiveModel>(
          HiveKeys.prayersBox,
          HiveKeys.prayersTimesTodayKey,
          hiveModel,
        );

        await prefs.setString(
          SharedPrefKeys.countryName,
          response.data.meta.timezone,
        );

        log("fetchDailyPrayers saved successfully.");
        await NotificationService.instance.init();
        await NotificationService.instance.scheduleDailyPrayers();
      }
    } catch (e, st) {
      log("fetchDailyPrayers ERROR: $e\n$st");
    }
  }
}
