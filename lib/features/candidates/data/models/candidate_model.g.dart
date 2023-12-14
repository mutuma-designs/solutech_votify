// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CandidateModelAdapter extends TypeAdapter<CandidateModel> {
  @override
  final int typeId = 5;

  @override
  CandidateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CandidateModel(
      id: fields[1] as int,
      user: fields[2] as UserModel,
    );
  }

  @override
  void write(BinaryWriter writer, CandidateModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CandidateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
