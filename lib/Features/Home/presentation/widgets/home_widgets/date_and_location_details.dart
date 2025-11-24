import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateAndLocationDetails extends StatelessWidget {
  const DateAndLocationDetails({super.key, required this.provider});
  final HomeController provider;
  @override
  Widget build(BuildContext context) {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('المكان', style: AppStyles.regular12),
              const SizedBox(height: 4),
              if (isLoading)
                SizedBox(
                  width: 80,
                  height: 16,
                  child: const Center(
                    child: SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              else
                Text(tzArabic ?? tz ?? "غير معروف", style: AppStyles.medium15),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${DateFormat.yMMMMEEEEd('ar').format(DateFormat("dd-MM-yyyy").parse(provider.prayerTimes?.date.gregorian.date ?? provider.prayerTimesHive?.date.gregorian.date ?? '9-9-2005'))} ',
                style: AppStyles.regular16.copyWith(color: Color(0xFFA1A1A1)),
                // textDirection: TextDirection.ltr,
              ),
              const SizedBox(height: 4),
              Text(
                provider.prayerTimesHive == null
                    ? '${provider.prayerTimes?.date.hijri.weekday.ar} ${provider.prayerTimes?.date.hijri.day} ${provider.prayerTimes?.date.hijri.month.ar} ${provider.prayerTimes?.date.hijri.year} هـ'
                    : '${provider.prayerTimesHive?.date.hijri.weekday.ar ?? "--:--"} ${provider.prayerTimesHive?.date.hijri.day ?? "--:--"} ${provider.prayerTimesHive?.date.hijri.month.ar ?? "--:--"} ${provider.prayerTimesHive?.date.hijri.year ?? "--:--"} هـ',
                style: AppStyles.light15.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
