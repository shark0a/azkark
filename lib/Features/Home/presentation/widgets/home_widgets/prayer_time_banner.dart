import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:azkark/core/utils/cache/shared_pref_keys.dart';
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
    final Map<String, String> arabicNames = {
      "Fajr": S.of(context).prayer_fajr,
      "Dhuhr": S.of(context).prayer_dhuhr,
      "Asr": S.of(context).prayer_asr,
      "Maghrib": S.of(context).prayer_maghrib,
      "Isha": S.of(context).prayer_isha,
    };

    final nextTimeKey =
        homeController.nextPrayer?.nextTimingkey ??
        homeController.nextPrayerLocal?.nextTimingkey ??
        "";
    final nextTimeVlaue =
        homeController.nextPrayer?.nextTimingValue ??
        homeController.nextPrayerLocal?.nextTimingValue ??
        "";

    final isArabic =
        sl.get<SharedPref>().getString(SharedPrefKeys.langKey) == 'ar';

    final nextTimeName = isArabic ? arabicNames[nextTimeKey] : nextTimeKey;
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
