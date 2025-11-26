import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:azkark/generated/l10n.dart';

class AllOfOptions extends StatelessWidget {
  const AllOfOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(color: Color(0xff000000), strokeAlign: 0.5),
          ),
        ),
        child: Center(
          child: Text(
            S.of(context).all_worship_label,
            style: AppStyles.semiblod16,
          ),
        ),
      ),
    );
  }
}
