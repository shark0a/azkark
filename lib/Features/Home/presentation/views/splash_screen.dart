import 'dart:developer';

import 'package:azkark/Features/All_acts_of_worship/presentation/manager/azkar_provider.dart';
import 'package:azkark/Features/Home/data/current_location_model.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/core/services/back_ground_service/notification_handler/notification_service.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/hive_keys.dart';
import 'package:azkark/core/utils/cache/hive_service.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:azkark/core/utils/cache/shared_pref_keys.dart';
import 'package:azkark/core/utils/helper/show_snack_bar.dart';
import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;
  bool _refetchNeeded = sl.get<SharedPref>().getBool("refetchNeeded") ?? false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => _initApp());
  }

  Future<void> _initApp() async {
    if (!mounted) return;

    final homeController = context.read<HomeController>();
    final azkarProvider = context.read<AzkarProvider>();
    final prefs = sl.get<SharedPref>();
    final isFirstOpen = prefs.getBool(SharedPrefKeys.firstTimeOpen) ?? true;

    // Load Azkar & favorites in parallel
    await Future.wait([
      azkarProvider.loadDataFromJson(),
      azkarProvider.loadFavList(),
    ]);
    final localCurrentLocation = await sl
        .get<HiveService>()
        .getData<CurrentLocationModel>(
          HiveKeys.locationBox,
          HiveKeys.locationKey,
        );

    log("message :${localCurrentLocation?.lat}");
    if (isFirstOpen == true || localCurrentLocation == null) {
      try {
        await homeController.initLocation();
        log("enter  here ");
        await homeController.fetchPrayersTimes();
        await NotificationService.instance.init();
        await NotificationService.instance.scheduleDailyPrayers();
        await homeController.fetchNextPrayer();

        log(
          "========================in spalshh i n first statues  scheduleDailyPrayers success===================",
        );
        await sl.get<SharedPref>().setBool(SharedPrefKeys.firstTimeOpen, false);
        try {
          OneSignal.Notifications.requestPermission(true);
        } catch (e) {}
      } catch (e) {
        showErrorSnackBar(context, S.current.LocationUpdatFAliure);
        log(
          'Initial fetch failed, will retry when connectivity is available: $e',
        );
        _refetchNeeded = true;
        await sl.get<SharedPref>().setBool("refetchNeeded", true);
        log(
          "========================in spalshh i n first statues  scheduleDailyPrayers faluire ${e.toString()}===================",
        );
      }
    }
    if (_refetchNeeded) {
      await _attemptRefetch(homeController);
      await homeController.fetchNextPrayer();
    }
    log("tis first ${isFirstOpen}");
    if (!isFirstOpen) {
      await homeController.loadingLocalData();
      await homeController.fetchNextPrayer();
    }

    await Future.delayed(const Duration(milliseconds: 200));

    const maxWaitMs = 5000;
    const pollInterval = 200;
    int waited = 0;
    while (mounted &&
        homeController.prayerTimesHive == null &&
        waited < maxWaitMs) {
      await Future.delayed(const Duration(milliseconds: pollInterval));
      waited += pollInterval;
    }

    if (mounted) setState(() => _isLoading = false);

    if (mounted) {
      await Future.delayed(Duration(milliseconds: 900));
      await homeController.fetchNextPrayer();

      context.go(AppRoutes.kHomeScreen);
    }
    ;
  }

  Future<void> _attemptRefetch(HomeController homeController) async {
    try {
      // Try to reinitialize location if missing
      await homeController.initLocation();
      await homeController.fetchPrayersTimes();
      await NotificationService.instance.init();
      await NotificationService.instance.scheduleDailyPrayers();
      await homeController.fetchNextPrayer();
      await sl.get<SharedPref>().setBool(SharedPrefKeys.firstTimeOpen, false);
      await sl.get<SharedPref>().setBool("refetchNeeded", false);
    } catch (e) {
      await sl.get<SharedPref>().setBool("refetchNeeded", true);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff00133F),
          image: DecorationImage(
            image: AssetImage("assets/Splash_2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: _isLoading
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset("assets/seconde_Logo.svg")
                        .animate(delay: 350.ms)
                        .fadeIn(delay: 400.ms, duration: 800.ms)
                        .scale(
                          delay: 400.ms,
                          curve: Curves.easeInBack,
                          duration: 850.ms,
                        ),
                    SizedBox(height: 30.h),
                    CircularProgressIndicator(
                      color: Colors.white,
                    ).animate().scale(
                      begin: const Offset(1.0, 1.0),
                      end: const Offset(1.1, 1.1),
                      duration: 1500.ms,
                      curve: Curves.easeInOut,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      S.of(context).loading,
                      style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                    ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
