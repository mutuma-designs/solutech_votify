// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthDataModelAdapter extends TypeAdapter<AuthDataModel> {
  @override
  final int typeId = 1;

  @override
  AuthDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthDataModel(
      user: fields[1] as UserModel,
      token: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthDataModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
