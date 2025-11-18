import 'package:azkark/presentation/controller/home_controller.dart';
import 'package:azkark/presentation/widgets/home_widgets/all_of_options.dart';
import 'package:azkark/presentation/widgets/home_widgets/all_option_grid_view.dart';
import 'package:azkark/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:azkark/presentation/widgets/home_widgets/date_and_location_details.dart';
import 'package:azkark/presentation/widgets/home_widgets/prayer_time_banner.dart';
import 'package:azkark/presentation/widgets/home_widgets/prayer_time_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    final provider = context.watch<HomeController>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 60),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: DateAndLocationDetails()),
            SliverToBoxAdapter(child: const SizedBox(height: 8)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 90,
                child: PrayerTimeListView(provider: provider),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 14)),
            SliverToBoxAdapter(child: PrayerTimeBanner()),
            SliverToBoxAdapter(child: const SizedBox(height: 18)),
            SliverToBoxAdapter(child: AllOfOptions()),
            SliverToBoxAdapter(child: const SizedBox(height: 18)),
            AllOptionGridView(),
            SliverFillRemaining(
              hasScrollBody: false,
              child: const SizedBox(height: 18),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomButtomNavigationBar(provider: provider),
    );
  }
}
