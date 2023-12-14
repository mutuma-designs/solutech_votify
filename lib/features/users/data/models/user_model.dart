import 'package:hive/hive.dart';

import '../../../roles/data/models/role_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String? uniqueId;
  @HiveField(3)
  final String fullName;
  @HiveField(4)
  final String? photo;
  @HiveField(5)
  final String status;
  @HiveField(6)
  final DateTime? dateOfBirth;
  @HiveField(7)
  final String? phone;
  @HiveField(8)
  final String email;
  @HiveField(9)
  final RoleModel? role;
  @HiveField(10)
  final String? gender;

  UserModel({
    required this.id,
    required this.uniqueId,
    required this.fullName,
    required this.photo,
    required this.status,
    required this.dateOfBirth,
    required this.phone,
    required this.email,
    required this.role,
    required this.gender,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        uniqueId: json["uniqueId"],
        fullName: json["fullName"],
        photo: json["photo"],
        status: json["status"],
        dateOfBirth: json["dateOfBirth"] != null
            ? DateTime.parse(json["dateOfBirth"])
            : null,
        phone: json["phone"],
        email: json["email"],
        role: json["role"] != null ? RoleModel.fromMap(json["role"]) : null,
        gender: json["gender"],
      );
}
