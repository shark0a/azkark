import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
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
  final String prayerTime;
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
            colorFilter: ColorFilter.mode(
              active ? Colors.white : Color(0xff005773).withValues(alpha: 0.56),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            prayerName,
            style: active ? AppStyles.semiblod14 : AppStyles.light14,
          ),
          const SizedBox(height: 1),
          Text(
            MehtodHelper.convertTimeTo12H(prayerTime),
            // prayerTime,
            style: active
                ? AppStyles.semiblod14.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  )
                : AppStyles.light14.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
          ),
        ],
      ),
    );
  }
}
