// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_azkar_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AzkarModelAdapter extends TypeAdapter<AzkarModel> {
  @override
  final int typeId = 12;

  @override
  AzkarModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AzkarModel(
      id: fields[0] as int,
      category: fields[1] as String,
      zekr: fields[2] as String,
      description: fields[3] as String,
      count: fields[4] as int,
      reference: fields[5] as String,
      search: fields[6] as String,
      isFav: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AzkarModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.zekr)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.reference)
      ..writeByte(6)
      ..write(obj.search)
      ..writeByte(7)
      ..write(obj.isFav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AzkarModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
