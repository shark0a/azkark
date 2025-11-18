import 'package:azkark/presentation/views/all_prayers.dart';
import 'package:azkark/presentation/views/azkar_evening.dart';
import 'package:azkark/presentation/views/azkar_morning.dart';
import 'package:azkark/presentation/views/azkar_prayers.dart';
import 'package:azkark/presentation/views/favourite_screen.dart';
import 'package:azkark/presentation/views/home_screen.dart';
import 'package:azkark/presentation/views/seconde_splash_screen.dart';
import 'package:azkark/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const kHomeScreen = "/homescreen";
  static const kSecondeSplashScreen = "/secondesplashscreen";
  static const kAzkarMorning = "/azkarMorning";
  static const kAzkarEvening = "/azkarEvening";
  static const kAzkarPrayers = "/azkarPrayers";
  static const kAllPrayers = "/allPrayers";
  static const kFavouriteScreen = "/favouriteScreen";
  static final route = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => SplashScreen()),
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
        path: kAzkarEvening,
        builder: (context, state) => const AzkarEvening(),
      ),
      GoRoute(
        path: kAzkarPrayers,
        builder: (context, state) => const AzkarPrayers(),
      ),
      GoRoute(
        path: kAllPrayers,
        builder: (context, state) => const AllPrayers(),
      ),
      GoRoute(
        path: kFavouriteScreen,
        builder: (context, state) => const FavouriteScreen(),
      ),
    ],
  );
}
