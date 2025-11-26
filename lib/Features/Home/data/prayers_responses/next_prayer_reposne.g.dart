// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_prayer_reposne.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NextPrayerResponseAdapter extends TypeAdapter<NextPrayerResponse> {
  @override
  final int typeId = 14;

  @override
  NextPrayerResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NextPrayerResponse(
      nextTimingkey: fields[0] as String,
      nextTimingValue: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NextPrayerResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nextTimingkey)
      ..writeByte(1)
      ..write(obj.nextTimingValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NextPrayerResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
