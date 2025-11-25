import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/views/setting_screen.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/all_of_options.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/all_option_grid_view.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/date_and_location_details.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/prayer_time_banner.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/prayer_time_list_view.dart';
import 'package:azkark/Features/Home/presentation/widgets/prayer_time_widget/left_time_widget.dart';
import 'package:azkark/Features/Home/presentation/widgets/prayer_time_widget/prayer_time_vertical_list_view.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:azkark/core/utils/cache/shared_pref_keys.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    final provider = context.watch<HomeController>();

    Widget bodyContent;

    if (provider.isLoadingLocation || provider.isFetchingPrayerTimes) {
      bodyContent = const Center(child: CircularProgressIndicator());
    } else if (provider.errorMsg.isNotEmpty) {
      bodyContent = Center(
        child: Text(
          provider.errorMsg,
          style: const TextStyle(color: Colors.red, fontSize: 18),
        ),
      );
    } else {
      bodyContent = SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            top: provider.bottomNavigationIndex == 0 ? 60 : 0,
          ),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: IconButton(
                  onPressed: () {
                    provider.toggleLocale();
                  },
                  icon: Text("data"),
                ),
              ),
              SliverToBoxAdapter(
                child: DateAndLocationDetails(provider: provider),
              ),
              ..._buildHomeSlivers(provider),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: provider.bottomNavigationIndex == 0
          ? null
          : PreferredSize(
              preferredSize: Size(double.infinity, 60),
              child: CustomizeHomeAppBar(
                title: "وقت الصلاة",
                icon: Icon(
                  Icons.watch_later_outlined,
                  color: AppStyles.appBarTitleColor,
                ),
              ),
            ),
      body: bodyContent,
      bottomNavigationBar: CustomButtomNavigationBar(provider: provider),
    );
  }
}

List<Widget> _buildHomeSlivers(HomeController homeController) {
  final Map<String, String> arabicNames = {
    "Fajr": "الفجر",
    "Dhuhr": "الظهر",
    "Asr": "العصر",
    "Maghrib": "المغرب",
    "Isha": "العشاء",
  };

  final nextTimeKey =
      homeController.nextPrayer?.nextTimingkey ??
      homeController.nextPrayerLocal?.nextTimingkey ??
      "";
  final nextTimeVlaue =
      homeController.nextPrayer?.nextTimingValue ??
      homeController.nextPrayerLocal?.nextTimingValue ??
      "00:00";

  final isArabic =
      sl.get<SharedPref>().getString(SharedPrefKeys.langKey) == 'ar';

  final nextTimeName = isArabic ? arabicNames[nextTimeKey] : nextTimeKey;
  if (homeController.bottomNavigationIndex == 0) {
    return [
      const SliverToBoxAdapter(child: SizedBox(height: 8)),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 100,
          child: PrayerTimeHorezontalListView(provider: homeController),
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 14)),
      SliverToBoxAdapter(
        child: PrayerTimeBanner(homeController: homeController),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 18)),
      SliverToBoxAdapter(child: AllOfOptions()),
      const SliverToBoxAdapter(child: SizedBox(height: 18)),
      AllOptionGridView(),
      const SliverFillRemaining(
        hasScrollBody: false,
        child: SizedBox(height: 18),
      ),
    ];
  }
  return [
    const SliverToBoxAdapter(child: SizedBox(height: 20)),
    SliverToBoxAdapter(child: SvgPicture.asset('assets/stopwatch.svg')),
    const SliverToBoxAdapter(child: SizedBox(height: 20)),
    SliverToBoxAdapter(
      child: LeftTimeWidget(
        nextPrayer: nextTimeName ?? "",
        leftTime: nextTimeVlaue,
      ),
    ),
    const SliverToBoxAdapter(child: SizedBox(height: 20)),
    SliverToBoxAdapter(child: PrayerTimeVerticalListView()),
  ];
}
