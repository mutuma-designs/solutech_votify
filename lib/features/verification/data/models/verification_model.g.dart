// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VerificationModelAdapter extends TypeAdapter<VerificationModel> {
  @override
  final int typeId = 6;

  @override
  VerificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VerificationModel(
      user: fields[1] as UserModel,
      verificationResult: fields[2] as VerificationResultModel,
    );
  }

  @override
  void write(BinaryWriter writer, VerificationModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.verificationResult);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VerificationResultModelAdapter
    extends TypeAdapter<VerificationResultModel> {
  @override
  final int typeId = 7;

  @override
  VerificationResultModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VerificationResultModel(
      canVote: fields[1] as bool,
      reason: fields[2] as String,
      token: fields[3] as String?,
      expiration: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, VerificationResultModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.canVote)
      ..writeByte(2)
      ..write(obj.reason)
      ..writeByte(3)
      ..write(obj.token)
      ..writeByte(4)
      ..write(obj.expiration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerificationResultModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
