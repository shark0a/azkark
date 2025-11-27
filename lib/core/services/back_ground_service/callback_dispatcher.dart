import 'dart:developer';

import 'package:azkark/core/services/back_ground_service/prayer_background_service.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      await setupServiceLocator();

      if (task == "fetchDailyPrayersTask") {
        await PrayerBackgroundService.fetchDailyPrayers();
      }

    } catch (e) {
      log(e.toString());
    }

    return Future.value(true);
  });
}
