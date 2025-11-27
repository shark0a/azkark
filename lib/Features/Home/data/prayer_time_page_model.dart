class PrayerTimePageModel {
  final String name;
  final String localizationKey;
  final String prayerImage;
  final String prayerKey; // Add prayer key for comparison

  PrayerTimePageModel({
    required this.name,
    required this.localizationKey,
    required this.prayerImage,
    required this.prayerKey,
  });
}

List<PrayerTimePageModel> prayersTimePageItems = [
  PrayerTimePageModel(
    prayerImage: "assets/m1.svg",
    name: "العشاء",
    localizationKey: 'prayer_isha',
    prayerKey: 'isha',
  ),
  PrayerTimePageModel(
    prayerImage: "assets/m2.svg",
    name: "المغرب",
    localizationKey: 'prayer_maghrib',
    prayerKey: 'maghrib',
  ),
  PrayerTimePageModel(
    prayerImage: "assets/m3.svg",
    name: "العصر",
    localizationKey: 'prayer_asr',
    prayerKey: 'asr',
  ),
  PrayerTimePageModel(
    prayerImage: "assets/m4.svg",
    name: "الظهر",
    localizationKey: 'prayer_dhuhr',
    prayerKey: 'dhuhr',
  ),
  PrayerTimePageModel(
    prayerImage: "assets/m5.svg",
    name: "الشروق",
    localizationKey: 'prayer_sunrise',
    prayerKey: 'sunrise',
  ),
  PrayerTimePageModel(
    prayerImage: "assets/m6.svg",
    name: "الفجر",
    localizationKey: 'prayer_fajr',
    prayerKey: 'fajr',
  ),
];
