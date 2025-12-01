import 'package:azkark/core/services/back_ground_service/prayer_background_service.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await setupServiceLocator();

    if (task == "fetchDailyPrayersTask") {
      await PrayerBackgroundService.fetchDailyPrayers();

      final now = DateTime.now();
      final tomorrowMidnight = DateTime(now.year, now.month, now.day + 1);
      final delay = tomorrowMidnight.difference(now);

      await Workmanager().registerOneOffTask(
        "fetchTomorrow",
        "fetchDailyPrayersTask",
        initialDelay: delay,
      );
    }

    return Future.value(true);
  });
}
