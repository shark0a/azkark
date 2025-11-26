import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkark/generated/l10n.dart';

class LeftTimeWidget extends StatelessWidget {
  const LeftTimeWidget({
    super.key,
    required this.leftTime,
    required this.nextPrayer,
  });
  final String leftTime;
  final String nextPrayer;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              S.of(context).time_left_label,
              style: AppStyles.regular12.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              textDirection: TextDirection.rtl,
              " ${S.of(context).for_prayer_prefix}$nextPrayer",
              style: AppStyles.regular16.copyWith(
                color: AppStyles.appBarTitleColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(width: 19.w),
        Column(
          children: [
            StreamBuilder<String>(
              stream: MehtodHelper.timeLeftStream(leftTime),
              builder: (context, asyncSnapshot) {
                return Text(
                  "-${asyncSnapshot.data ?? '00:00'}",
                  style: AppStyles.light15.copyWith(
                    fontSize: 20.sp,
                    color: AppStyles.inActiveColor,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
