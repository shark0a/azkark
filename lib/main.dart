import 'package:azkark/azkark_app.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const AzkarkApp());
}
