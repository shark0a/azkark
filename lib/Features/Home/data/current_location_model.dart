import 'package:hive_flutter/hive_flutter.dart';
part 'current_location_model.g.dart';

@HiveType(typeId: 11)
class CurrentLocationModel {
  @HiveField(0)
  final String lat;
  @HiveField(1)
  final String long;

  CurrentLocationModel(this.lat, this.long);
}
