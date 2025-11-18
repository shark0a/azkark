import 'package:azkark/core/utils/app_styles.dart';
import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AkarkAppBody extends StatelessWidget {
  const AkarkAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale('ar', 'Eg'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: ThemeData(scaffoldBackgroundColor: AppStyles.scaffoldBG),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.route,
    );
  }
}
