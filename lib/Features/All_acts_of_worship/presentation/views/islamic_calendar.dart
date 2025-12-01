import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/islamic_clrander_widget/calendar_buttons.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/islamic_clrander_widget/current_date_display.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/islamic_clrander_widget/date_conversion_card.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/islamic_clrander_widget/hijri_calendar_widget.dart';
import 'package:azkark/Features/Home/presentation/widgets/customize_app_bar.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      return S.current.error_converting;
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomizeAppBar(
          onTap: () {
            context.pop();
          },
          title: S.of(context).hijri_calendar,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxHeight < 600;

          return Column(
            children: [
              CalendarButtons(
                isHijri: _showHijri,
                onChanged: (value) => setState(() => _showHijri = value),
                isSmallScreen: isSmallScreen,
              ),

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
        DateConversionCard(
          title: 'التاريخ الهجري:',
          date: _getHijriDate(_selectedDay ?? DateTime.now()),
          color: Colors.green,
          isSmallScreen: isSmallScreen,
        ),
        SizedBox(height: isSmallScreen ? 4 : 8),

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
        DateConversionCard(
          title: 'التاريخ الميلادي :',

          date: _hijriSelectedDay != null
              ? _getGregorianDateFromHijri(_hijriSelectedDay!)
              : _getGregorianDateFromHijri(HijriDate.now()),
          color: Colors.green,
          isSmallScreen: isSmallScreen,
        ),
        SizedBox(height: isSmallScreen ? 4 : 8),

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
      color: AppStyles.scaffoldBG,
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

          daysOfWeekHeight: isSmallScreen ? 30 : 40,
          rowHeight: isSmallScreen ? 35 : 45,

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

          availableGestures: AvailableGestures.horizontalSwipe,
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),

            todayDecoration: BoxDecoration(
              color: Colors.blue.shade200,
              shape: BoxShape.circle,
            ),
            cellPadding: EdgeInsets.zero,
            cellMargin: EdgeInsets.all(0.5),
            outsideDaysVisible: false,
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
