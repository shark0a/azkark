import 'package:azkark/akark_app_body.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:azkark/core/utils/helper/provider/app_provider.dart';
import 'package:azkark/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AzkarkApp extends StatelessWidget {
  const AzkarkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(
          create: (context) =>
              AppProvider(mehtodHelper: sl.get<MehtodHelper>()),
        ),
      ],
      child: AkarkAppBody(),
    );
  }
}
