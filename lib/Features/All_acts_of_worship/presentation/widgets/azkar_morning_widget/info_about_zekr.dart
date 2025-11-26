import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/azkar_morning_widget/number_of_count_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoAboutZekr extends StatelessWidget {
  const InfoAboutZekr({
    super.key,
    required this.info,
    required this.countOfZekr,
    required this.onTap,
    required this.isFav,
  });
  final String info;
  final ValueNotifier<int> countOfZekr;
  final void Function() onTap;
  final bool isFav;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 305.w,
          child: Text(
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: AppStyles.regular10.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
            info,
          ),
        ),
        SizedBox(height: 17.87.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.share, color: Color(0xff005773), size: 40.r),
            SizedBox(width: 8.w),
            Icon(Icons.edit, color: Color(0xff005773), size: 40.r),
            SizedBox(width: 8.w),
            NumberOfCountContainer(countOfZekr: countOfZekr),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onTap,
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Color(0xff005773),
                size: 40.r,
              ),
            ),
            SizedBox(width: 8.w),
          ],
        ),
        SizedBox(height: 17.56.h),
      ],
    );
  }
}
