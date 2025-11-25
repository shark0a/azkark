import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:azkark/core/utils/cache/shared_pref_keys.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:flutter/material.dart';

class PrayerTimeBanner extends StatelessWidget {
  const PrayerTimeBanner({super.key, required this.homeController});
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    final Map<String, String> arabicNames = {
      "Fajr": "الفجر",
      "Dhuhr": "الظهر",
      "Asr": "العصر",
      "Maghrib": "المغرب",
      "Isha": "العشاء",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("الظهر", style: AppStyles.medium14),
                  StreamBuilder<String>(
                    stream: MehtodHelper.timeStream(),
                    builder: (context, asyncSnapshot) {
                      return Text(
                        MehtodHelper.convertTimeTo12H(
                          asyncSnapshot.data ?? MehtodHelper.getCurrentTime(),
                        ),
                        // ,
                        // asyncSnapshot.data ?? MehtodHelper.getCurrentTime(),
                        style: AppStyles.semiblod36,
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "الصلاة التالية : ",
                          style: AppStyles.regular14.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),

                          children: [
                            TextSpan(
                              text: '$nextTimeName',
                              style: AppStyles.regular14.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        MehtodHelper.convertTimeTo12H(nextTimeVlaue),
                        style: AppStyles.blod14.copyWith(fontSize: 16),
                        //
                        // nextTimeVlaue,
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
