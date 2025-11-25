import 'package:azkark/Features/All_acts_of_worship/data/all_azkar_model.dart';
import 'package:azkark/Features/All_acts_of_worship/data/fav_items_model.dart';
import 'package:azkark/Features/Home/data/current_location_model.dart';
import 'package:azkark/Features/Home/data/prayers_responses/next_prayer_reposne.dart';
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
  Hive.registerAdapter(AzkarModelAdapter());
  Hive.registerAdapter(FavItemsModelAdapter());
  Hive.registerAdapter(CurrentLocationModelAdapter());
  Hive.registerAdapter(NextPrayerResponseAdapter());

}
