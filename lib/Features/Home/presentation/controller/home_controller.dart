import 'dart:developer';

import 'package:azkark/Features/Home/data/current_location_model.dart';
import 'package:azkark/Features/Home/data/prayer_time_response_model.dart';
import 'package:azkark/Features/Home/data/prayers_time_hive_models.dart';
import 'package:azkark/Features/Home/domain/home_repo.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/hive_keys.dart';
import 'package:azkark/core/utils/cache/hive_service.dart';
import 'package:azkark/core/utils/location/check_location_permession.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  CurrentLocationModel? currentLocation;

  Future<void> initLocation() async {
    final loc = sl<CheckLocationPermession>();
    try {
      final position = await loc.determineLocation();
      currentLocation = CurrentLocationModel(
        position.latitude.toString(),
        position.longitude.toString(),
      );
    } catch (e) {
      log("Error: $e");
    } finally {
      notifyListeners();
    }
  }

  // fetch Prayers Time by lat and long
  final HomeRepo _homeRepo;
  PrayerData? prayerTimes;
  PrayerDataHiveModel? prayerTimesHive;
  String _errorMsg = '';
  String get errorMsg => _errorMsg;
  Future<void> fetchPrayersTimes() async {
    _errorMsg = '';
    try {
      if (currentLocation == null) {
        await initLocation();

        // () async {
        //   await fetchPrayersTimes();
        // };
      }
      final result = await _homeRepo.getPrayersTime(
        currentLocation!.lat,
        currentLocation!.long,
      );
      prayerTimes = result.data;
    } catch (e) {
      _errorMsg = "Error : ${e.toString()}";
      log("_this is error message ${e.toString()}. 😓😓😓😓😓");
    } finally {
      if (prayerTimes != null) {
        prayerTimesHive = prayerTimes!.toHiveModel();
        await sl<HiveService>().putData<PrayerDataHiveModel>(
          HiveKeys.prayersBox,
          HiveKeys.prayersTimesTodayKey,
          prayerTimesHive!,
        );
      }
      notifyListeners();
    }
  }

  //next prayer Time controller
  int _nextprayerTimeIndex = 0;
  int get nextprayerTimeIndex => _nextprayerTimeIndex;
  void toggleNextPrayerTimeIndex(int index) {
    _nextprayerTimeIndex = index;
    notifyListeners();
  }
  //BottomNavigationBar

  HomeController({required HomeRepo homeRepo}) : _homeRepo = homeRepo;
  int _bottomNavigationIndex = 0;

  int get bottomNavigationIndex => _bottomNavigationIndex;
  void toggleBottomNavigationIndex(int index) {
    _bottomNavigationIndex = index;
    notifyListeners();
  }
}
