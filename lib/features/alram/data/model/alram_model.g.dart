// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alram_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmAdapter extends TypeAdapter<Alarm> {
  @override
  final int typeId = 0;

  @override
  Alarm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Alarm(
      label: fields[0] as String,
      time: fields[1] as DateTime,
      music: fields[2] as String,
      vibration: fields[3] as bool,
      paused: fields[4] as bool,
      alarmStatus: fields[5] as bool,
      activeDays: (fields[6] as List).cast<WeekDay>(),
      isExpanded: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Alarm obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.music)
      ..writeByte(3)
      ..write(obj.vibration)
      ..writeByte(4)
      ..write(obj.paused)
      ..writeByte(5)
      ..write(obj.alarmStatus)
      ..writeByte(6)
      ..write(obj.activeDays)
      ..writeByte(7)
      ..write(obj.isExpanded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeekDayAdapter extends TypeAdapter<WeekDay> {
  @override
  final int typeId = 0;

  @override
  WeekDay read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WeekDay.monday;
      case 1:
        return WeekDay.tuesday;
      case 2:
        return WeekDay.wednesday;
      case 3:
        return WeekDay.thursday;
      case 4:
        return WeekDay.friday;
      case 5:
        return WeekDay.saturday;
      case 6:
        return WeekDay.sunday;
      default:
        return WeekDay.monday;
    }
  }

  @override
  void write(BinaryWriter writer, WeekDay obj) {
    switch (obj) {
      case WeekDay.monday:
        writer.writeByte(0);
        break;
      case WeekDay.tuesday:
        writer.writeByte(1);
        break;
      case WeekDay.wednesday:
        writer.writeByte(2);
        break;
      case WeekDay.thursday:
        writer.writeByte(3);
        break;
      case WeekDay.friday:
        writer.writeByte(4);
        break;
      case WeekDay.saturday:
        writer.writeByte(5);
        break;
      case WeekDay.sunday:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeekDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
