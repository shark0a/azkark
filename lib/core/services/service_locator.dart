import 'package:azkark/core/utils/helper/hive_service.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:azkark/core/utils/shared_pre.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> setupServiceLocator() async {
  // Register Hive service as singleton
  sl.registerLazySingleton<HiveService>(() => HiveService());
  // Register SharedPref service as singleton
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<SharedPref>(
    () => SharedPref(sharedPref: sl<SharedPreferences>()),
  );
  //register helper mehtode class
  sl.registerLazySingleton<MehtodHelper>(() => MehtodHelper());
}
