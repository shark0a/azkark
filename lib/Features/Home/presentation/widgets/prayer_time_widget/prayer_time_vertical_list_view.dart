import 'package:azkark/Features/Home/data/prayer_time_page_model.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/prayer_time_widget/customize_list_tile_version.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrayerTimeVerticalListView extends StatelessWidget {
  const PrayerTimeVerticalListView({super.key});
  @override
  Widget build(BuildContext context) {
    final homeController = context.read<HomeController>();
    final List<String> times = [
      homeController.prayerTimes!.timings.isha,
      homeController.prayerTimes!.timings.maghrib,
      homeController.prayerTimes!.timings.asr,
      homeController.prayerTimes!.timings.dhuhr,
      homeController.prayerTimes!.timings.sunrise,
      homeController.prayerTimes!.timings.fajr,
    ];
    // final List<String> times = [
    //   homeController.prayerTimesHive!.timings.isha,
    //   homeController.prayerTimesHive!.timings.maghrib,
    //   homeController.prayerTimesHive!.timings.asr,
    //   homeController.prayerTimesHive!.timings.dhuhr,
    //   homeController.prayerTimesHive!.timings.sunrise,
    //   homeController.prayerTimesHive!.timings.fajr,
    // ];
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/home2BG.png"),
        ),
      ),
      child: ListView.builder(
        itemCount: prayersTimePageItems.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : 24),
          child: CustomizeListTileVersion(
            prayerName: prayersTimePageItems[index].name,
            prayerTime: MehtodHelper.convertTimeTo12H(times[index]),
          ),
        ),
      ),
    );
  }
}
