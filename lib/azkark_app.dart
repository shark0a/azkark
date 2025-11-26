import 'package:azkark/Features/Home/domain/home_repo.dart';
import 'package:azkark/akark_app_body.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/manager/azkar_provider.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AzkarkApp extends StatelessWidget {
  const AzkarkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => HomeController(homeRepo: sl.get<HomeRepo>()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  AzkarProvider(mehtodHelper: sl.get<MehtodHelper>()),
            ),
          ],
          child: child,
        );
      },
      child: const AkarkAppBody(),
    );
  }
}
