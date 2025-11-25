import 'package:azkark/Features/Home/data/prayers_time_hive_models.dart';

class PrayerTimesResponse {
  final int code;
  final String status;
  final PrayerData data;

  PrayerTimesResponse({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PrayerTimesResponse.fromJson(Map<String, dynamic> json) {
    return PrayerTimesResponse(
      code: json['code'],
      status: json['status'],
      data: PrayerData.fromJson(json['data']),
    );
  }
}

// ---------------- DATA ----------------

class PrayerData {
  final Timings timings;
  final DateModel date;
  final Meta meta;

  PrayerData({required this.timings, required this.date, required this.meta});

  factory PrayerData.fromJson(Map<String, dynamic> json) {
    return PrayerData(
      timings: Timings.fromJson(json['timings']),
      date: DateModel.fromJson(json['date']),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

// ---------------- TIMINGS ----------------

class Timings {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  final String firstthird;
  final String lastthird;

  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstthird,
    required this.lastthird,
  });

  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      sunset: json['Sunset'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
      imsak: json['Imsak'],
      midnight: json['Midnight'],
      firstthird: json['Firstthird'],
      lastthird: json['Lastthird'],
    );
  }
}

// ---------------- DATE MODEL ----------------

class DateModel {
  final String readable;
  final String timestamp;
  final HijriDate hijri;
  final GregorianDate gregorian;

  DateModel({
    required this.readable,
    required this.timestamp,
    required this.hijri,
    required this.gregorian,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) {
    return DateModel(
      readable: json['readable'],
      timestamp: json['timestamp'],
      hijri: HijriDate.fromJson(json['hijri']),
      gregorian: GregorianDate.fromJson(json['gregorian']),
    );
  }
}

// ---------------- HIJRI DATE ----------------

class HijriDate {
  final String date;
  final String format;
  final String day;
  final HijriWeekday weekday;
  final HijriMonth month;
  final String year;
  final HijriDesignation designation;

  HijriDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
  });

  factory HijriDate.fromJson(Map<String, dynamic> json) {
    return HijriDate(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: HijriWeekday.fromJson(json['weekday']),
      month: HijriMonth.fromJson(json['month']),
      year: json['year'],
      designation: HijriDesignation.fromJson(json['designation']),
    );
  }
}

class HijriWeekday {
  final String en;
  final String ar;

  HijriWeekday({required this.en, required this.ar});

  factory HijriWeekday.fromJson(Map<String, dynamic> json) {
    return HijriWeekday(en: json['en'], ar: json['ar']);
  }
}

class HijriMonth {
  final int number;
  final String en;
  final String ar;
  final int days;

  HijriMonth({
    required this.number,
    required this.en,
    required this.ar,
    required this.days,
  });

  factory HijriMonth.fromJson(Map<String, dynamic> json) {
    return HijriMonth(
      number: json['number'],
      en: json['en'],
      ar: json['ar'],
      days: json['days'],
    );
  }
}

class HijriDesignation {
  final String abbreviated;
  final String expanded;

  HijriDesignation({required this.abbreviated, required this.expanded});

  factory HijriDesignation.fromJson(Map<String, dynamic> json) {
    return HijriDesignation(
      abbreviated: json['abbreviated'],
      expanded: json['expanded'],
    );
  }
}

// ---------------- GREGORIAN DATE ----------------

class GregorianDate {
  final String date;
  final String format;
  final String day;
  final GregorianWeekday weekday;
  final GregorianMonth month;
  final String year;
  final GregorianDesignation designation;
  final bool lunarSighting;

  GregorianDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.lunarSighting,
  });

  factory GregorianDate.fromJson(Map<String, dynamic> json) {
    return GregorianDate(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: GregorianWeekday.fromJson(json['weekday']),
      month: GregorianMonth.fromJson(json['month']),
      year: json['year'],
      designation: GregorianDesignation.fromJson(json['designation']),
      lunarSighting: json['lunarSighting'],
    );
  }
}

class GregorianWeekday {
  final String en;

  GregorianWeekday({required this.en});

  factory GregorianWeekday.fromJson(Map<String, dynamic> json) {
    return GregorianWeekday(en: json['en']);
  }
}

class GregorianMonth {
  final int number;
  final String en;

