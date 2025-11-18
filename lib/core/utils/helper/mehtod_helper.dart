import 'dart:convert';
import 'package:azkark/data/all_azkar_model.dart';
import 'package:flutter/services.dart';

class MehtodHelper {
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
 static String cleanText(String text) {
  if (!text.contains('-')) return text;

  return text.split('-').first.trim();
}
}
