import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerDetailContainer extends StatelessWidget {
  const PrayerDetailContainer({
    super.key,
    required this.prayerName,
    required this.prayerIcon,
    required this.prayerTime,
    required this.active,
    required this.localizationKey,
  });
  final String prayerName;
  final String prayerIcon;
  final String prayerTime;
  final bool active;
  final String localizationKey;
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: ShapeDecoration(
        color: active ? Color(0xff01B7F1) : Color(0xffEDFBFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
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
          SizedBox(height: 2.h),
          Text(
            _getLocalizedPrayerName(context),
            style: active ? AppStyles.semiblod14 : AppStyles.light14,
          ),
          SizedBox(height: 1.h),
          Text(
            MehtodHelper.convertTimeTo12H(prayerTime, ),
            // prayerTime,
            style: active
                ? AppStyles.semiblod14.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  )
                : AppStyles.light14.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
          ),
        ],
      ),
    );
  }

  String _getLocalizedPrayerName(BuildContext context) {
    final S l10n = S.of(context);
    switch (localizationKey) {
      case 'prayer_isha':
        return l10n.prayer_isha;
      case 'prayer_maghrib':
        return l10n.prayer_maghrib;
      case 'prayer_asr':
        return l10n.prayer_asr;
      case 'prayer_dhuhr':
        return l10n.prayer_dhuhr;
      case 'prayer_sunrise':
        return l10n.prayer_sunrise;
      case 'prayer_fajr':
        return l10n.prayer_fajr;
      default:
        return prayerName;
    }
  }
}
