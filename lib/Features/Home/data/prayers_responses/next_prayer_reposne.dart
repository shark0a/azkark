import 'package:hive/hive.dart';

part 'next_prayer_reposne.g.dart';

@HiveType(typeId: 14)
class NextPrayerResponse extends HiveObject {
  @HiveField(0)
  final String nextTimingkey; // اسم الصلاة الحالي
  @HiveField(1)
  final String nextTimingValue; // الوقت
  @HiveField(2)
  final String currentPrayersKey;
  @HiveField(3)
  final double currentPrayersValue;

  NextPrayerResponse({
    required this.nextTimingkey,
    required this.nextTimingValue,

    required this.currentPrayersKey,
    required this.currentPrayersValue,
  });

  factory NextPrayerResponse.fromJson(Map<String, dynamic> json) {
    final timings = json['data']['timings'] as Map<String, dynamic>;
    final params =
        json['data']['meta']['method']['params'] as Map<String, dynamic>;

    // ناخد أول عنصر من كل Map
    final timingKey = timings.keys.first;
    final timingValue = timings[timingKey] ?? '';

    final paramKeys = params.keys.toList();
    final paramKey2 = paramKeys[1];

    final paramValue2 = (params[paramKey2] ?? 0).toDouble();

    return NextPrayerResponse(
      nextTimingkey: timingKey,
      nextTimingValue: timingValue,

      currentPrayersKey: paramKey2,
      currentPrayersValue: paramValue2,
    );
  }
}
