import 'package:flutter/material.dart';
import 'package:hijri_date/hijri_date.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HijriCalendarWidget extends StatefulWidget {
  final HijriDate? selectedDate;
  final Function(HijriDate) onDateSelected;
  final bool isSmallScreen;

  const HijriCalendarWidget({
    super.key,
    this.selectedDate,
    required this.onDateSelected,
    this.isSmallScreen = false,
  });

  @override
  HijriCalendarWidgetState createState() => HijriCalendarWidgetState();
}

class HijriCalendarWidgetState extends State<HijriCalendarWidget> {
  int _currentYear = HijriDate.now().hYear;
  int _currentMonth = HijriDate.now().hMonth;

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

  int _getDaysInHijriMonth(int year, int month) {
    try {
      HijriDate testDate = HijriDate();
      testDate.hYear = year;
      testDate.hMonth = month;
      testDate.hDay = 1;
      return testDate.lengthOfMonth;
    } catch (e) {
      Map<int, int> hijriMonthDays = {
        1: 30,
        2: 29,
        3: 30,
        4: 29,
        5: 30,
        6: 29,
        7: 30,
        8: 29,
        9: 30,
        10: 29,
        11: 30,
        12: 29,
      };
      return hijriMonthDays[month] ?? 30;
    }
  }

  int _getFirstDayWeekday(int year, int month) {
    try {
      DateTime now = DateTime.now();
      HijriDate currentHijri = HijriDate.fromDate(now);
      int yearDiff = year - currentHijri.hYear;
      int monthDiff = month - currentHijri.hMonth;
      int totalDaysDiff = (yearDiff * 354) + (monthDiff * 29);
      DateTime firstDay = now.add(Duration(days: totalDaysDiff));
      return firstDay.weekday;
    } catch (e) {
      return 1;
    }
  }

  void _changeMonth(int offset) {
    setState(() {
      _currentMonth += offset;
      if (_currentMonth > 12) {
        _currentMonth = 1;
        _currentYear++;
      } else if (_currentMonth < 1) {
        _currentMonth = 12;
        _currentYear--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = _getDaysInHijriMonth(_currentYear, _currentMonth);
    int startingWeekday = _getFirstDayWeekday(_currentYear, _currentMonth);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 4.r,
      child: Container(
        padding: EdgeInsets.all((widget.isSmallScreen ? 4 : 8).r),
        child: Column(
          children: [
            // Header - حجم أصغر
            _buildHeader(),
            SizedBox(height: (widget.isSmallScreen ? 8 : 12).h),
            // Week Days - حجم أصغر
            _buildWeekDays(),
            SizedBox(height: (widget.isSmallScreen ? 4 : 6).h),
            // Days Grid - يستخدم المساحة المتبقية
            Expanded(child: _buildDaysGrid(daysInMonth, startingWeekday)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.green,
            size: (widget.isSmallScreen ? 18 : 24).r,
          ),
          onPressed: () => _changeMonth(-1),
          padding: EdgeInsets.all((widget.isSmallScreen ? 4 : 8).r),
          constraints: BoxConstraints(
            minWidth: (widget.isSmallScreen ? 32 : 48).w,
            minHeight: (widget.isSmallScreen ? 32 : 48).h,
          ),
        ),
        Column(
          children: [
            Text(
              _getHijriMonthName(_currentMonth),
              style: TextStyle(
                fontSize: (widget.isSmallScreen ? 14 : 18).sp,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            Text(
              textDirection: TextDirection.rtl,
              '$_currentYear هـ',
              style: TextStyle(
                fontSize: (widget.isSmallScreen ? 12 : 14).sp,
                color: Colors.green[600],
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.chevron_right,
            color: Colors.green,
            size: (widget.isSmallScreen ? 18 : 24).r,
          ),
          onPressed: () => _changeMonth(1),
          padding: EdgeInsets.all((widget.isSmallScreen ? 4 : 8).r),
          constraints: BoxConstraints(
            minWidth: (widget.isSmallScreen ? 32 : 48).w,
            minHeight: (widget.isSmallScreen ? 32 : 48).h,
          ),
        ),
      ],
    );
  }

  Widget _buildWeekDays() {
    List<String> weekDays = [
      'أحد',
      'إثنين',
      'ثلاثاء',
      'أربعاء',
      'خميس',
      'جمعة',
      'سبت',
    ];

    return Row(
      children: weekDays.map((day) {
        return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: (widget.isSmallScreen ? 6 : 8).h,
            ),
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  fontSize: (widget.isSmallScreen ? 10 : 12).sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDaysGrid(int daysInMonth, int startingWeekday) {
    List<Widget> dayWidgets = [];

    // Empty days
    for (int i = 1; i < startingWeekday; i++) {
      dayWidgets.add(Container());
    }

    // Month days
    for (int day = 1; day <= daysInMonth; day++) {
      HijriDate currentDate = HijriDate();
      currentDate.hYear = _currentYear;
      currentDate.hMonth = _currentMonth;
      currentDate.hDay = day;

      bool isSelected =
          widget.selectedDate != null &&
          widget.selectedDate!.hYear == _currentYear &&
          widget.selectedDate!.hMonth == _currentMonth &&
          widget.selectedDate!.hDay == day;

      bool isToday =
          HijriDate.now().hYear == _currentYear &&
          HijriDate.now().hMonth == _currentMonth &&
          HijriDate.now().hDay == day;

      dayWidgets.add(
        GestureDetector(
          onTap: () => widget.onDateSelected(currentDate),
          child: Container(
            margin: EdgeInsets.all((widget.isSmallScreen ? 0.5 : 1).r),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.green
                  : isToday
                  ? Colors.green.shade100
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: isToday && !isSelected
                  ? Border.all(color: Colors.green, width: 1)
                  : null,
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  fontSize: widget.isSmallScreen ? 10.sp : 12.sp,
                  fontWeight: isSelected || isToday
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.green[800],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 1.0, // تأكد أن المربعات مربعة
      mainAxisSpacing: (widget.isSmallScreen ? 0.5 : 1).h,
      crossAxisSpacing: (widget.isSmallScreen ? 0.5 : 1).w,
      padding: EdgeInsets.all((widget.isSmallScreen ? 1 : 2).r),
      children: dayWidgets,
    );
  }
}
