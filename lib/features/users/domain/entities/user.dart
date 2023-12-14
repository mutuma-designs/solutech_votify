import 'package:equatable/equatable.dart';

import '../../../roles/domain/entities/role.dart';

class User extends Equatable {
  final int id;
  final String? uniqueId;
  final String fullName;
  final String? photo;
  final String? gender;
  final String status;
  final DateTime? dateOfBirth;
  final String? phone;
  final String email;
  int? get age => dateOfBirth != null
      ? DateTime.now().difference(dateOfBirth!).inDays ~/ 365
      : null;

  final Role? role;

  const User({
    required this.id,
    required this.uniqueId,
    required this.fullName,
    this.photo,
    this.gender,
    required this.status,
    this.dateOfBirth,
    this.phone,
    required this.email,
    this.role,
  });

  @override
  List<Object> get props => [id];

  bool hasPremission(String roleName) {
    var currentRole = role;
    if (currentRole == null) return false;
    return currentRole.permissions.contains(roleName);
  }
}
