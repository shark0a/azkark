class VaroiusAzkarModel {
  final String title;
  final String localizationKey;

  const VaroiusAzkarModel({required this.title, required this.localizationKey});
}

List<VaroiusAzkarModel> variusAzkarItem = const [
  VaroiusAzkarModel(title: "أذكار الآذان", localizationKey: "zekr_azan"),
  VaroiusAzkarModel(
    title: "أذكار الاستيقاظ من النوم",
    localizationKey: "zekr_awaken",
  ),
  VaroiusAzkarModel(
    title: "الرقية الشرعية من القرآن الكريم",
    localizationKey: "ruqya_quran",
  ),
  VaroiusAzkarModel(
    title: "الرقية الشرعية من السنة النبوية",
    localizationKey: "ruqya_sunnah",
  ),
  VaroiusAzkarModel(
    title: "من تعار من الليل",
    localizationKey: "zekr_night_waking",
  ),
  VaroiusAzkarModel(
    title: "الذكر عند دخول المنزل",
    localizationKey: "zekr_enter_home",
  ),
  VaroiusAzkarModel(
    title: "الذكر عند الخروج من المنزل",
    localizationKey: "zekr_exit_home",
  ),
  VaroiusAzkarModel(
    title: "الذكر بعد الفراغ من الوضوء",
    localizationKey: "zekr_wudhu",
  ),
  VaroiusAzkarModel(
    title: "فضل الصلاة على النبي صلى الله عليه و سلم",
    localizationKey: "zekr_prayer_virtue",
  ),
  VaroiusAzkarModel(
    title: "أماكن وأوقات إجابة",
    localizationKey: "zekr_prayer_answered",
  ),
];
