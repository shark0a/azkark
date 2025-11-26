import 'package:azkark/azkark_app.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final homeController = sl.get<HomeController>();

    if (task == "fetchNextPrayerTask") {
      await homeController.fetchNextTime();
    } else if (task == "fetchDailyPrayersTask") {
      await homeController.fetchPrayersTimes();
    }

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1️⃣ setup Service Locator
  await setupServiceLocator();

  // 2️⃣ Initialize Workmanager
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

  await Workmanager().registerPeriodicTask(
    "1",
    "fetchNextPrayerTask",
    frequency: const Duration(minutes: 70),
    existingWorkPolicy: ExistingWorkPolicy.replace,
  );

  // fetch daily prayers كل 24 ساعة
  await Workmanager().registerPeriodicTask(
    "2",
    "fetchDailyPrayersTask",
    frequency: const Duration(hours: 24),
    existingWorkPolicy: ExistingWorkPolicy.replace,
  );

  // 4️⃣ run app with providers
  runApp(const AzkarkApp());
}
