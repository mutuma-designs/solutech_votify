// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PositionModelAdapter extends TypeAdapter<PositionModel> {
  @override
  final int typeId = 4;

  @override
  PositionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionModel(
      id: fields[1] as int,
      name: fields[2] as String,
      maxSelections: fields[3] as int,
      description: fields[4] as String,
      candidates: (fields[5] as List).cast<CandidateModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PositionModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.maxSelections)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.candidates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
