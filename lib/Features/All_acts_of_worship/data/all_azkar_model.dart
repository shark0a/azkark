
class AzkarModel {
  final int id; // جديد
  final String category;
  final String zekr;
  final String description;
  final int count;
  final String reference;
  final String search;

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
      count: row[3] is int ? row[3] : int.tryParse("${row[3]}") ?? 0,
      reference: row[4] ?? "",
      search: row[5] ?? "",
      isFav: false,
    );
  }
}
