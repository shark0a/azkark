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
    };
    final tz = provider.prayerTimes?.meta.timezone;
    final tzArabic = timezoneArabic[tz] ?? tz ?? "غير معروف";
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
              Text(tzArabic, style: AppStyles.medium15),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${DateFormat.yMMMMEEEEd('ar').format(DateFormat("dd-MM-yyyy").parse(provider.prayerTimes!.date.gregorian.date))} ',
                style: AppStyles.regular16.copyWith(color: Color(0xFFA1A1A1)),
              ),
              const SizedBox(height: 4),
              Text(
                '${provider.prayerTimes?.date.hijri.weekday.ar} ${provider.prayerTimes?.date.hijri.day} ${provider.prayerTimes?.date.hijri.month.ar} ${provider.prayerTimes?.date.hijri.year} هـ',
                style: AppStyles.light15.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
