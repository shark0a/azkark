import 'package:azkark/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class LeftTimeWidget extends StatelessWidget {
  const LeftTimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            Text(
              "-04:55",
              style: AppStyles.light15.copyWith(
                fontSize: 20,
                color: AppStyles.inActiveColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(width: 19),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              textDirection: TextDirection.rtl,
              "الوقت المتبقي",
              style: AppStyles.regular12.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              textDirection: TextDirection.rtl,
              " لصلاة الظهر",
              style: AppStyles.regular16.copyWith(
                color: AppStyles.appBarTitleColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
