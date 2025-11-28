import 'package:azkark/Features/All_acts_of_worship/presentation/views/all_prayers.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/views/azkar_evening.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/views/azkar_morning.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/views/azkar_praise_est.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/views/azkar_prayers.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/views/electronic.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/views/favourite_screen.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/views/islamic_calendar.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/views/praise_srceen.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/views/various_azkar_screen.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/various_azkr_widgets/various_zekr.dart';
import 'package:azkark/Features/Home/presentation/views/home_screen.dart';
import 'package:azkark/Features/Home/presentation/views/seconde_splash_screen.dart';
import 'package:azkark/Features/Home/presentation/views/setting_screen.dart';
import 'package:azkark/Features/Home/presentation/views/splash_screen.dart';
import 'package:azkark/Features/Home/presentation/views/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const kHomeScreen = "/homescreen";
  static const kSettingScreen = "/SettingScreen";

  static const kSplashScreen = "/SplashScreen";
  static const kSecondeSplashScreen = "/secondesplashscreen";
  static const kAzkarMorning = "/azkarMorning";
  static const kAzkarEvening = "/azkarEvening";
  static const kAzkarPrayers = "/azkarPrayers";
  static const kAllPrayers = "/allPrayers";
  static const kPraiseSrceen = "/PraiseSrceen";
  static const kElectronic = "/Electronic";
  static const kIslamicCalendar = "/IslamicCalendar";
  static const kAzkarPraiseEst = "/AzkarPraiseEst";
  static const kFavouriteScreen = "/favouriteScreen";
  static const kVariousAzkar = "/VariousAzkar";
  static const kVariousZekr = "/VariousZekr";
  // static const kNotificationTestScreen = "/NotificationTestScreen";
  static final route = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => SecondeSplashScreen()),
      GoRoute(
        path: kSecondeSplashScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SecondeSplashScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },

            transitionDuration: const Duration(milliseconds: 600),
          );
        },
      ),
      GoRoute(
        path: kHomeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: kAzkarMorning,
        builder: (context, state) => const AzkarMorning(),
      ),
      GoRoute(
        path: kSplashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: kAzkarEvening,
        builder: (context, state) => const AzkarEvening(),
      ),
      GoRoute(
        path: kAzkarPrayers,
        builder: (context, state) => const AzkarPrayers(),
      ),
      // GoRoute(
      //   path: kNotificationTestScreen,
      //   builder: (context, state) => const NotificationTestScreen(),
      // ),
      GoRoute(
        path: kAllPrayers,
        builder: (context, state) => const AllPrayers(),
      ),
      GoRoute(
        path: kFavouriteScreen,
        builder: (context, state) => const FavouriteScreen(),
      ),
      GoRoute(
        path: kPraiseSrceen,
        builder: (context, state) => const PraiseSrceen(),
      ),
      GoRoute(
        path: kElectronic,
        builder: (context, state) => const Electronic(),
      ),

      GoRoute(
        path: kIslamicCalendar,
        builder: (context, state) => IslamicCalendar(),
      ),
      GoRoute(
        path: kAzkarPraiseEst,
        builder: (context, state) => const AzkarPraiseEst(),
      ),
      GoRoute(
        path: kVariousAzkar,
        builder: (context, state) => const VariousAzkarScreen(),
      ),
      GoRoute(
        path: kVariousZekr,
        builder: (context, state) => const VariousZekr(),
      ),
      GoRoute(
        path: kSettingScreen,
        builder: (context, state) => const SettingScreen(),
      ),
    ],
  );
}
