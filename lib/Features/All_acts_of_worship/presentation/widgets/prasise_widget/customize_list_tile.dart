import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizeListTile extends StatelessWidget {
  const CustomizeListTile({
    super.key,
    required this.title,
    required this.tralling,
    required this.active,
    required this.activeleading,
  });
  final String title;
  final Widget? tralling;
  final bool activeleading;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      tileColor: const Color.fromARGB(71, 23, 49, 71),
      titleAlignment: ListTileTitleAlignment.center,
      title: Text(title, style: AppStyles.regular16),
      trailing: tralling,
      leading: activeleading
          ? Icon(
              active ? Icons.volume_up_sharp : Icons.volume_off_rounded,
              color: active
                  ? AppStyles.appBarTitleColor
                  : AppStyles.inActiveColor,
            )
          : null,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
