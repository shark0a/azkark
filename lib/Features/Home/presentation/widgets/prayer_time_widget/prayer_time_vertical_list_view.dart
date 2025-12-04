import 'package:azkark/Features/Home/data/prayer_time_page_model.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/prayer_time_widget/customize_list_tile_version.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PrayerTimeVerticalListView extends StatelessWidget {
  const PrayerTimeVerticalListView({super.key});
  @override
  Widget build(BuildContext context) {
    final homeController = context.read<HomeController>();
    List<String> timesApi = [
      homeController.prayerTimes?.timings.isha ?? "00:00",
      homeController.prayerTimes?.timings.maghrib ?? "00:00",
      homeController.prayerTimes?.timings.asr ?? "00:00",
      homeController.prayerTimes?.timings.dhuhr ?? "00:00",
      homeController.prayerTimes?.timings.sunrise ?? "00:00",
      homeController.prayerTimes?.timings.fajr ?? "00:00",
    ];
    List<String> timesLocal = [
      homeController.prayerTimesHive?.timings.isha ?? "00:00",
      homeController.prayerTimesHive?.timings.maghrib ?? "00:00",
      homeController.prayerTimesHive?.timings.asr ?? "00:00",
      homeController.prayerTimesHive?.timings.dhuhr ?? "00:00",
      homeController.prayerTimesHive?.timings.sunrise ?? "00:00",
      homeController.prayerTimesHive?.timings.fajr ?? "00:00",
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/home2BG.png"),
        ),
      ),
      child: homeController.prayerTimesHive != null
          ? ListView.builder(
              itemCount: prayersTimePageItems.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                // Map index to prayer keys to match activePrayers keys
                final prayerKeys = [
                  'isha',
                  'maghrib',
                  'asr',
                  'dhuhr',
                  'sunrise',
                  'fajr',
                ];
                final prayerKey = prayerKeys[index];

                return Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 24.h),
                  child: GestureDetector(
                    onTap: () {
                      homeController.toggleActive(prayerKey: prayerKey);
                    },
                    child: CustomizeListTileVersion(
                      prayerImage: prayersTimePageItems[index].prayerImage,

                      prayerName: prayersTimePageItems[index].name,
                      // prayerTime: timesLocal[index],
                      prayerTime: MehtodHelper.convertTimeTo12H(
                        timesLocal[index],
                        // lang,
                      ),
                      active: prayersTimePageItems[index].prayerKey.contains(
                        homeController.nextPrayerKeyLocal!.toLowerCase(),
                      ),
                      localizationKey:
                          prayersTimePageItems[index].localizationKey,
                    ),
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: prayersTimePageItems.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final prayerKeys = [
                  'isha',
                  'maghrib',
                  'asr',
                  'dhuhr',
                  'sunrise',
                  'fajr',
                ];
                final prayerKey = prayerKeys[index];
                return Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 24),
                  child: GestureDetector(
                    onTap: () {
                      homeController.toggleActive(prayerKey: prayerKey);
                    },
                    child: CustomizeListTileVersion(
                      prayerImage: prayersTimePageItems[index].prayerImage,
                      active: prayersTimePageItems[index].prayerKey.contains(
                        homeController.nextPrayerKeyLocal!.toLowerCase(),
                      ),
                      prayerName: prayersTimePageItems[index].name,
                      // prayerTime: timesApi[index],
                      prayerTime: MehtodHelper.convertTimeTo12H(
                        timesApi[index],
                        // lang,
                      ),
                      localizationKey:
                          prayersTimePageItems[index].localizationKey,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
