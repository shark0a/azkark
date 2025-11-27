import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/all_of_options.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/all_option_grid_view.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/prayer_time_banner.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/prayer_time_list_view.dart';
import 'package:azkark/Features/Home/presentation/widgets/prayer_time_widget/left_time_widget.dart';
import 'package:azkark/Features/Home/presentation/widgets/prayer_time_widget/prayer_time_vertical_list_view.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Widget> buildHomeSlivers(HomeController homeController) {
  final nextTimeKey =
      // homeController.nextPrayer?.nextTimingkey ??
      homeController.nextPrayerKeyLocal ?? "fajr";
  final nextTimeVlaue =
      // homeController.nextPrayer?.nextTimingValue ??
      // homeController.nextPrayerLocal?.nextTimingValue ??
      homeController.nextPrayerTimeLocal ?? "00:00";

  // Mapping prayer keys to localized strings
  String localizedNextPrayer;
  switch (nextTimeKey.toLowerCase()) {
    case "fajr":
      localizedNextPrayer = S.current.prayer_fajr;
      break;
    case "dhuhr":
      localizedNextPrayer = S.current.prayer_dhuhr;
      break;
    case "asr":
      localizedNextPrayer = S.current.prayer_asr;
      break;
    case "maghrib":
      localizedNextPrayer = S.current.prayer_maghrib;
      break;
    case "sunset":
    case "sunrise":
      localizedNextPrayer = S.current.prayer_sunrise;
      break;
    case "isha":
      localizedNextPrayer = S.current.prayer_isha;
      break;

    default:
      localizedNextPrayer = nextTimeKey;
  }

  if (homeController.bottomNavigationIndex == 0) {
    return [
      SliverToBoxAdapter(child: SizedBox(height: 8.h)),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 100.h,
          child: PrayerTimeHorezontalListView(provider: homeController),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 14.h)),
      SliverToBoxAdapter(
        child: PrayerTimeBanner(homeController: homeController),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 18.h)),
      SliverToBoxAdapter(child: AllOfOptions()),
      SliverToBoxAdapter(child: SizedBox(height: 18.h)),
      AllOptionGridView(),
      SliverFillRemaining(hasScrollBody: false, child: SizedBox(height: 18.h)),
    ];
  }
  return [
    SliverToBoxAdapter(child: SizedBox(height: 20.h)),
    SliverToBoxAdapter(child: SvgPicture.asset('assets/stopwatch.svg')),
    SliverToBoxAdapter(child: SizedBox(height: 20.h)),
    SliverToBoxAdapter(
      child: LeftTimeWidget(
        nextPrayer: localizedNextPrayer,
        leftTime: nextTimeVlaue,
      ),
    ),
    SliverToBoxAdapter(child: SizedBox(height: 20.h)),
    SliverToBoxAdapter(child: PrayerTimeVerticalListView()),
  ];
}
