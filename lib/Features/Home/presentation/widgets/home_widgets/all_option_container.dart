import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllOptionContainer extends StatelessWidget {
  const AllOptionContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.localizationKey,
  });
  final String icon;
  final String title;
  final String localizationKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withAlpha(60),
            blurRadius: 19.52.r,
            offset: Offset(0, 2.44.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, width: 30.w, height: 30.h),
          SizedBox(height: 4.h),
          Text(
            maxLines: 2,
            textAlign: TextAlign.center,
            _getLocalizedTitle(context),
            style: AppStyles.semiblod14.copyWith(
              color: Color(0xff348698),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  String _getLocalizedTitle(BuildContext context) {
    final S l10n = S.of(context);
    switch (localizationKey) {
      case 'azkar_evening':
        return l10n.azkar_evening;
      case 'azkar_morning':
        return l10n.azkar_morning;
      case 'azkar_prayer':
        return l10n.azkar_prayer;
      case 'all_duas':
        return l10n.all_duas;
      case 'tasbih':
        return l10n.tasbih;
      case 'hijri_calendar':
        return l10n.hijri_calendar;
      case 'favorites':
        return l10n.favorites;
      case 'nearest_mosq':
        return l10n.nearest_mosq;
      case 'VariuosAzkar':
        return l10n.VariuosAzkar;
      default:
        return title;
    }
  }
}
