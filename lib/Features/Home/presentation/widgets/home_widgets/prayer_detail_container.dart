import 'package:azkark/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrayerDetailContainer extends StatelessWidget {
  const PrayerDetailContainer({
    super.key,
    required this.prayerName,
    required this.prayerIcon,
    required this.prayerTime,
    required this.active,
  });
  final String prayerName;
  final String prayerIcon;
  final TimeOfDay prayerTime;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: ShapeDecoration(
        color: active ? Color(0xff01B7F1) : Color(0xffEDFBFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            prayerIcon,
            color: active
                ? Colors.white
                : Color(0xff005773).withValues(alpha: 0.56),
          ),
          const SizedBox(height: 2),
          Text(
            prayerName,
            style: active ? AppStyles.semiblod14 : AppStyles.light14,
          ),
          const SizedBox(height: 1),
          Text(
            "${prayerTime.hour}:${prayerTime.minute}",
            style: active
                ? AppStyles.semiblod14.copyWith(fontSize: 9)
                : AppStyles.light14.copyWith(fontSize: 9),
          ),
        ],
      ),
    );
  }
}
