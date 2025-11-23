import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:flutter/material.dart';

class CustomizeListTile extends StatelessWidget {
  const CustomizeListTile({
    super.key,
    required this.title,
    required this.leading,
    required this.active,
  });
  final String title;
  final Widget? leading;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: active ? Color(0xffEDFBFF) : Color(0xffF5F5F5),
      title: Text(
        title,
        textDirection: TextDirection.rtl,

        style: AppStyles.regular16,
      ),
      titleAlignment: ListTileTitleAlignment.center,
      leading: leading,
    );
  }
}
