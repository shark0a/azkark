import 'dart:developer';

import 'package:azkark/Features/All_acts_of_worship/data/all_azkar_model.dart';
import 'package:azkark/Features/All_acts_of_worship/data/fav_items_model.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/hive_service.dart';
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
    // loadAzkarFromHive();
    loadFavList();
  }

  // late Future<List<AzkarModel>> futureAzkar;
  // load from json file  azkar file

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<List<AzkarModel>> loadDataFromJson() async {
    _isLoading = true;
    notifyListeners();
    try {
      final allAzkar = await mehtodHelper.loadAzkar();
      // futureAzkar = Future.value(allAzkar);
      await splitZekr(allAzkar);
      return allAzkar;
    } catch (e) {
      throw "open file has error $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //save azkar in Local in  hive
  // Future<void> saveAzkarLocalStorage() async {
  //   try {

  //   } catch (e) {
  //     throw "error from svae in local storage";
  //   } finally {
  //     notifyListeners();
  //   }
  // }

  //// splite Azkar after read

  List<AzkarModel> azkarMorning = [];
  List<AzkarModel> azkarEvening = [];
  List<AzkarModel> azkarPrayers = [];
  List<AzkarModel> allPrayers = [];
  List<AzkarModel> praise = [];
  List<AzkarModel> variousDoaa = [];

  Future<void> splitZekr(List<AzkarModel> allZekrList) async {
    _isLoading = true;

    notifyListeners();
    try {
      azkarMorning.clear();
      azkarEvening.clear();
      azkarPrayers.clear();
      allPrayers.clear();
      praise.clear();
      variousDoaa.clear();
      for (var element in allZekrList) {
        if (element.category.contains("أذكار الصباح")) {
          azkarMorning.add(element);
        } else if (element.category.contains("أذكار المساء")) {
          azkarEvening.add(element);
        } else if (element.search.contains("الصلاة")) {
          azkarPrayers.add(element);
        } else if (element.search.contains("دعاء")) {
          allPrayers.add(element);
        } else if (element.search.contains("التسبيح") ||
            element.search.contains("الاستغفار")) {
          praise.add(element);
        } else {
          variousDoaa.add(element);
        }
      }
      // await hive.putData<List<AzkarModel>>(
      //   HiveKeys.allAzkarBox,
      //   HiveKeys.azkarMorningKey,
      //   azkarMorning,
      // );
      // await hive.putData<List<AzkarModel>>(
      //   HiveKeys.allAzkarBox,
      //   HiveKeys.azkarEveningKey,
      //   azkarEvening,
      // );
      // await hive.putData<List<AzkarModel>>(
      //   HiveKeys.allAzkarBox,
      //   HiveKeys.azkarPrayersKey,
      //   azkarPrayers,
      // );
      // await hive.putData<List<AzkarModel>>(
      //   HiveKeys.allAzkarBox,
      //   HiveKeys.allPrayersKey,
      //   allPrayers,
      // );
      // await hive.putData<List<AzkarModel>>(
      //   HiveKeys.allAzkarBox,
      //   HiveKeys.praiseKey,
      //   praise,
      // );
      // await hive.putData<List<AzkarModel>>(
      //   HiveKeys.allAzkarBox,
      //   HiveKeys.variousDoaaKey,
      //   variousDoaa,
      // );
    } catch (e) {
      log('error in splite ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
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
  void toggleItemFavList(AzkarModel item) async {
    try {
      if (favList.containsKey(item.id)) {
        await sl.get<HiveService>().deleteData<FavItemsModel>(
          'favBox',
          item.id,
        );
        favList.remove(item.id);
        item.isFav = false;
      } else {
        favList[item.id] = item;
        item.isFav = true;
        await saveFavList();
      }
    } catch (e) {
      log("toggleItemFavList error : ${e.toString()}");
    } finally {
      notifyListeners();
    }
  }

  //save  FavItem in hive
  Future<void> saveFavList() async {
    try {
      final favItems = favList.entries
          .map((entry) => FavItemsModel(id: entry.key, azkarModel: entry.value))
          .toList();

      for (var item in favItems) {
        await sl.get<HiveService>().putData<FavItemsModel>(
          'favBox',
          item.id,
          item,
        );
      }
    } catch (e) {
      log("saveFavList error : ${e.toString()}");
    }
  }

  //loading  FavItem in hive
  Future<void> loadFavList() async {
    favList = Map.fromEntries(
      sl
          .get<HiveService>()
          .getAllData<FavItemsModel>('favBox')
          .map((favItem) => MapEntry(favItem.id, favItem.azkarModel)),
    );
    notifyListeners();
  }

  // load to from hive
  // Future<void> loadAzkarFromHive() async {
  //   try {
  //     final hive = sl.get<HiveService>();

  //     azkarMorning =
  //         (await hive.getData<List<AzkarModel>>(
  //           HiveKeys.allAzkarBox,
  //           HiveKeys.azkarMorningKey,
  //         )) ??
  //         [];

  //     azkarEvening =
  //         (await hive.getData<List<AzkarModel>>(
  //           HiveKeys.allAzkarBox,
  //           HiveKeys.azkarEveningKey,
  //         )) ??
  //         [];

  //     azkarPrayers =
  //         (await hive.getData<List<AzkarModel>>(
  //           HiveKeys.allAzkarBox,
  //           HiveKeys.azkarPrayersKey,
  //         )) ??
  //         [];

  //     allPrayers =
  //         (await hive.getData<List<AzkarModel>>(
  //           HiveKeys.allAzkarBox,
  //           HiveKeys.allPrayersKey,
  //         )) ??
  //         [];

  //     praise =
  //         (await hive.getData<List<AzkarModel>>(
  //           HiveKeys.allAzkarBox,
  //           HiveKeys.praiseKey,
  //         )) ??
  //         [];

  //     variousDoaa =
  //         (await hive.getData<List<AzkarModel>>(
  //           HiveKeys.allAzkarBox,
  //           HiveKeys.variousDoaaKey,
  //         )) ??
  //         [];
  //   } catch (e) {
  //     log("loadAzkarFromHive errr :${e.toString()} ");
  //   } finally {
  //     notifyListeners();
  //   }
  // }
}
