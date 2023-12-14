// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'election_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ElectionModelAdapter extends TypeAdapter<ElectionModel> {
  @override
  final int typeId = 3;

  @override
  ElectionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ElectionModel(
      id: fields[1] as int,
      name: fields[2] as String,
      description: fields[3] as String,
      date: fields[4] as DateTime,
      status: fields[5] as String,
      startedAt: fields[6] as DateTime?,
      endedAt: fields[7] as DateTime?,
      minimumAge: fields[8] as int,
      votingTimeInMinutes: fields[9] as int,
      createdAt: fields[10] as DateTime,
      updatedAt: fields[11] as DateTime?,
      positions: (fields[12] as List).cast<PositionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ElectionModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.startedAt)
      ..writeByte(7)
      ..write(obj.endedAt)
      ..writeByte(8)
      ..write(obj.minimumAge)
      ..writeByte(9)
      ..write(obj.votingTimeInMinutes)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.positions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ElectionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
