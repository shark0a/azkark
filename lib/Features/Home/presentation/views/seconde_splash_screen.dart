import 'package:azkark/Features/All_acts_of_worship/presentation/manager/azkar_provider.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:azkark/core/utils/cache/shared_pref_keys.dart';
import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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

    final lastFetch = sl.get<SharedPref>().getInt('lastPrayerFetch');
    final now = DateTime.now().millisecondsSinceEpoch;
    const oneDayMillis = 24 * 60 * 60 * 1000;

    if (lastFetch == null || now - lastFetch > oneDayMillis) {
      if (lastFetch == null) await homeController.initLocation();
      await homeController.fetchPrayersTimes();
      sl.get<SharedPref>().setInt('lastPrayerFetch', now);
    } else {
      homeController.loadingLocalData();
    }

    final firstTime = sl.get<SharedPref>().getBool(
      SharedPrefKeys.firstTimeOpen,
    );
    if (firstTime == null || firstTime) {
      sl.get<SharedPref>().setBool(SharedPrefKeys.firstTimeOpen, false);
      await azkarProvider.loadDataFromJson();
    } else {
      // await azkarProvider.loadAzkarFromHive();
      await azkarProvider.loadDataFromJson();
      await azkarProvider.loadFavList();
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      await Future.delayed(const Duration(milliseconds: 850));
      if (!mounted) return;
      context.go(AppRoutes.kSplashScreen);
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
          child: AnimatedOpacity(
            opacity: _isLoading ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            onEnd: () {
              if (!_isLoading && mounted) {}
            },
            child: _isLoading
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset("assets/seconde_Logo.svg")
                          .animate(delay: 850.ms)
                          .fadeIn(curve: Curves.easeIn, duration: 1000.ms)
                          .scale(curve: Curves.easeInBack, duration: 1000.ms),
                      const SizedBox(height: 30),
                      // Animated loading spinner with pulse effect
                      CircularProgressIndicator(
                            color: Colors.white,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.9),
                            ),
                          )
                          .animate(onPlay: (controller) => controller.repeat())
                          .scale(
                            begin: const Offset(1.0, 1.0),
                            end: const Offset(1.1, 1.1),
                            duration: 1500.ms,
                            curve: Curves.easeInOut,
                          ),
                      const SizedBox(height: 20),
                      Text(
                        'جاري التحميل...',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
