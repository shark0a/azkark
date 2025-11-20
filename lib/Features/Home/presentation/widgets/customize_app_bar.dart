import 'package:azkark/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomizeAppBar extends StatelessWidget {
  const CustomizeAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: AppStyles.scaffoldBG,
      surfaceTintColor: AppStyles.scaffoldBG,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          context.pop();
        },

        icon: Icon(
          Icons.arrow_back_outlined,
          color: AppStyles.appBarTitleColor,
        ),
      ),
      title: Text(
        textDirection: TextDirection.rtl,
        title,
        style: AppStyles.semiblod18.copyWith(fontSize: 20),
      ),
    );
  }
}
