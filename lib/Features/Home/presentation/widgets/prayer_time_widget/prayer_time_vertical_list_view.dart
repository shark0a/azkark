import 'package:azkark/Features/Home/presentation/widgets/prayer_time_widget/customize_list_tile_version.dart';
import 'package:flutter/material.dart';

class PrayerTimeVerticalListView extends StatelessWidget {
  const PrayerTimeVerticalListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/home2BG.png"),
        ),
      ),
      child: ListView.builder(
        itemCount: 6,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : 24),
          child: CustomizeListTileVersion(),
        ),
      ),
    );
  }
}
