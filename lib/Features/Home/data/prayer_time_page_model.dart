class PrayerTimePageModel {
  final String name;
  final String localizationKey;
  final String prayerImage;

  PrayerTimePageModel({
    required this.name,
    required this.localizationKey,
    required this.prayerImage,
  });
}

List<PrayerTimePageModel> prayersTimePageItems = [
  PrayerTimePageModel(
    prayerImage: "assets/m1.svg",
    name: "العشاء",
    localizationKey: 'prayer_isha',
  ),
  PrayerTimePageModel(
    prayerImage: "assets/m2.svg",
    name: "المغرب",
    localizationKey: 'prayer_maghrib',
  ),
  PrayerTimePageModel(
    prayerImage: "assets/m3.svg",
    name: "العصر",
    localizationKey: 'prayer_asr',
  ),
  PrayerTimePageModel(
    prayerImage: "assets/m4.svg",
    name: "الظهر",
    localizationKey: 'prayer_dhuhr',
  ),
  PrayerTimePageModel(
    prayerImage: "assets/m5.svg",
    name: "الشروق",
    localizationKey: 'prayer_sunrise',
  ),
  PrayerTimePageModel(
    prayerImage: "assets/m6.svg",
    name: "الفجر",
    localizationKey: 'prayer_fajr',
  ),
];
