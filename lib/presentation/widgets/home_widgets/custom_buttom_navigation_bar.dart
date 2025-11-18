import 'package:azkark/core/utils/app_styles.dart';
import 'package:azkark/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButtomNavigationBar extends StatelessWidget {
  const CustomButtomNavigationBar({super.key, required this.provider});
  final HomeController provider;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppStyles.scaffoldBG,
      elevation: 1,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppStyles.activeColor,
      unselectedItemColor: AppStyles.inActiveColor,
      selectedLabelStyle: AppStyles.semiblod10,
      unselectedLabelStyle: AppStyles.medium10,
      currentIndex: provider.bottomNavigationIndex,
      onTap: (value) {
        provider.toggleBottomNavigationIndex(value);
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "الإعدادات"),
        BottomNavigationBarItem(
          icon: Icon(Icons.watch_later_outlined),
          label: "مواقيت الصلاة",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/bottom1.svg"),

          label: "الصفحة \nالرئيسية",
        ),
      ],
    );
  }
}
