import 'dart:developer';
import 'package:azkark/Features/Home/data/current_location_model.dart';
import 'package:azkark/Features/Home/data/prayers_responses/prayer_time_response_model.dart';
import 'package:azkark/Features/Home/data/prayers_time_hive_models.dart';
import 'package:azkark/Features/Home/domain/repo/home_repo.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/hive_keys.dart';
import 'package:azkark/core/utils/cache/hive_service.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:azkark/core/utils/cache/shared_pref_keys.dart';
import 'package:azkark/core/utils/location/check_location_permession.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  // allow optional injection; if not provided take from sl
  HomeController({HomeRepo? homeRepo})
    : _homeRepo = homeRepo ?? sl.get<HomeRepo>() {
    _initLocal();
  }

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  Locale _locale = const Locale('en', 'US');
  Locale get locale => _locale;
  void _initLocal() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final lang = sl.get<SharedPref>().getString(SharedPrefKeys.langKey);
    final country = sl.get<SharedPref>().getString(SharedPrefKeys.countrykey);

    if (lang != null) {
      _locale = Locale(lang, country);
      notifyListeners();
    }
  }

  Future<void> toggleLocale() async {
    _locale = _locale.languageCode == 'en'
        ? const Locale('ar', 'EG')
        : const Locale('en', 'US');

    await sl.get<SharedPref>().setString(
      SharedPrefKeys.langKey,
      _locale.languageCode,
    );
    await sl.get<SharedPref>().setString(
      SharedPrefKeys.countrykey,
      _locale.countryCode ?? "",
    );
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

  // next prayer Time controller
  int _nextprayerTimeIndex = 0;
  int get nextprayerTimeIndex => _nextprayerTimeIndex;
  void toggleNextPrayerTimeIndex(int index) {
    _nextprayerTimeIndex = index;
    notifyListeners();
  }

  // BottomNavigationBar
  int _bottomNavigationIndex = 0;
  int get bottomNavigationIndex => _bottomNavigationIndex;
  void toggleBottomNavigationIndex(int index) {
    _bottomNavigationIndex = index;
    notifyListeners();
  }

  // Loading Local Data
  String _loadingLocalDataError = '';
  String get loadingLocalDataError => _loadingLocalDataError;
  String? _localCountyName;
  String? get localCountyName => _localCountyName;

  Future<void> loadingLocalData() async {
    try {
      prayerTimesHive = sl.get<HiveService>().getData<PrayerDataHiveModel>(
        HiveKeys.prayersBox,
        HiveKeys.prayersTimesTodayKey,
      );
      currentLocation = sl.get<HiveService>().getData<CurrentLocationModel>(
        HiveKeys.locationBox,
        HiveKeys.locationKey,
      );
      _localCountyName = sl.get<SharedPref>().getString(
        SharedPrefKeys.countryName,
      );

      notifyListeners();
    } catch (e) {
      _loadingLocalDataError = e.toString();
      notifyListeners();
      log(
        "error come from loading local data Home Controller   $_loadingLocalDataError",
      );
    }
  }

  // get current location
  CurrentLocationModel? currentLocation;

  bool _isLoadingLocation = false;
  bool get isLoadingLocation => _isLoadingLocation;

  bool _isFetchingPrayerTimes = false;
  bool get isFetchingPrayerTimes => _isFetchingPrayerTimes;

  Future<void> initLocation() async {
    _isLoadingLocation = true;
    notifyListeners();
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
      if (currentLocation != null) {
        sl.get<HiveService>().putData<CurrentLocationModel>(
          HiveKeys.locationBox,
          HiveKeys.locationKey,
          currentLocation!,
        );
      }
      _isLoadingLocation = false;
      notifyListeners();
    }
  }

  final HomeRepo _homeRepo;
  PrayerData? prayerTimes;
  PrayerDataHiveModel? prayerTimesHive;
  String _errorMsg = '';
  String get errorMsg => _errorMsg;

  Future<void> fetchPrayersTimes() async {
    _errorMsg = '';
    _isFetchingPrayerTimes = true;
    notifyListeners();

    try {
      if (currentLocation == null) {
        await initLocation();
      }
      final result = await _homeRepo.getPrayersTime(
        currentLocation!.lat,
        currentLocation!.long,
      );
      prayerTimes = result.data;
    } catch (e) {
      _errorMsg = "Error : ${e.toString()}";
      log("_this is error message ${e.toString()}.");
    } finally {
      if (prayerTimes != null) {
        await sl.get<SharedPref>().setString(
          SharedPrefKeys.countryName,
          prayerTimes!.meta.timezone,
        );
        prayerTimesHive = prayerTimes!.toHiveModel();
        await sl<HiveService>().putData<PrayerDataHiveModel>(
          HiveKeys.prayersBox,
          HiveKeys.prayersTimesTodayKey,
          prayerTimesHive!,
        );
      }
      _isFetchingPrayerTimes = false;
      notifyListeners();
    }
  }

  String? nextPrayerKeyLocal; // Store prayer key instead of name
  String? nextPrayerTimeLocal;

  Future<void> fetchNextPrayer() async {
    try {
      final now = TimeOfDay.now();

      final prayerMap = {
        "Fajr":
            prayerTimes?.timings.fajr ??
            prayerTimesHive?.timings.fajr ??
            "00:00",
        "Dhuhr":
            prayerTimes?.timings.dhuhr ??
            prayerTimesHive?.timings.dhuhr ??
            "00:00",
        "Asr":
            prayerTimes?.timings.asr ?? prayerTimesHive?.timings.asr ?? "00-00",
        "Maghrib":
            prayerTimes?.timings.maghrib ??
            prayerTimesHive?.timings.maghrib ??
            "00:00",
        "Isha":
            prayerTimes?.timings.isha ??
            prayerTimesHive?.timings.isha ??
            "00:00",
      };

      TimeOfDay? convert(String? time) {
        if (time == null) return null;
        // Accept formats like "HH:mm" or "HH-mm"; fallback to 00:00 if invalid
        final normalized = time.contains(":")
            ? time
            : time.replaceAll("-", ":");
        final parts = normalized.split(":");
        if (parts.length < 2) return null;
        final h = int.tryParse(parts[0]) ?? 0;
        final m = int.tryParse(parts[1]) ?? 0;
        return TimeOfDay(hour: h, minute: m);
      }

      final upcoming = prayerMap.entries
          .map((e) => MapEntry(e.key, convert(e.value)))
          .where((e) => e.value != null)
          .where(
            (e) =>
                e.value!.hour > now.hour ||
                (e.value!.hour == now.hour && e.value!.minute > now.minute),
          )
          .toList();

      // لو في صلوات جاية النهاردة
      if (upcoming.isNotEmpty) {
        upcoming.sort((a, b) => a.value!.hour.compareTo(b.value!.hour));
        final next = upcoming.first;
        nextPrayerKeyLocal = next.key; // Store prayer key
        nextPrayerTimeLocal = prayerMap[next.key];
      } else {
        // لو مفيش → الصلاة الجاية بكرة هي الفجر
        nextPrayerKeyLocal = "fajr";
        nextPrayerTimeLocal = prayerMap["fajr"];
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //fetchNextTime from internet
  // NextPrayerResponse? nextPrayer;
  // NextPrayerResponse? nextPrayerLocal;
  // Future<void> fetchNextTime() async {
  //   try {
  //     var result = await _homeRepo.nextPrayerTime(
  //       currentLocation!.lat,
  //       currentLocation!.long,
  //     );
  //     nextPrayer = result;
  //   } catch (e) {
  //     log("failed to fetch next prayers ${e.toString()}");
  //   } finally {
  //     log("from api  ${nextPrayer?.nextTimingValue}");
  //     if (nextPrayer != null) {
  //       await sl.get<HiveService>().putData<NextPrayerResponse>(
  //         HiveKeys.nextPrayerBox,
  //         HiveKeys.nextPrayerTimesTodayKey,
  //         nextPrayer!,
  //       );
  //     }
  //     notifyListeners();
  //   }
  // }

  // Future<void> loadNextTimeFromHive() async {
  //   try {
  //     nextPrayerLocal = sl.get<HiveService>().getData<NextPrayerResponse>(
  //       HiveKeys.nextPrayerBox,
  //       HiveKeys.nextPrayerTimesTodayKey,
  //     );
  //   } catch (e) {
  //     log("failed to Load from Hive next prayers ${e.toString()}");
  //   } finally {
  //     log("Hive : ${nextPrayerLocal?.nextTimingkey}");
  //     notifyListeners();
  //   }
  // }

  Future<void> toggleActive({required String prayerKey}) async {
    if (prayerTimesHive == null) return;

    try {
      final updatedActivePrayers = Map<String, bool>.from(
        prayerTimesHive!.activePrayers,
      );
      if (updatedActivePrayers.containsKey(prayerKey)) {
        updatedActivePrayers[prayerKey] =
            !(updatedActivePrayers[prayerKey] ?? true);
      } else {
        updatedActivePrayers[prayerKey] = true;
      }

      final updated = PrayerDataHiveModel(
        meta: prayerTimesHive!.meta,
        timings: prayerTimesHive!.timings,
        date: prayerTimesHive!.date,
        activePrayers: updatedActivePrayers,
      );

      await sl<HiveService>().putData<PrayerDataHiveModel>(
        HiveKeys.prayersBox,
        HiveKeys.prayersTimesTodayKey,
        updated,
      );

      prayerTimesHive = updated;

      notifyListeners();
    } catch (e) {
      log("Error toggling prayer active state: $e");
    }
  }
}
