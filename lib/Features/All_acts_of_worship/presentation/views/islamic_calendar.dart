import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/islamic_clrander_widget/calendar_buttons.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/islamic_clrander_widget/current_date_display.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/islamic_clrander_widget/date_conversion_card.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/islamic_clrander_widget/hijri_calendar_widget.dart';
import 'package:azkark/Features/Home/presentation/widgets/customize_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hijri_date/hijri_date.dart';

class IslamicCalendar extends StatefulWidget {
  const IslamicCalendar({super.key});

  @override
  IslamicCalendarState createState() => IslamicCalendarState();
}

class IslamicCalendarState extends State<IslamicCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _showHijri = false;
  HijriDate? _hijriSelectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _hijriSelectedDay = HijriDate.now();
  }

  String _getHijriDate(DateTime date) {
    try {
      HijriDate hijriDate = HijriDate.fromDate(date);
      return '${hijriDate.hDay} ${_getHijriMonthName(hijriDate.hMonth)} ${hijriDate.hYear} هـ';
    } catch (e) {
      return 'خطأ في التحويل';
    }
  }

  String _getGregorianDateFromHijri(HijriDate hijriDate) {
    try {
      DateTime tempDate = DateTime.now();
      HijriDate tempHijri = HijriDate.fromDate(tempDate);
      int totalDaysDifference =
          ((hijriDate.hYear - tempHijri.hYear) * 354) +
          ((hijriDate.hMonth - tempHijri.hMonth) * 29) +
          (hijriDate.hDay - tempHijri.hDay);
      DateTime resultDate = tempDate.add(Duration(days: totalDaysDifference));
      return ' ${DateFormat.yMMMMEEEEd('ar').format(resultDate)}';
    } catch (e) {
      return 'خطأ في التحويل';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomizeAppBar(title: "التقويم الهجري"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxHeight < 600;

          return Column(
            children: [
              // الأزرار - حجم أصغر في الشاشات الصغيرة
              CalendarButtons(
                isHijri: _showHijri,
                onChanged: (value) => setState(() => _showHijri = value),
                isSmallScreen: isSmallScreen,
              ),

              // عرض التاريخ الحالي - حجم أصغر في الشاشات الصغيرة
              CurrentDateDisplay(
                isHijri: _showHijri,
                gregorianDate: _selectedDay,
                hijriDate: _hijriSelectedDay,
                isSmallScreen: isSmallScreen,
              ),

              SizedBox(height: isSmallScreen ? 8 : 16),

              // التقويم - يستخدم المساحة المتبقية
              Expanded(
                child: _showHijri
                    ? _buildHijriView(isSmallScreen)
                    : _buildGregorianView(isSmallScreen),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGregorianView(bool isSmallScreen) {
    return Column(
      children: [
        // بطاقة التحويل - حجم أصغر في الشاشات الصغيرة
        DateConversionCard(
          title: 'التاريخ الهجري:',
          date: _getHijriDate(_selectedDay ?? DateTime.now()),
          color: Colors.green,
          isSmallScreen: isSmallScreen,
        ),
        SizedBox(height: isSmallScreen ? 4 : 8),

        // التقويم الميلادي - يستخدم المساحة المتبقية
        Expanded(
          child: Container(
            margin: EdgeInsets.all(isSmallScreen ? 8 : 16),
            child: _buildGregorianCalendar(isSmallScreen),
          ),
        ),
      ],
    );
  }

  Widget _buildHijriView(bool isSmallScreen) {
    return Column(
      children: [
        // بطاقة التحويل - حجم أصغر في الشاشات الصغيرة
        DateConversionCard(
          title: 'التاريخ الميلادي :',

          date: _hijriSelectedDay != null
              ? _getGregorianDateFromHijri(_hijriSelectedDay!)
              : _getGregorianDateFromHijri(HijriDate.now()),
          color: Colors.green,
          isSmallScreen: isSmallScreen,
        ),
        SizedBox(height: isSmallScreen ? 4 : 8),

        // التقويم الهجري - يستخدم المساحة المتبقية
        Expanded(
          child: HijriCalendarWidget(
            selectedDate: _hijriSelectedDay,
            onDateSelected: (date) => setState(() => _hijriSelectedDay = date),
            isSmallScreen: isSmallScreen,
          ),
        ),
      ],
    );
  }

  Widget _buildGregorianCalendar(bool isSmallScreen) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(isSmallScreen ? 4.0 : 8.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onFormatChanged: (format) => setState(() => _calendarFormat = format),
          onPageChanged: (focusedDay) =>
              setState(() => _focusedDay = focusedDay),

          // إعدادات الـ UI لجعله responsive
          daysOfWeekHeight: isSmallScreen
              ? 30
              : 40, // تقليل ارتفاع أيام الأسبوع
          rowHeight: isSmallScreen ? 35 : 45, // تقليل ارتفاع الصفوف

          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              return Container(
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: TextStyle(fontSize: isSmallScreen ? 10 : 12),
                  ),
                ),
              );
            },
          ),

          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.blue.shade200,
              shape: BoxShape.circle,
            ),
            // أحجام أصغر للشاشات الصغيرة
            cellPadding: EdgeInsets.zero, // إزالة الـ padding تماماً
            cellMargin: EdgeInsets.all(0.5), // تقليل الـ margin
            outsideDaysVisible: false, // إخفاء الأيام خارج الشهر
          ),

          headerStyle: HeaderStyle(
            formatButtonVisible: !isSmallScreen,
            titleCentered: true,
            formatButtonShowsNext: false,
            formatButtonDecoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(6),
            ),
            formatButtonTextStyle: TextStyle(
              color: Colors.white,
              fontSize: isSmallScreen ? 10 : 12,
            ),
            titleTextStyle: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.bold,
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              size: isSmallScreen ? 18 : 20,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              size: isSmallScreen ? 18 : 20,
            ),
            headerPadding: EdgeInsets.symmetric(
              vertical: isSmallScreen ? 4 : 8,
            ),
            headerMargin: EdgeInsets.only(bottom: isSmallScreen ? 4 : 8),
          ),

          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              fontSize: isSmallScreen ? 10 : 12,
              fontWeight: FontWeight.bold,
            ),
            weekendStyle: TextStyle(
              fontSize: isSmallScreen ? 10 : 12,
              fontWeight: FontWeight.bold,
            ),
          ),

          availableCalendarFormats: const {
            CalendarFormat.month: 'شهري',
            CalendarFormat.week: 'أسبوعي',
          },
          locale: 'ar',
        ),
      ),
    );
  }
}
