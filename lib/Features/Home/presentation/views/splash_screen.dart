import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/manager/azkar_provider.dart';
import 'package:azkark/core/utils/cache/shared_pref_keys.dart';
import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? first;

  @override
  void initState() {
    super.initState();
       context.read<HomeController>().initLocation();
       context.read<HomeController>().fetchPrayersTimes();

    first = sl.get<SharedPref>().getBool(SharedPrefKeys.firstTimeOpen);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (first == null || first == true) {
      //   sl.get<SharedPref>().setBool(SharedPrefKeys.firstTimeOpen, false);

      //   context.read<AppProvider>().loadDataFromJson();
      // }
      context.read<AzkarProvider>().loadDataFromJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/first_splash_BG.png"),
            ),
          ),
          child: Column(
            children: [
              Padding(
                    padding: const EdgeInsets.only(top: 173),
                    child: Image.asset("assets/first_splash_logo.png"),
                  )
                  .animate(delay: (first == null ? 2000.ms : 1000.ms))
                  .slideY(
                    begin: -0.5,
                    end: 0,
                    curve: Curves.easeIn,
                    duration: 800.ms,
                  ),
              Text(
                    'Quran Kareem',
                    textAlign: TextAlign.center,
                    style: AppStyles.blod20.copyWith(
                      color: Colors.white.withValues(alpha: 0.95),
                    ),
                  )
                  .animate(
                    delay: 1000.ms,
                    onComplete: (controller) {
                      context.go(AppRoutes.kSecondeSplashScreen);
                    },
                  )
                  .slideY(
                    begin: 0.5,
                    end: 0,
                    curve: Curves.easeIn,
                    duration: 850.ms,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
