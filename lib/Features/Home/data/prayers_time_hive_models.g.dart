// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayers_time_hive_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimingsHiveModelAdapter extends TypeAdapter<TimingsHiveModel> {
  @override
  final int typeId = 0;

  @override
  TimingsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimingsHiveModel(
      fajr: fields[0] as String,
      sunrise: fields[1] as String,
      dhuhr: fields[2] as String,
      asr: fields[3] as String,
      sunset: fields[4] as String,
      maghrib: fields[5] as String,
      isha: fields[6] as String,
      imsak: fields[7] as String,
      midnight: fields[8] as String,
      firstthird: fields[9] as String,
      lastthird: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TimingsHiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.fajr)
      ..writeByte(1)
      ..write(obj.sunrise)
      ..writeByte(2)
      ..write(obj.dhuhr)
      ..writeByte(3)
      ..write(obj.asr)
      ..writeByte(4)
      ..write(obj.sunset)
      ..writeByte(5)
      ..write(obj.maghrib)
      ..writeByte(6)
      ..write(obj.isha)
      ..writeByte(7)
      ..write(obj.imsak)
      ..writeByte(8)
      ..write(obj.midnight)
      ..writeByte(9)
      ..write(obj.firstthird)
      ..writeByte(10)
      ..write(obj.lastthird);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimingsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HijriWeekdayHiveModelAdapter extends TypeAdapter<HijriWeekdayHiveModel> {
  @override
  final int typeId = 1;

  @override
  HijriWeekdayHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HijriWeekdayHiveModel(
      en: fields[0] as String,
      ar: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HijriWeekdayHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.en)
      ..writeByte(1)
      ..write(obj.ar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HijriWeekdayHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HijriMonthHiveModelAdapter extends TypeAdapter<HijriMonthHiveModel> {
  @override
  final int typeId = 2;

  @override
  HijriMonthHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HijriMonthHiveModel(
      number: fields[0] as int,
      en: fields[1] as String,
      ar: fields[2] as String,
      days: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HijriMonthHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.en)
      ..writeByte(2)
      ..write(obj.ar)
      ..writeByte(3)
      ..write(obj.days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HijriMonthHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HijriDesignationHiveModelAdapter
    extends TypeAdapter<HijriDesignationHiveModel> {
  @override
  final int typeId = 3;

  @override
  HijriDesignationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HijriDesignationHiveModel(
      abbreviated: fields[0] as String,
      expanded: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HijriDesignationHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.abbreviated)
      ..writeByte(1)
      ..write(obj.expanded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HijriDesignationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HijriDateHiveModelAdapter extends TypeAdapter<HijriDateHiveModel> {
  @override
  final int typeId = 4;

  @override
  HijriDateHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HijriDateHiveModel(
      date: fields[0] as String,
      format: fields[1] as String,
      day: fields[2] as String,
      weekday: fields[3] as HijriWeekdayHiveModel,
      month: fields[4] as HijriMonthHiveModel,
      year: fields[5] as String,
      designation: fields[6] as HijriDesignationHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, HijriDateHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.format)
      ..writeByte(2)
      ..write(obj.day)
      ..writeByte(3)
      ..write(obj.weekday)
      ..writeByte(4)
      ..write(obj.month)
      ..writeByte(5)
      ..write(obj.year)
      ..writeByte(6)
      ..write(obj.designation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HijriDateHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GregorianWeekdayHiveModelAdapter
    extends TypeAdapter<GregorianWeekdayHiveModel> {
  @override
  final int typeId = 5;

  @override
  GregorianWeekdayHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GregorianWeekdayHiveModel(
      en: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GregorianWeekdayHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.en);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GregorianWeekdayHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GregorianMonthHiveModelAdapter
    extends TypeAdapter<GregorianMonthHiveModel> {
  @override
  final int typeId = 6;

  @override
  GregorianMonthHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GregorianMonthHiveModel(
      number: fields[0] as int,
      en: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GregorianMonthHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.en);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GregorianMonthHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GregorianDesignationHiveModelAdapter
    extends TypeAdapter<GregorianDesignationHiveModel> {
  @override
  final int typeId = 7;

  @override
  GregorianDesignationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GregorianDesignationHiveModel(
      abbreviated: fields[0] as String,
      expanded: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GregorianDesignationHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.abbreviated)
      ..writeByte(1)
      ..write(obj.expanded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GregorianDesignationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GregorianDateHiveModelAdapter
    extends TypeAdapter<GregorianDateHiveModel> {
  @override
  final int typeId = 8;

  @override
  GregorianDateHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GregorianDateHiveModel(
      date: fields[0] as String,
      format: fields[1] as String,
      day: fields[2] as String,
      weekday: fields[3] as GregorianWeekdayHiveModel,
      month: fields[4] as GregorianMonthHiveModel,
      year: fields[5] as String,
      designation: fields[6] as GregorianDesignationHiveModel,
      lunarSighting: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GregorianDateHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.format)
      ..writeByte(2)
      ..write(obj.day)
      ..writeByte(3)
      ..write(obj.weekday)
      ..writeByte(4)
      ..write(obj.month)
      ..writeByte(5)
      ..write(obj.year)
      ..writeByte(6)
      ..write(obj.designation)
      ..writeByte(7)
      ..write(obj.lunarSighting);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GregorianDateHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DateModelHiveModelAdapter extends TypeAdapter<DateModelHiveModel> {
  @override
  final int typeId = 9;

  @override
  DateModelHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DateModelHiveModel(
      readable: fields[0] as String,
      timestamp: fields[1] as String,
      hijri: fields[2] as HijriDateHiveModel,
      gregorian: fields[3] as GregorianDateHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, DateModelHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.readable)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.hijri)
      ..writeByte(3)
      ..write(obj.gregorian);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateModelHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PrayerDataHiveModelAdapter extends TypeAdapter<PrayerDataHiveModel> {
  @override
  final int typeId = 10;

  @override
  PrayerDataHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrayerDataHiveModel(
      timings: fields[0] as TimingsHiveModel,
      date: fields[1] as DateModelHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, PrayerDataHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.timings)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayerDataHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
