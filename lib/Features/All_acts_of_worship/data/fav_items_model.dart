import 'package:azkark/Features/All_acts_of_worship/data/all_azkar_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'fav_items_model.g.dart';
@HiveType(typeId: 13)
class FavItemsModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final AzkarModel azkarModel;

  FavItemsModel({required this.id, required this.azkarModel});
}
