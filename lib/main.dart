// import 'package:azkark/azkark_app.dart';
// import 'package:azkark/core/services/back_ground_service/callback_dispatcher.dart';
// import 'package:flutter/material.dart';
// import 'package:workmanager/workmanager.dart';
// import 'package:azkark/core/services/service_locator.dart';

// @pragma('vm:entry-point')
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // 1️⃣ setup Service Locator
//   await setupServiceLocator();

//   // 2️⃣ Initialize Workmanager
//   await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

//   // 3️⃣ Register periodic tasks (adjust frequency to your needs)
//   await Workmanager().registerPeriodicTask(
//     "1",
//     "fetchNextPrayerTask",
//     frequency: const Duration(minutes: 70),
//     existingWorkPolicy: ExistingWorkPolicy.replace,
//   );

//   await Workmanager().registerPeriodicTask(
//     "2",
//     "fetchDailyPrayersTask",
//     frequency: const Duration(hours: 24),
//     existingWorkPolicy: ExistingWorkPolicy.replace,
//   );

//   // 4️⃣ run app with providers
//   runApp(const AzkarkApp());
// }
import 'package:azkark/azkark_app.dart';
import 'package:azkark/core/services/back_ground_service/callback_dispatcher.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:azkark/core/services/service_locator.dart';

@pragma('vm:entry-point')
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  await Workmanager().registerPeriodicTask(
    "2",
    "fetchDailyPrayersTask",
    frequency: const Duration(hours: 24),
    existingWorkPolicy: ExistingWorkPolicy.replace,
  );

  // await Workmanager().registerPeriodicTask(
  //   "1",
  //   "fetchNextPrayerTask",
  //   frequency: const Duration(minutes: 60),
  //   existingWorkPolicy: ExistingWorkPolicy.replace,
  // );

  runApp(const AzkarkApp());
}
