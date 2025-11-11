// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitModelAdapter extends TypeAdapter<HabitModel> {
  @override
  final int typeId = 0;

  @override
  HabitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitModel(
      lastResetWeek: fields[10] as DateTime?,
      id: fields[0] as String,
      nameHabit: fields[1] as String,
      goalHabitBerDay: fields[2] as String,
      nameImage: fields[5] as String,
      completed: fields[3] as bool,
      counter: fields[6] as int,
      percent: fields[7] as double,
      createdAt: fields[4] as DateTime?,
      lastUpdat: fields[8] as DateTime?,
      updatCount: (fields[9] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, HabitModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameHabit)
      ..writeByte(2)
      ..write(obj.goalHabitBerDay)
      ..writeByte(3)
      ..write(obj.completed)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.nameImage)
      ..writeByte(6)
      ..write(obj.counter)
      ..writeByte(7)
      ..write(obj.percent)
      ..writeByte(8)
      ..write(obj.lastUpdat)
      ..writeByte(9)
      ..write(obj.updatCount)
      ..writeByte(10)
      ..write(obj.lastResetWeek);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
