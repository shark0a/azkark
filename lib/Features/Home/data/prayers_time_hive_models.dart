import 'package:hive/hive.dart';

part 'prayers_time_hive_models.g.dart';

// ---------------- TIMINGS ----------------
@HiveType(typeId: 0)
class TimingsHiveModel extends HiveObject {
  @HiveField(0)
  final String fajr;
  @HiveField(1)
  final String sunrise;
  @HiveField(2)
  final String dhuhr;
  @HiveField(3)
  final String asr;
  @HiveField(4)
  final String sunset;
  @HiveField(5)
  final String maghrib;
  @HiveField(6)
  final String isha;
  @HiveField(7)
  final String imsak;
  @HiveField(8)
  final String midnight;
  @HiveField(9)
  final String firstthird;
  @HiveField(10)
  final String lastthird;

  TimingsHiveModel({
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
}

// ---------------- HIJRI ----------------
@HiveType(typeId: 1)
class HijriWeekdayHiveModel extends HiveObject {
  @HiveField(0)
  final String en;
  @HiveField(1)
  final String ar;

  HijriWeekdayHiveModel({required this.en, required this.ar});
}

@HiveType(typeId: 2)
class HijriMonthHiveModel extends HiveObject {
  @HiveField(0)
  final int number;
  @HiveField(1)
  final String en;
  @HiveField(2)
  final String ar;
  @HiveField(3)
  final int days;

  HijriMonthHiveModel({
    required this.number,
    required this.en,
    required this.ar,
    required this.days,
  });
}

@HiveType(typeId: 3)
class HijriDesignationHiveModel extends HiveObject {
  @HiveField(0)
  final String abbreviated;
  @HiveField(1)
  final String expanded;

  HijriDesignationHiveModel({
    required this.abbreviated,
    required this.expanded,
  });
}

@HiveType(typeId: 4)
class HijriDateHiveModel extends HiveObject {
  @HiveField(0)
  final String date;
  @HiveField(1)
  final String format;
  @HiveField(2)
  final String day;
  @HiveField(3)
  final HijriWeekdayHiveModel weekday;
  @HiveField(4)
  final HijriMonthHiveModel month;
  @HiveField(5)
  final String year;
  @HiveField(6)
  final HijriDesignationHiveModel designation;

  HijriDateHiveModel({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
  });
}

// ---------------- GREGORIAN ----------------
@HiveType(typeId: 5)
class GregorianWeekdayHiveModel extends HiveObject {
  @HiveField(0)
  final String en;

  GregorianWeekdayHiveModel({required this.en});
}

@HiveType(typeId: 6)
class GregorianMonthHiveModel extends HiveObject {
  @HiveField(0)
  final int number;
  @HiveField(1)
  final String en;

  GregorianMonthHiveModel({required this.number, required this.en});
}

@HiveType(typeId: 7)
class GregorianDesignationHiveModel extends HiveObject {
  @HiveField(0)
  final String abbreviated;
  @HiveField(1)
  final String expanded;

  GregorianDesignationHiveModel({
    required this.abbreviated,
    required this.expanded,
  });
}

@HiveType(typeId: 8)
class GregorianDateHiveModel extends HiveObject {
  @HiveField(0)
  final String date;
  @HiveField(1)
  final String format;
  @HiveField(2)
  final String day;
  @HiveField(3)
  final GregorianWeekdayHiveModel weekday;
  @HiveField(4)
  final GregorianMonthHiveModel month;
  @HiveField(5)
  final String year;
  @HiveField(6)
  final GregorianDesignationHiveModel designation;
  @HiveField(7)
  final bool lunarSighting;

  GregorianDateHiveModel({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.lunarSighting,
  });
}

// ---------------- DATE MODEL ----------------
@HiveType(typeId: 9)
class DateModelHiveModel extends HiveObject {
  @HiveField(0)
  final String readable;
  @HiveField(1)
  final String timestamp;
  @HiveField(2)
  final HijriDateHiveModel hijri;
  @HiveField(3)
  final GregorianDateHiveModel gregorian;

  DateModelHiveModel({
    required this.readable,
    required this.timestamp,
    required this.hijri,
    required this.gregorian,
  });
}

@HiveType(typeId: 18)
class MetaHiveModel extends HiveObject {
  @HiveField(0)
  final double latitude;
  @HiveField(1)
  final double longitude;
  @HiveField(2)
  final String timezone;
  @HiveField(3)
  final MethodHiveModel method;
  @HiveField(4)
  final String latitudeAdjustmentMethod;
  @HiveField(5)
  final String midnightMode;
  @HiveField(6)
  final String school;
  @HiveField(7)
  final Map<String, int> offset;

  MetaHiveModel({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,
    required this.offset,
  });
}

@HiveType(typeId: 12)
class MethodHiveModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final MethodParamsHiveModel params;
  @HiveField(3)
  final MethodLocationHiveModel location;

  MethodHiveModel({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });
}

@HiveType(typeId: 15)
class MethodParamsHiveModel extends HiveObject {
  @HiveField(0)
  final double fajr;
  @HiveField(1)
  final double isha;

  MethodParamsHiveModel({required this.fajr, required this.isha});
}

@HiveType(typeId: 17)
class MethodLocationHiveModel extends HiveObject {
  @HiveField(0)
  final double latitude;
  @HiveField(1)
  final double longitude;

  MethodLocationHiveModel({required this.latitude, required this.longitude});
}

// ---------------- PRAYER DATA ----------------
@HiveType(typeId: 10)
class PrayerDataHiveModel extends HiveObject {
  @HiveField(0)
  final TimingsHiveModel timings;
  @HiveField(1)
  final DateModelHiveModel date;
  @HiveField(2)
  final MetaHiveModel meta; // ✅ إضافة الـ Meta
  @HiveField(3)
  final Map<String, bool> activePrayers;

  PrayerDataHiveModel({
    required this.timings,
    required this.date,
    required this.meta, // ✅ إضافة الـ Meta
    required this.activePrayers,
  });
}
