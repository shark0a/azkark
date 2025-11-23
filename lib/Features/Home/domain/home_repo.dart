import 'package:azkark/Features/Home/data/prayer_time_response_model.dart';

abstract class HomeRepo {
  Future<PrayerTimesResponse> getPrayersTime(String latitude, String longitude);
}
