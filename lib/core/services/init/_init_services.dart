import 'dart:developer';

import 'package:azkark/core/utils/helper/secret/secret_keys.dart';
import 'package:azkark/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:workmanager/workmanager.dart';

Future<void> initServices() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    FlutterError.onError = (errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    OneSignal.initialize(oneSignalSecretKey);
    // Requesting OneSignal runtime permission requires an active UI context.
    // The permission prompt will be requested from the UI (splash screen) after runApp().

    await Workmanager().registerOneOffTask(
      "fetch_today_prayers",
      "fetchDailyPrayersTask",
    );
  } catch (e) {
    log(e.toString());
    print("+++++++++++++++++++++++++++++++++++++++++++" + e.toString());
  }
}
