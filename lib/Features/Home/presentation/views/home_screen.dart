import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/views/setting_screen.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/_build_home_slivers.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/date_and_location_details.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
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
          style: TextStyle(color: Colors.red, fontSize: 18.sp),
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
                child: TextButton(
                  onPressed: () {
                    provider.toggleLocale();
                  },
                  child: Text("data"),
                ),
              ),
              SliverToBoxAdapter(
                child: DateAndLocationDetails(provider: provider),
              ),
              ...buildHomeSlivers(provider),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: provider.bottomNavigationIndex == 0
          ? null
          : PreferredSize(
              preferredSize: Size(double.infinity, 60.h),
              child: CustomizeHomeAppBar(
                title: S.of(context).prayer_title,
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
