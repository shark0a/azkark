import 'package:azkark/azkark_app.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (_) => const AzkarkApp()),
  );
}
