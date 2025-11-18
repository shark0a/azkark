import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SecondeSplashScreen extends StatelessWidget {
  const SecondeSplashScreen({super.key});

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
          child: SvgPicture.asset("assets/seconde_Logo.svg")
              .animate(
                delay: 850.ms,
                onComplete: (controller) {
                  context.go(AppRoutes.kHomeScreen);
                },
              )
              .fadeIn(curve: Curves.easeIn, duration: 800.ms)
              .scale(curve: Curves.easeInBack, duration: 800.ms),
        ),
      ),
    );
  }
}
