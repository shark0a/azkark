import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:go_router/go_router.dart';

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

      selectedLabelStyle: AppStyles.semiblod10.copyWith(fontSize: 13.sp),
      unselectedLabelStyle: AppStyles.medium10.copyWith(fontSize: 12.sp),
      currentIndex: provider.bottomNavigationIndex,
      onTap: (value) {
        provider.toggleBottomNavigationIndex(value);
        if (value == 0) {
          context.go(AppRoutes.kHomeScreen);
        }
        if (value == 1) {
          provider.fetchNextPrayer();
          context.go(AppRoutes.kHomeScreen);
        }
        if (value == 2) {
          context.go(AppRoutes.kSettingScreen);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/bottom1.svg",
            colorFilter: ColorFilter.mode(
              AppStyles.inActiveColor,
              BlendMode.srcIn,
            ),
          ),
          label: S.of(context).home_page_label,
          activeIcon: SvgPicture.asset(
            "assets/bottom1.svg",
            colorFilter: ColorFilter.mode(
              AppStyles.activeColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.watch_later_outlined),
          label: S.of(context).prayer_times_label,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: S.of(context).settings_label,
        ),
      ],
    );
  }
}
