import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:azkark/core/utils/cache/shared_pref_keys.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:intl/intl.dart';

class DateAndLocationDetails extends StatelessWidget {
  const DateAndLocationDetails({super.key, required this.provider});
  final HomeController provider;
  @override
  Widget build(BuildContext context) {
    final lang = sl.get<SharedPref>().getString(SharedPrefKeys.langKey) ?? 'en';
    final Map<String, String> timezoneArabic = {
      "Africa/Cairo": "القاهرة، مصر",
      "Asia/Riyadh": "آسيا/الرياض",
      "Asia/Dubai": "آسيا/دبي",
      "Europe/London": "أوروبا/لندن",
      "Asia/Beirut": "آسيا/بيروت",
      "Africa/Khartoum": "أفريقيا/الخرطوم",
      "America/Los_Angeles": "امريكا/لوس انجلوس",
    };
    final tz = provider.prayerTimes?.meta.timezone ?? provider.localCountyName;
    final tzArabic = timezoneArabic[tz];
    final isLoading =
        provider.isLoadingLocation || provider.isFetchingPrayerTimes;
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: AppStyles.scaffoldBG,
              color: AppStyles.appBarTitleColor,
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.5.w),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          // overflow: TextOverflow.ellipsis,
                          S.of(context).place_label,
                          style: AppStyles.regular12,
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Text(
                          overflow: TextOverflow.ellipsis,

                          MehtodHelper.formatGregorianDate(
                            provider.prayerTimes?.date.gregorian.date ??
                                provider.prayerTimesHive?.date.gregorian.date ??
                                DateFormat("d-MM-yyyy").format(DateTime.now()),
                            lang,
                          ),
                          style: AppStyles.regular16.copyWith(
                            color: Color(0xFFA1A1A1),
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      lang == 'ar'
                          ? Flexible(
                              flex: 1,
                              child: Text(
                                overflow: TextOverflow.ellipsis,

                                tzArabic ?? tz ?? S.of(context).unknown_label,
                                style: AppStyles.medium15,
                              ),
                            )
                          : Flexible(
                              flex: 1,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                tz ?? S.of(context).unknown_label,
                                style: AppStyles.medium15,
                              ),
                            ),
                      SizedBox(width: 4.w),
                      lang == 'ar'
                          ? Flexible(
                              flex: 3,
                              child: Text(
                                overflow: TextOverflow.ellipsis,

                                provider.prayerTimesHive == null
                                    ? '${provider.prayerTimes?.date.hijri.weekday.ar ?? ''} ${provider.prayerTimes?.date.hijri.day ?? ''} ${provider.prayerTimes?.date.hijri.month.ar ?? ''} ${provider.prayerTimes?.date.hijri.year ?? ''} هـ'
                                    : '${provider.prayerTimesHive?.date.hijri.weekday.ar ?? "--:--"} ${provider.prayerTimesHive?.date.hijri.day ?? "--:--"} ${provider.prayerTimesHive?.date.hijri.month.ar ?? "--:--"} ${provider.prayerTimesHive?.date.hijri.year ?? "--:--"} هـ',
                                style: AppStyles.light15.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : Flexible(
                              flex: 3,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                provider.prayerTimesHive == null
                                    ? '${provider.prayerTimes?.date.hijri.weekday.en ?? ''} ${provider.prayerTimes?.date.hijri.day ?? ''} ${provider.prayerTimes?.date.hijri.month.en ?? ''} ${provider.prayerTimes?.date.hijri.year ?? ''}'
                                    : '${provider.prayerTimesHive?.date.hijri.weekday.en ?? "--:--"} ${provider.prayerTimesHive?.date.hijri.day ?? "--:--"} ${provider.prayerTimesHive?.date.hijri.month.en ?? "--:--"} ${provider.prayerTimesHive?.date.hijri.year ?? "--:--"}',
                                style: AppStyles.light15.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
