import 'dart:developer';

import 'package:azkark/Features/All_acts_of_worship/data/all_azkar_model.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:azkark/core/utils/cache/shared_pref_keys.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:flutter/material.dart';

class AzkarProvider extends ChangeNotifier {
  final MehtodHelper mehtodHelper;
  AzkarProvider({required this.mehtodHelper}) {
    _loadingLocal();
  }
  // first time open program
  bool _isFirstTimeOpen = true;
  bool get isFirstTimeOpen => _isFirstTimeOpen;
  void _loadingLocal() async {
    _isFirstTimeOpen =
        sl.get<SharedPref>().getBool(SharedPrefKeys.firstTimeOpen) ?? true;
  }

  // load file
  late Future<List<AzkarModel>> futureAzkar;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<List<AzkarModel>> loadDataFromJson() async {
    _isLoading = true;
    notifyListeners();

    try {
      final allAzkar = await mehtodHelper.loadAzkar();
      futureAzkar = Future.value(allAzkar);
      splitZekr(allAzkar);
      return allAzkar;
    } catch (e) {
      throw "open file has error $e";
    } finally {
      _isLoading = false;
      sl.get<SharedPref>().setBool(SharedPrefKeys.firstTimeOpen, false);
      notifyListeners();
    }
  }

  List<AzkarModel> azkarMorning = [];
  List<AzkarModel> azkarEvening = [];
  List<AzkarModel> azkarPrayers = [];
  List<AzkarModel> allPrayers = [];
  List<AzkarModel> praise = [];
  List<AzkarModel> variousDoaa = [];

  void splitZekr(List<AzkarModel> allZekrList) {
    try {
      azkarMorning.clear();
      azkarEvening.clear();
      azkarPrayers.clear();
      allPrayers.clear();
      praise.clear();
      for (var element in allZekrList) {
        if (element.category.contains("أذكار الصباح")) {
          azkarMorning.add(element);
        } else if (element.category.contains("أذكار المساء")) {
          azkarEvening.add(element);
        } else if (element.search.contains("الصلاة الصلاه") ||
            element.search.contains("الصلاه")) {
          azkarPrayers.add(element);
        } else if (element.search.contains('دعاء') ||
            element.search.contains('الدعاء ')) {
          allPrayers.add(element);
        } else if (element.search.contains("كيف كان النبي يسبح؟") ||
            element.search.contains("التسبيح، التحميد، التهليل، التكبير") ||
            element.search.contains("الاستغفار و التوبة")) {
          praise.add(element);
        } else {
          variousDoaa.add(element);
        }
      }
    } catch (e) {
      throw "error in split this category $e";
    }
  }

  //search by specific zekr
  List<AzkarModel> specificZekr = [];
  void searcBySpecific(String zekrtTitle) {
    specificZekr.clear();
    for (var element in variousDoaa) {
      if (element.category.contains(zekrtTitle)) {
        log(element.zekr);
        specificZekr.add(element);
      }
    }
  }

  /// add to fav list
  Map<int, AzkarModel> favList = {};
  void toggleItemFavList(AzkarModel item) {
    if (favList.containsKey(item.id)) {
      favList.remove(item.id);
      item.isFav = false;
    } else {
      favList[item.id] = item;
      item.isFav = true;
    }
    notifyListeners();
  }
}
