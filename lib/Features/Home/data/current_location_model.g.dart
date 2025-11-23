// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentLocationModelAdapter extends TypeAdapter<CurrentLocationModel> {
  @override
  final int typeId = 10;

  @override
  CurrentLocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentLocationModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentLocationModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.long);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentLocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
