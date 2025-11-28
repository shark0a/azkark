
// class AzkarModel {
//   final int id; // جديد
//   final String category;
//   final String zekr;
//   final String description;
//   final int count;
//   final String reference;
//   final String search;

//   bool isFav;

//   AzkarModel({
//     required this.id,
//     required this.category,
//     required this.zekr,
//     required this.description,
//     required this.count,
//     required this.reference,
//     required this.search,
//     this.isFav = false,
//   });

//   factory AzkarModel.fromRow(List<dynamic> row, int id) {
//     return AzkarModel(
//       id: id,
//       category: row[0] ?? "",
//       zekr: row[1] ?? "",
//       description: row[2] ?? "",
//       count: row[3] is int ? row[3] : int.tryParse("${row[3]}") ?? 0,
//       reference: row[4] ?? "",
//       search: row[5] ?? "",
//       isFav: false,
//     );
//   }
// }
import 'package:hive/hive.dart';

part 'all_azkar_model.g.dart';

@HiveType(typeId: 16)
class AzkarModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final String zekr;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final int count;

  @HiveField(5)
  final String reference;

  @HiveField(6)
  final String search;

  @HiveField(7)
  bool isFav;

  AzkarModel({
    required this.id,
    required this.category,
    required this.zekr,
    required this.description,
    required this.count,
    required this.reference,
    required this.search,
    this.isFav = false,
  });

  factory AzkarModel.fromRow(List<dynamic> row, int id) {
    return AzkarModel(
      id: id,
      category: row[0] ?? "",
      zekr: row[1] ?? "",
      description: row[2] ?? "",
      count:
          row[3] is int ? row[3] : int.tryParse("${row[3]}") ?? 0,
      reference: row[4] ?? "",
      search: row[5] ?? "",
      isFav: false,
    );
  }
}