  GregorianMonth({required this.number, required this.en});

  factory GregorianMonth.fromJson(Map<String, dynamic> json) {
    return GregorianMonth(number: json['number'], en: json['en']);
  }
}

class GregorianDesignation {
  final String abbreviated;
  final String expanded;

  GregorianDesignation({required this.abbreviated, required this.expanded});

  factory GregorianDesignation.fromJson(Map<String, dynamic> json) {
    return GregorianDesignation(
      abbreviated: json['abbreviated'],
      expanded: json['expanded'],
    );
  }
}

// ---------------- META ----------------

class Meta {
  final double latitude;
  final double longitude;
  final String timezone;
  final Method method;
  final String latitudeAdjustmentMethod;
  final String midnightMode;
  final String school;
  final Map<String, int> offset;

  Meta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,
    required this.offset,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      timezone: json['timezone'],
      method: Method.fromJson(json['method']),
      latitudeAdjustmentMethod: json['latitudeAdjustmentMethod'],
      midnightMode: json['midnightMode'],
      school: json['school'],
      offset: Map<String, int>.from(json['offset']),
    );
  }
}

// ---------------- METHOD ----------------

class Method {
  final int id;
  final String name;
  final MethodParams params;
  final MethodLocation location;

  Method({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });

  factory Method.fromJson(Map<String, dynamic> json) {
    return Method(
      id: json['id'],
      name: json['name'],
      params: MethodParams.fromJson(json['params']),
      location: MethodLocation.fromJson(json['location']),
    );
  }
}

class MethodParams {
  final double fajr;
  final double isha;

  MethodParams({required this.fajr, required this.isha});

  factory MethodParams.fromJson(Map<String, dynamic> json) {
    return MethodParams(
      fajr: json['Fajr'].toDouble(),
      isha: json['Isha'].toDouble(),
    );
  }
}

class MethodLocation {
  final double latitude;
  final double longitude;

  MethodLocation({required this.latitude, required this.longitude});

  factory MethodLocation.fromJson(Map<String, dynamic> json) {
    return MethodLocation(
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }
}
extension PrayerDataExtension on PrayerData {
  PrayerDataHiveModel toHiveModel() {
    return PrayerDataHiveModel(
      timings: TimingsHiveModel(
        fajr: timings.fajr,
        sunrise: timings.sunrise,
        dhuhr: timings.dhuhr,
        asr: timings.asr,
        sunset: timings.sunset,
        maghrib: timings.maghrib,
        isha: timings.isha,
        imsak: timings.imsak,
        midnight: timings.midnight,
        firstthird: timings.firstthird,
        lastthird: timings.lastthird,
      ),
      date: DateModelHiveModel(
        readable: date.readable,
        timestamp: date.timestamp,
        hijri: HijriDateHiveModel(
          date: date.hijri.date,
          format: date.hijri.format,
          day: date.hijri.day,
          weekday: HijriWeekdayHiveModel(
            en: date.hijri.weekday.en,
            ar: date.hijri.weekday.ar,
          ),
          month: HijriMonthHiveModel(
            number: date.hijri.month.number,
            en: date.hijri.month.en,
            ar: date.hijri.month.ar,
            days: date.hijri.month.days,
          ),
          year: date.hijri.year,
          designation: HijriDesignationHiveModel(
            abbreviated: date.hijri.designation.abbreviated,
            expanded: date.hijri.designation.expanded,
          ),
        ),
        gregorian: GregorianDateHiveModel(
          date: date.gregorian.date,
          format: date.gregorian.format,
          day: date.gregorian.day,
          weekday: GregorianWeekdayHiveModel(en: date.gregorian.weekday.en),
          month: GregorianMonthHiveModel(
            number: date.gregorian.month.number,
            en: date.gregorian.month.en,
          ),
          year: date.gregorian.year,
          designation: GregorianDesignationHiveModel(
            abbreviated: date.gregorian.designation.abbreviated,
            expanded: date.gregorian.designation.expanded,
          ),
          lunarSighting: date.gregorian.lunarSighting,
        ),
      ),
      activePrayers: {
        'fajr': true,
        'sunrise': true,
        'dhuhr': true,
        'asr': true,
        'maghrib': true,
        'isha': true,
      },
    );
  }
}
