class SettingItemsModels {
  final String title;
  final String localizationKey;

  const SettingItemsModels({
    required this.title,
    required this.localizationKey,
  });
}

List<SettingItemsModels> settingItemsModel = const [
  SettingItemsModels(
    title: "مواقيت الصلاة",
    localizationKey: "prayer_settings",
  ),
  SettingItemsModels(title: "الإنجليزية", localizationKey: "english_lang"),
  SettingItemsModels(title: "تحديث الموقع", localizationKey: "update_location"),
  SettingItemsModels(title: "إصدار التطبيق", localizationKey: "app_version"),
];
