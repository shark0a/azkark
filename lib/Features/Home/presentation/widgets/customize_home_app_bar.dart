import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizeHomeAppBar extends StatelessWidget {
  const CustomizeHomeAppBar({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: AppStyles.scaffoldBG,
      surfaceTintColor: AppStyles.scaffoldBG,
      centerTitle: true,

      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textDirection: TextDirection.rtl,
            style: AppStyles.semiblod18.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(width: 10.w),
          icon,
        ],
      ),
    );
  }
}
