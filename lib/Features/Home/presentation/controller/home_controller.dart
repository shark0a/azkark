import 'dart:async';
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
import 'package:azkark/core/services/back_ground_service/notification_handler/notification_service.dart';

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
    } else {
      // First app open: use system locale if available, otherwise default to English
      final systemLocale = WidgetsBinding.instance.window.locale;
      if (systemLocale.languageCode == 'ar') {
        _locale = const Locale('ar', 'EG');
      } else {
        _locale = const Locale('en', 'US');
      }
      // Save the selected locale
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
    final loc = sl<LocationService>();
    try {
      final position = await loc.getLocation();
      currentLocation = CurrentLocationModel(
        position.latitude.toString(),
        position.longitude.toString(),
      );
    } catch (e) {
      log("Error getting location: $e");
    } finally {
      if (currentLocation != null) {
        await sl.get<HiveService>().putData<CurrentLocationModel>(
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
      log("Error: ${e.toString()}");
    } finally {
      if (prayerTimes != null) {
        await sl.get<SharedPref>().setString(
          SharedPrefKeys.countryName,
          prayerTimes!.meta.timezone,
        );

        final hiveService = sl<HiveService>();
        final oldData = hiveService.getData<PrayerDataHiveModel>(
          HiveKeys.prayersBox,
          HiveKeys.prayersTimesTodayKey,
        );

        if (oldData != null) {
          await hiveService.deleteData<PrayerDataHiveModel>(
            HiveKeys.prayersBox,
            HiveKeys.prayersTimesTodayKey,
          );
        }

        prayerTimesHive = prayerTimes!.toHiveModel();
        await hiveService.putData<PrayerDataHiveModel>(
          HiveKeys.prayersBox,
          HiveKeys.prayersTimesTodayKey,
          prayerTimesHive!,
        );
      }
      _isFetchingPrayerTimes = false;
      notifyListeners();
    }
  }

  Future<void> cleanOldData() async {
    try {
      final prefs = sl.get<SharedPref>();
      final lastCleanup = prefs.getInt('lastDataCleanup') ?? 0;
      final now = DateTime.now().millisecondsSinceEpoch;

      if (now - lastCleanup > 604800000) {
        final hive = sl.get<HiveService>();

        await NotificationService.instance.cancelAll();

        await prefs.setInt('lastDataCleanup', now);
        log('Old data cleaned successfully');
      }
    } catch (e) {
      log('Error cleaning old data: $e');
    }
  }

  String? nextPrayerKeyLocal; // Store prayer key instead of name
  String? nextPrayerTimeLocal;

  Future<void> fetchNextPrayer() async {
    try {
      final now = TimeOfDay.now();

      // Use lowercase keys to match banner lookup
      final prayerMap = {
        "fajr":
            prayerTimes?.timings.fajr ??
            prayerTimesHive?.timings.fajr ??
            "00:00",
        "dhuhr":
            prayerTimes?.timings.dhuhr ??
            prayerTimesHive?.timings.dhuhr ??
            "00:00",
        "asr":
            prayerTimes?.timings.asr ?? prayerTimesHive?.timings.asr ?? "00:00",
        "maghrib":
            prayerTimes?.timings.maghrib ??
            prayerTimesHive?.timings.maghrib ??
            "00:00",
        "isha":
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

      if (upcoming.isNotEmpty) {
        upcoming.sort((a, b) => a.value!.hour.compareTo(b.value!.hour));
        final next = upcoming.first;
        nextPrayerKeyLocal = next.key; // Store prayer key (lowercase)
        nextPrayerTimeLocal = prayerMap[next.key];
      } else {
        nextPrayerKeyLocal = "fajr";
        nextPrayerTimeLocal = prayerMap["fajr"];
      }
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

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
      // If prayer was disabled, cancel its notification; if enabled, reschedule daily prayers
      final isActive = updatedActivePrayers[prayerKey] ?? true;
      if (!isActive) {
        // await NotificationService.instance.init();
        await NotificationService.instance.cancelForPrayer(prayerKey);
      } else {
        await NotificationService.instance.init();
        await NotificationService.instance.scheduleDailyPrayers();
      }
    } catch (e) {
      log("Error toggling prayer active state: $e");
    }
  }
}
