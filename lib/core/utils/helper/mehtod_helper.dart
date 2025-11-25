import 'dart:convert';
import 'package:azkark/Features/All_acts_of_worship/data/all_azkar_model.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MehtodHelper {
  //load file containe zekr from asset
  Future<List<AzkarModel>> loadAzkar() async {
    final String file = await rootBundle.loadString("assets/azkar.json");

    final jsonData = jsonDecode(file);

    final List rows = jsonData["rows"];

    return rows
        .asMap()
        .entries
        .map((entry) => AzkarModel.fromRow(entry.value, entry.key + 1))
        .toList();
  }

  //back catgory name for azkar
  static String cleanText(String text) {
    if (!text.contains('-')) return text;

    return text.split('-').first.trim();
  }

  // convert to 12 H
  static String convertTimeTo12H(String time) {
    return DateFormat("hh : mm a").format(DateFormat("hh:mm").parse(time));
  }

  //diff between times
  static String getTimeDifference(String start, String end) {
    try {
      final startTime = DateFormat("HH:mm").parse(start);
      final endTime = DateFormat("HH:mm").parse(end);

      Duration diff = endTime.difference(startTime);

      if (diff.isNegative) {
        diff = diff + const Duration(days: 1);
      }

      final hours = diff.inHours.toString().padLeft(2, '0');
      final minutes = (diff.inMinutes % 60).toString().padLeft(2, '0');

      return "$hours:$minutes";
    } catch (e) {
      return "00:00";
    }
  }
  static Stream<String> timeLeftStream(String nextTime) async* {
  while (true) {
    final now = DateTime.now();
    final today = DateFormat("HH:mm").parse(nextTime);

    DateTime next = DateTime(
      now.year,
      now.month,
      now.day,
      today.hour,
      today.minute,
    );

    if (next.isBefore(now)) {
      next = next.add(const Duration(days: 1));
    }

    final diff = next.difference(now);

    final hours = diff.inHours.toString().padLeft(2, '0');
    final minutes = (diff.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (diff.inSeconds % 60).toString().padLeft(2, '0');

    yield "$hours:$minutes:$seconds";

    await Future.delayed(const Duration(seconds: 1));
  }
}

  ///get reeal time
  static String getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  static Stream<String> timeStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) => getCurrentTime());
  }
}
