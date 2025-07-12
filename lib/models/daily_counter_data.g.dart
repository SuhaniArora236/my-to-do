// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_counter_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyCounterDataAdapter extends TypeAdapter<DailyCounterData> {
  @override
  final int typeId = 0;

  @override
  DailyCounterData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyCounterData(
      count: fields[0] as int,
      lastUpdatedDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DailyCounterData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.lastUpdatedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyCounterDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
