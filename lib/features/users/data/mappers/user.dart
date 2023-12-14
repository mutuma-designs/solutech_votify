import 'package:solutech_votify/features/roles/data/mappers/role.dart';

import '../../../users/domain/entities/user.dart';
import '../models/user_model.dart';

extension UserModelX on UserModel {
  User toEntity() {
    return User(
      id: id,
      uniqueId: uniqueId,
      fullName: fullName,
      photo: photo,
      status: status,
      dateOfBirth: dateOfBirth,
      phone: phone,
      email: email,
      role: role?.toEntity(),
      gender: gender,
    );
  }
}

extension UserX on User {
  UserModel toModel() {
    return UserModel(
        id: id,
        uniqueId: uniqueId,
        fullName: fullName,
        photo: photo,
        status: status,
        dateOfBirth: dateOfBirth,
        phone: phone,
        email: email,
        role: role?.toModel(),
        gender: gender);
  }
}
