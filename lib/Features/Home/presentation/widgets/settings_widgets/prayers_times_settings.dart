
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/prasise_widget/customize_list_tile.dart';
import 'package:azkark/Features/Home/data/prayer_time_page_model.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/customize_app_bar.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:azkark/core/utils/cache/shared_pref_keys.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PrayersTimesSettings extends StatelessWidget {
  const PrayersTimesSettings({super.key});

  String _localizedPrayer(BuildContext context, String key) {
    final s = S.of(context);
    switch (key) {
      case 'prayer_isha':
        return s.prayer_isha;
      case 'prayer_maghrib':
        return s.prayer_maghrib;
      case 'prayer_asr':
        return s.prayer_asr;
      case 'prayer_dhuhr':
        return s.prayer_dhuhr;
      case 'prayer_sunrise':
        return s.prayer_sunrise;
      case 'prayer_fajr':
        return s.prayer_fajr;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeController>();
    final hive = home.prayerTimesHive;
    final lang = sl.get<SharedPref>().getString(SharedPrefKeys.langKey);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60.h),
        child: CustomizeAppBar(
          onTap: () {
            context.go(AppRoutes.kSettingScreen);
          },
          title: S.of(context).prayer_times_label,
        ),
      ),
      body: ListView.builder(
        itemCount: prayersTimePageItems.length,
        itemBuilder: (context, index) {
          final prayer = prayersTimePageItems[index];
          final localized = _localizedPrayer(context, prayer.localizationKey);
          final isActive = hive?.activePrayers[prayer.prayerKey] ?? true;
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CustomizeListTile(
              activeleading: true,
              title: localized,
              tralling: GestureDetector(
                onTap: () async {
                  // toggle active via controller
                  await home.toggleActive(prayerKey: prayer.prayerKey);
                },
                child: Icon(
                  size: 60.r,

                  isActive
                      ? lang == 'ar'
                            ? Icons.toggle_off_sharp
                            : Icons.toggle_on_sharp
                      : lang == 'ar'
                      ? Icons.toggle_on_sharp
                      : Icons.toggle_off,
                  color: isActive
                      ? AppStyles.appBarTitleColor
                      : AppStyles.inActiveColor,
                ),
              ),
              active: isActive,
            ),
          );
        },
      ),
    );
  }
}
