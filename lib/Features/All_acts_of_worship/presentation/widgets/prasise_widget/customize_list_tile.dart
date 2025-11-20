import 'package:azkark/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomizeListTile extends StatelessWidget {
  const CustomizeListTile({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Color(0xffF5F5F5),
      title: Text(
        title,
        textDirection: TextDirection.rtl,

        style: AppStyles.regular16,
      ),
      leading: Icon(icon, color: Colors.black),
    );
  }
}
