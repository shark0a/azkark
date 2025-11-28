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
  runApp(const AzkarkApp());
}
