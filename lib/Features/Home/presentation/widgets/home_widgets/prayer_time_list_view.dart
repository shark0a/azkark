import 'package:azkark/Features/All_acts_of_worship/data/prayer_icon_name_models.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/prayer_detail_container.dart';
import 'package:flutter/material.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      color: Color(0xffEDFBFF),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: provider.prayerTimesHive != null
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    provider.toggleNextPrayerTimeIndex(index);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index == 0
                          ? 0
                          : index == prayerIconAndTime.length - 1
                          ? 0
                          : 14,
                    ),
                    child: Center(
                      child: PrayerDetailContainer(
                        active: index == provider.nextprayerTimeIndex,
                        prayerName: prayerIconAndTime[index].name,
                        prayerTime: timesLocal[index],
                        prayerIcon: prayerIconAndTime[index].prayerIcon,
                      ),
                    ),
                  ),
                ),
                itemCount: prayerIconAndTime.length,
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    provider.toggleNextPrayerTimeIndex(index);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index == 0
                          ? 0
                          : index == prayerIconAndTime.length - 1
                          ? 0
                          : 14,
                    ),
                    child: Center(
                      child: PrayerDetailContainer(
                        active: index == provider.nextprayerTimeIndex,
                        prayerName: prayerIconAndTime[index].name,
                        prayerTime: timesApi[index],

                        prayerIcon: prayerIconAndTime[index].prayerIcon,
                      ),
                    ),
                  ),
                ),
                itemCount: prayerIconAndTime.length,
              ),
      ),
    );
  }
}
