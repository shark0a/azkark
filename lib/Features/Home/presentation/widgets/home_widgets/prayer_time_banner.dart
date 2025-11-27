import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkark/generated/l10n.dart';

class PrayerTimeBanner extends StatelessWidget {
  const PrayerTimeBanner({super.key, required this.homeController});
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    final Map<String, String> prayerKeyToLocalized = {
      "fajr": S.of(context).prayer_fajr,
      "dhuhr": S.of(context).prayer_dhuhr,
      "asr": S.of(context).prayer_asr,
      "maghrib": S.of(context).prayer_maghrib,
      "isha": S.of(context).prayer_isha,
    };

    final nextTimeKey = homeController.nextPrayerKeyLocal ?? "fajr";
    final nextTimeVlaue = homeController.nextPrayerTimeLocal ?? "00:00";

    final nextTimeName =
        prayerKeyToLocalized[nextTimeKey.toLowerCase()] ??
        nextTimeKey.toLowerCase();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 165.h,
        width: double.infinity,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.r),
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
              top: 15.h,
              left: 26.w,
              child: StreamBuilder<String>(
                stream: MehtodHelper.timeStream(),
                builder: (context, asyncSnapshot) {
                  return Text(
                    textDirection: TextDirection.ltr,
                    MehtodHelper.convertTimeTo12H(
                      asyncSnapshot.data ?? MehtodHelper.getCurrentTime(),
                    ),
                    // ,
                    style: AppStyles.semiblod36,
                  );
                },
              ),
            ),
            Positioned(
              top: 70.h,
              left: 27.w,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "${S.of(context).next_prayer_label} ",
                      style: AppStyles.regular14.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),

                      children: [
                        TextSpan(
                          text: '$nextTimeName',
                          style: AppStyles.regular14.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    MehtodHelper.convertTimeTo12H(nextTimeVlaue),
                    style: AppStyles.blod14.copyWith(fontSize: 16.sp),
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
