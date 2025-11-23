import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AkarkAppBody extends StatelessWidget {
  const AkarkAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      supportedLocales: S.delegate.supportedLocales,
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
