
import 'package:azkark/Features/All_acts_of_worship/data/fav_items_model.dart';
import 'package:azkark/Features/Home/data/current_location_model.dart';
import 'package:azkark/Features/Home/data/prayers_responses/next_prayer_reposne.dart';
import 'package:azkark/Features/Home/data/prayers_time_hive_models.dart';
import 'package:azkark/Features/Home/domain/repo/home_repo.dart';
import 'package:azkark/Features/Home/domain/repo/home_repo_imple.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/core/services/APIs/api_services.dart';
import 'package:azkark/core/utils/cache/hive_adapter_register.dart';
import 'package:azkark/core/utils/cache/hive_keys.dart';
import 'package:azkark/core/utils/cache/hive_service.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:azkark/core/utils/location/check_location_permession.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator({
  String baseUrl = 'https://api.aladhan.com/v1/',
}) async {
  // Dio
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    // Set timeouts explicitly
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.sendTimeout = const Duration(seconds: 30);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
      ),
    );
    dio.interceptors.add(
      LogInterceptor(responseBody: true, requestHeader: true),
    );
    return dio;
  });

  // API Service
   sl.registerLazySingleton<ApiServices>(() => ApiServices(dio: sl<Dio>()));

  // Home Repo
  sl.registerLazySingleton<HomeRepo>(
    () => HomeRepoImple(apiServices: sl<ApiServices>()),
  );

  // Hive Service
  sl.registerLazySingleton<HiveService>(() => HiveService());
  final hiveService = sl<HiveService>();
  await hiveService.init();
  registerAdapters(); // لازم يكون عندك function لتسجيل الـ Hive adapters

  await hiveService.openBox<PrayerDataHiveModel>(HiveKeys.prayersBox);
  await hiveService.openBox<CurrentLocationModel>(HiveKeys.locationBox);
  await hiveService.openBox<NextPrayerResponse>(HiveKeys.nextPrayerBox);
  await hiveService.openBox<FavItemsModel>(HiveKeys.favBox);

  // Shared Preferences
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  sl.registerLazySingleton<SharedPref>(
    () => SharedPref(sharedPref: sl<SharedPreferences>()),
  );
  //home controller register
  sl.registerLazySingleton<HomeController>(() => HomeController());

  // Helpers
  sl.registerLazySingleton<MehtodHelper>(() => MehtodHelper());

  // Location permission checker
  sl.registerLazySingleton<CheckLocationPermession>(
    () => CheckLocationPermession(),
  );
}
