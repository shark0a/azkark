import 'package:flutter/material.dart';
import 'package:hijri_date/hijri_date.dart';
import 'package:intl/intl.dart';
import 'package:azkark/generated/l10n.dart';

class CurrentDateDisplay extends StatelessWidget {
  final bool isHijri;
  final DateTime? gregorianDate;
  final HijriDate? hijriDate;
  final bool isSmallScreen;

  const CurrentDateDisplay({
    super.key,
    required this.isHijri,
    this.gregorianDate,
    this.hijriDate,
    this.isSmallScreen = false,
  });

  String _getHijriDate(DateTime date) {
    try {
      HijriDate hijriDate = HijriDate.fromDate(date);
      return '${hijriDate.hDay} ${_getHijriMonthName(hijriDate.hMonth)} ${hijriDate.hYear} هـ';
    } catch (e) {
      return S.current.error_converting;
    }
  }

  String _getHijriMonthName(int month) {
    List<String> hijriMonths = [
      'محرم',
      'صفر',
      'ربيع الأول',
      'ربيع الثاني',
      'جمادى الأول',
      'جمادى الثاني',
      'رجب',
      'شعبان',
      'رمضان',
      'شوال',
      'ذو القعدة',
      'ذو الحجة',
    ];
    return hijriMonths[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue),
      ),
      child: Center(
        child: Text(
          isHijri
              ? '${S.current.hijri_date} ${hijriDate != null ? '${hijriDate!.hDay} ${_getHijriMonthName(hijriDate!.hMonth)} ${hijriDate!.hYear} هـ' : _getHijriDate(DateTime.now())}'
              : '${S.current.gregorian_date} ${DateFormat.yMMMMEEEEd('ar').format(gregorianDate!)}',
          style: TextStyle(
            fontSize: isSmallScreen ? 14 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
