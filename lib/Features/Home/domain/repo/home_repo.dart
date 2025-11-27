import 'package:azkark/Features/Home/data/prayers_responses/prayer_time_response_model.dart';

abstract class HomeRepo {
  Future<PrayerTimesResponse> getPrayersTime(String latitude, String longitude);
  // Future<NextPrayerResponse> nextPrayerTime(String latitude, String longitude);
}
