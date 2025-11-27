import 'package:azkark/Features/Home/data/prayers_responses/prayer_time_response_model.dart';
import 'package:azkark/Features/Home/domain/repo/home_repo.dart';
import 'package:azkark/core/services/APIs/api_services.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class HomeRepoImple implements HomeRepo {
  final ApiServices _apiServices;

  HomeRepoImple({required ApiServices apiServices})
    : _apiServices = apiServices;
  @override
  Future<PrayerTimesResponse> getPrayersTime(
    String latitude,
    String longitude,
  ) async {
    try {
      var result = await _apiServices.get(
        'timings/${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'method': 5,
        },
      );
      return PrayerTimesResponse.fromJson(result);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.receiveTimeout) {
        throw "Please check the internet connection";
      }
      throw "Error occurred during API call: ${e.message}";
    } catch (e) {
      throw "unkown error ${e.toString()}";
    }
  }

  // @override
  // Future<NextPrayerResponse> nextPrayerTime(
  //   String latitude,
  //   String longitude,
  // ) async {
  //   try {
  //     var result = await _apiServices.get(
  //       'nextPrayer/${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
  //       queryParameters: {'latitude': latitude, 'longitude': longitude},
  //     );
  //     return NextPrayerResponse.fromJson(result);
  //   } on DioException catch (e) {
  //     if (e.type == DioExceptionType.connectionError ||
  //         e.type == DioExceptionType.connectionError ||
  //         e.type == DioExceptionType.receiveTimeout) {
  //       throw "Please check the internet connection";
  //     }
  //     throw "Error occurred during API call: ${e.message}";
  //   } catch (e) {
  //     throw "unkown error ${e.toString()}";
  //   }
  // }
}
