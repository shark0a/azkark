// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Azkark`
  String get appTitle {
    return Intl.message(
      'Azkark',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get stop {
    return Intl.message(
      'Stop',
      name: 'stop',
      desc: '',
      args: [],
    );
  }

  /// `Daily Azkar`
  String get dailyAzkar {
    return Intl.message(
      'Daily Azkar',
      name: 'dailyAzkar',
      desc: '',
      args: [],
    );
  }

  /// `Count: {count}`
  String count_label(Object count) {
    return Intl.message(
      'Count: $count',
      name: 'count_label',
      desc: '',
      args: [count],
    );
  }

  /// `Welcome`
  String get welcome_message {
    return Intl.message(
      'Welcome',
      name: 'welcome_message',
      desc: '',
      args: [],
    );
  }

  /// `Choose Zekr`
  String get choose_zekr {
    return Intl.message(
      'Choose Zekr',
      name: 'choose_zekr',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start_label {
    return Intl.message(
      'Start',
      name: 'start_label',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Prayer Times`
  String get prayer_title {
    return Intl.message(
      'Prayer Times',
      name: 'prayer_title',
      desc: '',
      args: [],
    );
  }

  /// `Fajr`
  String get prayer_fajr {
    return Intl.message(
      'Fajr',
      name: 'prayer_fajr',
      desc: '',
      args: [],
    );
  }

  /// `Dhuhr`
  String get prayer_dhuhr {
    return Intl.message(
      'Dhuhr',
      name: 'prayer_dhuhr',
      desc: '',
      args: [],
    );
  }

  /// `Asr`
  String get prayer_asr {
    return Intl.message(
      'Asr',
      name: 'prayer_asr',
      desc: '',
      args: [],
    );
  }

  /// `Maghrib`
  String get prayer_maghrib {
    return Intl.message(
      'Maghrib',
      name: 'prayer_maghrib',
      desc: '',
      args: [],
    );
  }

  /// `Isha`
  String get prayer_isha {
    return Intl.message(
      'Isha',
      name: 'prayer_isha',
      desc: '',
      args: [],
    );
  }

  /// `Sunrise`
  String get prayer_sunrise {
    return Intl.message(
      'Sunrise',
      name: 'prayer_sunrise',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings_title {
    return Intl.message(
      'Settings',
      name: 'settings_title',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version_label {
    return Intl.message(
      'Version',
      name: 'version_label',
      desc: '',
      args: [],
    );
  }

  /// `Next prayer:`
  String get next_prayer_label {
    return Intl.message(
      'Next prayer:',
      name: 'next_prayer_label',
      desc: '',
      args: [],
    );
  }

  /// `Place`
  String get place_label {
    return Intl.message(
      'Place',
      name: 'place_label',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown_label {
    return Intl.message(
      'Unknown',
      name: 'unknown_label',
      desc: '',
      args: [],
    );
  }

  /// `All Worship`
  String get all_worship_label {
    return Intl.message(
      'All Worship',
      name: 'all_worship_label',
      desc: '',
      args: [],
    );
  }

  /// `Home\nPage`
  String get home_page_label {
    return Intl.message(
      'Home\nPage',
      name: 'home_page_label',
      desc: '',
      args: [],
    );
  }

  /// `Prayer Times`
  String get prayer_times_label {
    return Intl.message(
      'Prayer Times',
      name: 'prayer_times_label',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings_label {
    return Intl.message(
      'Settings',
      name: 'settings_label',
      desc: '',
      args: [],
    );
  }

  /// `Time left`
  String get time_left_label {
    return Intl.message(
      'Time left',
      name: 'time_left_label',
      desc: '',
      args: [],
    );
  }

  /// `for prayer `
  String get for_prayer_prefix {
    return Intl.message(
      'for prayer ',
      name: 'for_prayer_prefix',
      desc: '',
      args: [],
    );
  }

  /// `Morning Azkar`
  String get azkar_morning {
    return Intl.message(
      'Morning Azkar',
      name: 'azkar_morning',
      desc: '',
      args: [],
    );
  }

  /// `Evening Azkar`
  String get azkar_evening {
    return Intl.message(
      'Evening Azkar',
      name: 'azkar_evening',
      desc: '',
      args: [],
    );
  }

  /// `Prayer Azkar`
  String get azkar_prayer {
    return Intl.message(
      'Prayer Azkar',
      name: 'azkar_prayer',
      desc: '',
      args: [],
    );
  }

  /// `All Duas`
  String get all_duas {
    return Intl.message(
      'All Duas',
      name: 'all_duas',
      desc: '',
      args: [],
    );
  }

  /// `Tasbih`
  String get tasbih {
    return Intl.message(
      'Tasbih',
      name: 'tasbih',
      desc: '',
      args: [],
    );
  }

  /// `Hijri Calendar`
  String get hijri_calendar {
    return Intl.message(
      'Hijri Calendar',
      name: 'hijri_calendar',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Prayer Times`
  String get prayer_settings {
    return Intl.message(
      'Prayer Times',
      name: 'prayer_settings',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english_lang {
    return Intl.message(
      'English',
      name: 'english_lang',
      desc: '',
      args: [],
    );
  }

  /// `Update Location`
  String get update_location {
    return Intl.message(
      'Update Location',
      name: 'update_location',
      desc: '',
      args: [],
    );
  }

  /// `App Version`
  String get app_version {
    return Intl.message(
      'App Version',
      name: 'app_version',
      desc: '',
      args: [],
    );
  }

  /// `Gregorian`
  String get gregorian {
    return Intl.message(
      'Gregorian',
      name: 'gregorian',
      desc: '',
      args: [],
    );
  }

  /// `Hijri`
  String get hijri {
    return Intl.message(
      'Hijri',
      name: 'hijri',
      desc: '',
      args: [],
    );
  }

  /// `Gregorian Date:`
  String get gregorian_date {
    return Intl.message(
      'Gregorian Date:',
      name: 'gregorian_date',
      desc: '',
      args: [],
    );
  }

  /// `Hijri Date:`
  String get hijri_date {
    return Intl.message(
      'Hijri Date:',
      name: 'hijri_date',
      desc: '',
      args: [],
    );
  }

  /// `Conversion Error`
  String get error_converting {
    return Intl.message(
      'Conversion Error',
      name: 'error_converting',
      desc: '',
      args: [],
    );
  }

  /// `Zekr When Waking`
  String get zekr_awaken {
    return Intl.message(
      'Zekr When Waking',
      name: 'zekr_awaken',
      desc: '',
      args: [],
    );
  }

  /// `Zekr When Leaving Home`
  String get zekr_exit_home {
    return Intl.message(
      'Zekr When Leaving Home',
      name: 'zekr_exit_home',
      desc: '',
      args: [],
    );
  }

  /// `Zekr When Entering Home`
  String get zekr_enter_home {
    return Intl.message(
      'Zekr When Entering Home',
      name: 'zekr_enter_home',
      desc: '',
      args: [],
    );
  }

  /// `Zekr After Wudhu`
  String get zekr_wudhu {
    return Intl.message(
      'Zekr After Wudhu',
      name: 'zekr_wudhu',
      desc: '',
      args: [],
    );
  }

  /// `Virtue of Sending Blessings`
  String get zekr_prayer_virtue {
    return Intl.message(
      'Virtue of Sending Blessings',
      name: 'zekr_prayer_virtue',
      desc: '',
      args: [],
    );
  }

  /// `Times When Prayers Are Answered`
  String get zekr_prayer_answered {
    return Intl.message(
      'Times When Prayers Are Answered',
      name: 'zekr_prayer_answered',
      desc: '',
      args: [],
    );
  }

  /// `Zekr of the Azan`
  String get zekr_azan {
    return Intl.message(
      'Zekr of the Azan',
      name: 'zekr_azan',
      desc: '',
      args: [],
    );
  }

  /// `Zekr When Waking at Night`
  String get zekr_night_waking {
    return Intl.message(
      'Zekr When Waking at Night',
      name: 'zekr_night_waking',
      desc: '',
      args: [],
    );
  }

  /// `Ruqya from Quran`
  String get ruqya_quran {
    return Intl.message(
      'Ruqya from Quran',
      name: 'ruqya_quran',
      desc: '',
      args: [],
    );
  }

  /// `Ruqya from Sunnah`
  String get ruqya_sunnah {
    return Intl.message(
      'Ruqya from Sunnah',
      name: 'ruqya_sunnah',
      desc: '',
      args: [],
    );
  }

  /// `May Allah Bless the Prophet`
  String get may_allah_bless {
    return Intl.message(
      'May Allah Bless the Prophet',
      name: 'may_allah_bless',
      desc: '',
      args: [],
    );
  }

  /// `Glory be to Allah`
  String get subhanallah {
    return Intl.message(
      'Glory be to Allah',
      name: 'subhanallah',
      desc: '',
      args: [],
    );
  }

  /// `All praise is due to Allah`
  String get alhamdulillah {
    return Intl.message(
      'All praise is due to Allah',
      name: 'alhamdulillah',
      desc: '',
      args: [],
    );
  }

  /// `Allah is the Greatest`
  String get allahu_akbar {
    return Intl.message(
      'Allah is the Greatest',
      name: 'allahu_akbar',
      desc: '',
      args: [],
    );
  }

  /// `Glory be to Allah and Praise`
  String get subhanallah_bihamdihi {
    return Intl.message(
      'Glory be to Allah and Praise',
      name: 'subhanallah_bihamdihi',
      desc: '',
      args: [],
    );
  }

  /// `I seek forgiveness from Allah`
  String get astaghfirallah {
    return Intl.message(
      'I seek forgiveness from Allah',
      name: 'astaghfirallah',
      desc: '',
      args: [],
    );
  }

  /// `Electronic Tasbih`
  String get electronic_counter {
    return Intl.message(
      'Electronic Tasbih',
      name: 'electronic_counter',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
