import 'package:azkark/Features/All_acts_of_worship/data/fav_items_model.dart';
import 'package:azkark/Features/Home/data/current_location_model.dart';
import 'package:azkark/Features/Home/data/prayers_responses/next_prayer_reposne.dart';
import 'package:azkark/Features/Home/data/prayers_time_hive_models.dart';
import 'package:azkark/Features/Home/domain/home_repo.dart';
import 'package:azkark/Features/Home/domain/home_repo_imple.dart';
import 'package:azkark/core/services/APIs/api_services.dart';
import 'package:azkark/core/utils/cache/hive_adapter_register.dart';
import 'package:azkark/core/utils/cache/hive_keys.dart';
import 'package:azkark/core/utils/cache/hive_service.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:azkark/core/utils/location/check_location_permession.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> setupServiceLocator({
  String baseUrl = 'https://api.aladhan.com/v1/',
}) async {
  //dio handle
  sl.registerLazySingleton<Dio>(() {
    final Dio dio = Dio(BaseOptions(baseUrl: baseUrl));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          //           final lang = sl<SharedPref>().getString(SharedKeys.lang) ?? 'en';
          // options.headers['Accept-Language'] = lang;
          return handler.next(options);
        },
      ),
    );
    dio.interceptors.add(
      LogInterceptor(responseBody: true, requestHeader: true),
    );
    return dio;
  });
  //Home Repo register
  sl.registerLazySingleton<HomeRepo>(
    () => HomeRepoImple(apiServices: sl<ApiServices>()),
  );

  //register api Service
  sl.registerLazySingleton<ApiServices>(() => ApiServices(dio: sl<Dio>()));
  // Register Hive service as singleton
  sl.registerLazySingleton<HiveService>(() => HiveService());
  final hiveServices = sl<HiveService>();
  await hiveServices.init();
  registerAdapters();

  await hiveServices.openBox<PrayerDataHiveModel>(HiveKeys.prayersBox);
  await hiveServices.openBox<CurrentLocationModel>(HiveKeys.locationBox);
  await hiveServices.openBox<NextPrayerResponse>(HiveKeys.nextPrayerBox);
  await hiveServices.openBox<FavItemsModel>("favBox");
  // Register SharedPref service as singleton
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<SharedPref>(
    () => SharedPref(sharedPref: sl<SharedPreferences>()),
  );
  //register helper mehtode class
  sl.registerLazySingleton<MehtodHelper>(() => MehtodHelper());
  //get Location
  sl.registerLazySingleton<CheckLocationPermession>(
    () => CheckLocationPermession(),
  );
}
