import 'package:azkark/Features/Home/data/prayer_time_page_model.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/prayer_detail_container.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTimeHorezontalListView extends StatelessWidget {
  const PrayerTimeHorezontalListView({super.key, required this.provider});

  final HomeController provider;

  @override
  Widget build(BuildContext context) {
    List<String> timesApi = [
      provider.prayerTimes?.timings.isha ?? "00:00",
      provider.prayerTimes?.timings.maghrib ?? "00:00",
      provider.prayerTimes?.timings.asr ?? "00:00",
      provider.prayerTimes?.timings.dhuhr ?? "00:00",
      provider.prayerTimes?.timings.sunrise ?? "00:00",
      provider.prayerTimes?.timings.fajr ?? "00:00",
    ];
    List<String> timesLocal = [
      provider.prayerTimesHive?.timings.isha ?? "00:00",
      provider.prayerTimesHive?.timings.maghrib ?? "00:00",
      provider.prayerTimesHive?.timings.asr ?? "00:00",
      provider.prayerTimesHive?.timings.dhuhr ?? "00:00",
      provider.prayerTimesHive?.timings.sunrise ?? "00:00",
      provider.prayerTimesHive?.timings.fajr ?? "00:00",
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        color: AppStyles.azkarContainerBG,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: provider.prayerTimesHive != null
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      right: index == 0
                          ? 0.w
                          : index == prayersTimePageItems.length - 1
                          ? 0.w
                          : 14.w,
                    ),
                    child: Center(
                      child: PrayerDetailContainer(
                        active: prayersTimePageItems[index].localizationKey
                            .toLowerCase()
                            .contains(
                              provider.nextPrayerKeyLocal?.toLowerCase() ?? "",
                            ),
                        prayerName: prayersTimePageItems[index].name,
                        prayerTime: timesLocal[index],
                        prayerIcon: prayersTimePageItems[index].prayerImage,
                        localizationKey:
                            prayersTimePageItems[index].localizationKey,
                      ),
                    ),
                  ),
                  itemCount: prayersTimePageItems.length,
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      right: index == 0
                          ? 0.w
                          : index == prayersTimePageItems.length - 1
                          ? 0.w
                          : 14.w,
                    ),
                    child: Center(
                      child: PrayerDetailContainer(
                        active: prayersTimePageItems[index].localizationKey
                            .toLowerCase()
                            .contains(
                              provider.nextPrayerKeyLocal?.toLowerCase() ?? "",
                            ),
                        prayerName: prayersTimePageItems[index].name,
                        prayerTime: timesApi[index],
                        prayerIcon: prayersTimePageItems[index].prayerImage,
                        localizationKey:
                            prayersTimePageItems[index].localizationKey,
                      ),
                    ),
                  ),
                  itemCount: prayersTimePageItems.length,
                ),
        ),
      ),
    );
  }
}
