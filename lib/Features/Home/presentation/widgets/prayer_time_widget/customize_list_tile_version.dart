import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizeListTileVersion extends StatelessWidget {
  const CustomizeListTileVersion({
    super.key,
    required this.prayerTime,
    required this.prayerName,
    required this.active,
    required this.localizationKey,
    required this.prayerImage,
  });
  final String prayerTime;
  final bool active;
  final String prayerName;
  final String prayerImage;
  final String localizationKey;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Color.fromRGBO(245, 245, 245, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
      titleAlignment: ListTileTitleAlignment.center,
      trailing: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            prayerTime,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0x7F1E1E1E),
              fontSize: 18.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              // letterSpacing: -0.30,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            active ? Icons.volume_up_sharp : Icons.volume_off_rounded,
            color: active
                ? AppStyles.appBarTitleColor
                : AppStyles.inActiveColor,
          ),
          SizedBox(width: 10.w),
        ],
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            prayerImage,
            colorFilter: ColorFilter.mode(
              active ? AppStyles.appBarTitleColor : AppStyles.inActiveColor,
              BlendMode.srcIn,
            ),
            width: 25.5.w,
            height: 25.5.h,
          ),
          SizedBox(width: 19.5.w),
          Text(
            _getLocalizedPrayerName(context),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: active ? Colors.black : AppStyles.inActiveColor,
              fontSize: 18.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              letterSpacing: -0.30,
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
