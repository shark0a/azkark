import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/prayer_detail_container.dart';

void main() {
  testWidgets('PrayerDetailContainer displays prayer name and time', (
    WidgetTester tester,
  ) async {
    const prayerName = 'Fajr';
    const prayerTime = TimeOfDay(hour: 5, minute: 30);
    const active = true;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrayerDetailContainer(
            prayerName: prayerName,
            prayerIcon: 'assets/m1.svg',
            prayerTime: prayerTime,
            active: active,
          ),
        ),
      ),
    );

    expect(find.text(prayerName), findsOneWidget);
    expect(find.text('5:30'), findsOneWidget);
  });

  testWidgets('PrayerDetailContainer shows active styling', (
    WidgetTester tester,
  ) async {
    const active = true;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrayerDetailContainer(
            prayerName: 'Fajr',
            prayerIcon: 'assets/m1.svg',
            prayerTime: const TimeOfDay(hour: 5, minute: 30),
            active: active,
          ),
        ),
      ),
    );

    final container = tester.widget<Container>(find.byType(Container));
    final decoration = container.decoration as ShapeDecoration;
    expect(decoration.color, const Color(0xff01B7F1));
  });

  testWidgets('PrayerDetailContainer shows inactive styling', (
    WidgetTester tester,
  ) async {
    const active = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrayerDetailContainer(
            prayerName: 'Fajr',
            prayerIcon: 'assets/m1.svg',
            prayerTime: const TimeOfDay(hour: 5, minute: 30),
            active: active,
          ),
        ),
      ),
    );

    final container = tester.widget<Container>(find.byType(Container));
    final decoration = container.decoration as ShapeDecoration;
    expect(decoration.color, const Color(0xffEDFBFF));
  });
}
