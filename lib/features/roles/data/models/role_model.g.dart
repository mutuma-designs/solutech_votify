// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoleModelAdapter extends TypeAdapter<RoleModel> {
  @override
  final int typeId = 2;

  @override
  RoleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoleModel(
      id: fields[1] as int,
      name: fields[2] as String,
      permissions: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RoleModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.permissions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
