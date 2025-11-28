import 'package:azkark/azkark_app.dart';
import 'package:azkark/core/services/back_ground_service/callback_dispatcher.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:azkark/core/services/service_locator.dart';

@pragma('vm:entry-point')
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

  await Workmanager().registerOneOffTask(
    "fetch_today_prayers",
    "fetchDailyPrayersTask",
  );

  runApp(const AzkarkApp());
}
