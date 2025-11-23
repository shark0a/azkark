import 'package:azkark/Features/Home/data/prayers_time_hive_models.dart';
import 'package:hive/hive.dart';

void registerAdapters() {
  Hive.registerAdapter(PrayerDataHiveModelAdapter());
  Hive.registerAdapter(TimingsHiveModelAdapter());
  Hive.registerAdapter(DateModelHiveModelAdapter());
  Hive.registerAdapter(HijriDateHiveModelAdapter());
  Hive.registerAdapter(HijriWeekdayHiveModelAdapter());
  Hive.registerAdapter(HijriMonthHiveModelAdapter());
  Hive.registerAdapter(HijriDesignationHiveModelAdapter());
  Hive.registerAdapter(GregorianDateHiveModelAdapter());
  Hive.registerAdapter(GregorianWeekdayHiveModelAdapter());
  Hive.registerAdapter(GregorianMonthHiveModelAdapter());
  Hive.registerAdapter(GregorianDesignationHiveModelAdapter());
}