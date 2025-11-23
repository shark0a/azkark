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
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            top: provider.bottomNavigationIndex == 0 ? 60 : 0,
          ),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: DateAndLocationDetails(provider: provider),
              ),
              ..._buildHomeSlivers(provider),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomButtomNavigationBar(provider: provider),
    );
  }
}

List<Widget> _buildHomeSlivers(HomeController provider) {
  switch (provider.bottomNavigationIndex) {
    case 0:
      return [
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 90,
            child: PrayerTimeHorezontalListView(provider: provider),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 14)),
        SliverToBoxAdapter(child: PrayerTimeBanner()),
        const SliverToBoxAdapter(child: SizedBox(height: 18)),
        SliverToBoxAdapter(child: AllOfOptions()),
        const SliverToBoxAdapter(child: SizedBox(height: 18)),
        AllOptionGridView(),
        const SliverFillRemaining(
          hasScrollBody: false,
          child: SizedBox(height: 18),
        ),
      ];
    // break;
    case 1:
      return [
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        SliverToBoxAdapter(child: SvgPicture.asset('assets/stopwatch.svg')),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        SliverToBoxAdapter(child: LeftTimeWidget()),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        SliverToBoxAdapter(child: PrayerTimeVerticalListView()),
      ];
    default:
      return [
        const SliverToBoxAdapter(
          child: Center(child: Text("Page not implemented")),
        ),
      ];
  }
}
