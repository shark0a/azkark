import 'package:azkark/azkark_app.dart';
import 'package:azkark/core/services/back_ground_service/callback_dispatcher.dart';
import 'package:azkark/core/services/init/_init_services.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  runApp(const AzkarkApp());
  initServices();
}
