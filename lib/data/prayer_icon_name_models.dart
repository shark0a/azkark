import 'package:flutter/material.dart';

class PrayerIconNameModels {
  final String name;
  final String prayerIcon;
  final TimeOfDay prayerYime;

  PrayerIconNameModels({
    required this.name,
    required this.prayerIcon,
    required this.prayerYime,
  });
}

List<PrayerIconNameModels> prayerIconAndTime = [
  PrayerIconNameModels(
    name: "العشاء",
    prayerIcon: 'assets/m1.svg',
    prayerYime: TimeOfDay(hour: 15, minute: 10),
  ),
  PrayerIconNameModels(
    name: "المغرب",
    prayerIcon: 'assets/m2.svg',
    prayerYime: TimeOfDay(hour: 18, minute: 10),
  ),
  PrayerIconNameModels(
    name: "العصر",
    prayerIcon: 'assets/m3.svg',
    prayerYime: TimeOfDay(hour: 20, minute: 10),
  ),
  PrayerIconNameModels(
    name: "الظهر",
    prayerIcon: 'assets/m4.svg',
    prayerYime: TimeOfDay(hour: 21, minute: 10),
  ),
  PrayerIconNameModels(
    name: "الشروق",
    prayerIcon: 'assets/m5.svg',
    prayerYime: TimeOfDay(hour: 22, minute: 10),
  ),
  PrayerIconNameModels(
    name: "الفجر",
    prayerIcon: 'assets/m6.svg',
    prayerYime: TimeOfDay(hour: 6, minute: 10),
  ),
];

