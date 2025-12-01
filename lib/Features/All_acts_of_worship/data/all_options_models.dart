class AllOptionsModel {
  final String icon;
  final String title;
  final String localizationKey;

  AllOptionsModel({
    required this.icon,
    required this.title,
    required this.localizationKey,
  });
}

List<AllOptionsModel> allOtionsItems = [
  AllOptionsModel(
    icon: "assets/azkar1.svg",
    title: "أذكار المساء",
    localizationKey: "azkar_evening",
  ),
  AllOptionsModel(
    icon: "assets/azkar2.svg",
    title: "أذكار الصباح",
    localizationKey: "azkar_morning",
  ),
  AllOptionsModel(
    icon: "assets/azkar3.svg",
    title: "أذكار الصلاة",
    localizationKey: "azkar_prayer",
  ),
  AllOptionsModel(
    icon: "assets/azkar4.svg",
    title: "جميع الأدعية",
    localizationKey: "all_duas",
  ),
  AllOptionsModel(
    icon: "assets/azkar5.svg",
    title: "التسبيح",
    localizationKey: "tasbih",
  ),
  AllOptionsModel(
    icon: "assets/azkar6.svg",
    title: "التقويم الهجري",
    localizationKey: "hijri_calendar",
  ),
  AllOptionsModel(
    icon: "assets/azkar7.svg",
    title: "المفضلة",
    localizationKey: "favorites",
  ),
  AllOptionsModel(
    icon: "assets/azkar8.svg",
    title: "اقرب المساجد ",
    localizationKey: "nearest_mosq",
  ),
  AllOptionsModel(
    icon: "assets/azkar9.svg",
    title: "أذكار متنوعة",
    localizationKey: "VariuosAzkar",
  ),
];
