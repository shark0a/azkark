import 'package:azkark/azkark_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AzkarkApp());

    // Verify that the app builds without errors.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
