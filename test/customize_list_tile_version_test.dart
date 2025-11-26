import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:azkark/Features/Home/presentation/widgets/prayer_time_widget/customize_list_tile_version.dart';

void main() {
  testWidgets('CustomizeListTileVersion displays prayer time and name', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomizeListTileVersion(
            prayerImage: "assets/m6.svg",

            localizationKey: 'prayer_fajr',
            active: true,
            prayerName: " s ",
            prayerTime: " s",
          ),
        ),
      ),
    );

    expect(find.text('04:55'), findsOneWidget);
    expect(find.text('الفجر'), findsOneWidget);
  });

  testWidgets('CustomizeListTileVersion has correct tile color', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomizeListTileVersion(
            prayerImage: "assets/m6.svg",

            localizationKey: 'prayer_fajr',

            active: true,
            prayerName: "  ",
            prayerTime: "",
          ),
        ),
      ),
    );

    final listTile = tester.widget<ListTile>(find.byType(ListTile));
    expect(listTile.tileColor, const Color.fromRGBO(245, 245, 245, 50));
  });
}
