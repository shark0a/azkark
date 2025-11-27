import 'dart:convert';
import 'dart:developer';
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
    try {
      // فصل الساعات والدقائق
      List<String> parts = time.split(':');
      if (parts.length != 2) return time;

      int hour = int.parse(parts[0]);
      String minute = parts[1];

      // إذا الساعة أكبر من 12 (تنسيق 24 ساعة) حوله لـ 12 ساعة
      if (hour > 12) {
        String period = 'PM';
        int hour12 = hour - 12;
        return '${hour12.toString().padLeft(2, '0')}:$minute $period';
      }
      // إذا الساعة أقل من أو تساوي 12 اتركه كما هو وأضف AM/PM
      else {
        String period = hour >= 12 ? 'PM' : 'AM';
        if (hour == 0) {
          return '12:$minute $period';
        }
        return '${hour.toString().padLeft(2, '0')}:$minute $period';
      }
    } catch (e) {
      return time;
    }
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

  // static String formatGregorianDate(String? date, String lang) {
  //   log(date.toString());
  //   if (date == null || date.trim().isEmpty) return date ?? '';

  //   try {
  //     final parsed = DateFormat("dd-MM-yyyy").parse(date);

  //     String formatPattern;
  //     if (lang.startsWith('ar')) {
  //       formatPattern = "EEEE dd MMMM yyyy";
  //     } else {
  //       formatPattern = "EEEE dd MMMM yyyy";
  //     }

  //     return DateFormat(formatPattern, lang).format(parsed);
  //   } catch (e) {
  //     log(e.toString());
  //     return date;
  //   }
  // }
  static String formatGregorianDate(String? date, String lang) {
    log(date.toString());
    if (date == null || date.trim().isEmpty) return date ?? '';

    try {
      List<String> parts = date.split('-');
      if (parts.length != 3) return date;

      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);

      DateTime parsed = DateTime(year, month, day);
      String formatPattern = "EEEE dd MMMM yyyy";
      return DateFormat(formatPattern, lang).format(parsed);
    } catch (e) {
      log('Error: $e');
      return date;
    }
  }

  static Stream<String> timeLeftStream(String nextTime) async* {
    while (true) {
      final now = DateTime.now();

      // فصل الساعات والدقائق يدوياً
      List<String> parts = nextTime.split(':');
      if (parts.length != 2) {
        yield "00:00:00";
        await Future.delayed(const Duration(seconds: 1));
        continue;
      }

      int hour = int.tryParse(parts[0]) ?? 0;
      int minute = int.tryParse(parts[1]) ?? 0;

      DateTime nextPrayer = DateTime(
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      if (nextPrayer.isBefore(now)) {
        nextPrayer = nextPrayer.add(const Duration(days: 1));
      }

      Duration difference = nextPrayer.difference(now);

      int hours = difference.inHours;
      int minutes = difference.inMinutes.remainder(60);
      int seconds = difference.inSeconds.remainder(60);

      yield "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

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
