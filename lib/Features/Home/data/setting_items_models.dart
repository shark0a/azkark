import 'package:flutter/material.dart';

class SettingItemsModels {
  final String title;

  const SettingItemsModels({required this.title});
}

List<SettingItemsModels> settingItemsModel = const [
  SettingItemsModels(title: "مواقيت الصلاة"),
  SettingItemsModels(title: "الإنجليزية"),
  SettingItemsModels(title: "تحديث الموقع"),
  SettingItemsModels(title: "إصدار التطبيق"),
];
