import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class AkarkAppBody extends StatelessWidget {
  const AkarkAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: context.watch<HomeController>().locale,

      theme: ThemeData(scaffoldBackgroundColor: AppStyles.scaffoldBG),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.route,
    );
  }
}
