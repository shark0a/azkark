import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberOfCountContainer extends StatelessWidget {
  const NumberOfCountContainer({
    super.key,
    required this.countOfZekr,
    required this.onCountContainerTap,
  });

  final int countOfZekr;
  final void Function() onCountContainerTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCountContainerTap,
      child: Container(
        width: 50.w,
        height: 50.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: countOfZekr <= 0 ? Color(0xff01B7F1) : null,
          shape: BoxShape.circle,
          border: Border.all(color: Color(0xff01B7F1), width: 3.w),
        ),
        child: countOfZekr > 0
            ? Text(
                '$countOfZekr',
                style: AppStyles.semiblod14.copyWith(color: Color(0xff01B7F1)),
              )
            : Icon(Icons.check, color: AppStyles.scaffoldBG, size: 20.sp),
      ),
    );
  }
}
