import 'package:azkark/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class PrayerTimeBanner extends StatelessWidget {
  const PrayerTimeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 165,
        width: double.infinity,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: SizedBox(
                child: Image.asset("assets/timemosq.png", fit: BoxFit.fill),
              ),
            ),
            Positioned(
              top: 15,
              left: 26,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("الظهر", style: AppStyles.medium14),

                  Text("11:45", style: AppStyles.semiblod36),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("الصلاة التالية: العصر", style: AppStyles.regular14),
                      Text(
                        textDirection: TextDirection.rtl,
                        "2:50 مساء",
                        style: AppStyles.blod14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
