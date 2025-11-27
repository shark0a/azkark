import 'package:azkark/Features/All_acts_of_worship/presentation/manager/azkar_provider.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/core/services/back_ground_service/notification_handler/notification_service.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:azkark/core/utils/cache/shared_pref_keys.dart';
import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:provider/provider.dart';

class SecondeSplashScreen extends StatefulWidget {
  const SecondeSplashScreen({super.key});

  @override
  State<SecondeSplashScreen> createState() => _SecondeSplashScreenState();
}

class _SecondeSplashScreenState extends State<SecondeSplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initApp();
    });
  }

  Future<void> _initApp() async {
    if (!mounted) return;
    final homeController = context.read<HomeController>();
    final azkarProvider = context.read<AzkarProvider>();
    final bool isFirstOpen =
        sl.get<SharedPref>().getBool(SharedPrefKeys.firstTimeOpen) ?? true;

    await azkarProvider.loadDataFromJson();
    final lastFetch = sl.get<SharedPref>().getInt('lastPrayerFetch');
    final now = DateTime.now().millisecondsSinceEpoch;
    const oneDayMillis = 24 * 60 * 60 * 1000;

    if (lastFetch == null || now - lastFetch > oneDayMillis) {
      if (lastFetch == null) {
        await homeController.initLocation();
      }
      await homeController.fetchPrayersTimes();
    } else {
      await homeController.loadingLocalData();
    }

    await azkarProvider.loadFavList();
    await homeController.fetchNextPrayer();
    if (isFirstOpen) {
      await NotificationService.instance.init();
      await NotificationService.instance.scheduleDailyPrayers();
    }

    // await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          color: Color(0xff00133F),
          image: DecorationImage(
            image: AssetImage("assets/Splash_2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("assets/seconde_Logo.svg")
                  .animate(
                    onComplete: (controller) {
                      context.go(AppRoutes.kHomeScreen);
                    },
                    delay: 200.ms,
                  )
                  .fadeIn(delay: 300.ms, curve: Curves.easeIn, duration: 800.ms)
                  .scale(
                    delay: 300.ms,
                    curve: Curves.easeInBack,
                    duration: 850.ms,
                  ),
              SizedBox(height: 30.h),
              // Animated loading spinner with pulse effect
              _isLoading
                  ? Column(
                      children: [
                        CircularProgressIndicator(
                              color: Colors.white,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white.withValues(alpha: 0.9),
                              ),
                            )
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .scale(
                              begin: const Offset(1.0, 1.0),
                              end: const Offset(1.1, 1.1),
                              duration: 1500.ms,
                              curve: Curves.easeInOut,
                            ),
                        SizedBox(height: 20.h),
                        Text(
                          S.of(context).loading,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Colors.white70,
                                fontSize: 16.sp,
                              ),
                        ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
