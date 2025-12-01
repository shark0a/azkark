import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizeAppBar extends StatelessWidget {
  const CustomizeAppBar({super.key, required this.title, this.onTap});
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: AppStyles.scaffoldBG,
      surfaceTintColor: AppStyles.scaffoldBG,
      centerTitle: true,
      leading: IconButton(
        onPressed: onTap,

        icon: Icon(
          Icons.arrow_back_outlined,
          color: AppStyles.appBarTitleColor,
        ),
      ),
      title: Text(
        textDirection: TextDirection.rtl,
        title,
        style: AppStyles.semiblod18.copyWith(fontSize: 20.sp),
      ),
    );
  }
}
