import 'package:azkark/core/services/back_ground_service/prayer_background_service.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    await setupServiceLocator();
    if (task == "fetchDailyPrayersTask") {
      await PrayerBackgroundService.fetchDailyPrayers();
      await Workmanager().registerOneOffTask(
        "fetchTomorrow",
        "fetchDailyPrayersTask",
        initialDelay: const Duration(hours: 24),
      );
    }
    return true;
  });
}
