import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/users_repository_impl.dart';
import '../repositories/users_repository.dart';

class UpdateUserParams {
  int userId;
  String fullName;
  String email;
  DateTime dateOfBirth;
  String? phoneNumber;
  String status;
  String gender;
  File? photo;
  int? roleId;

  UpdateUserParams({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.status,
    required this.gender,
    required this.photo,
    this.roleId,
  });
}

class UpdateUser extends UseCase<void, UpdateUserParams> {
  UsersRepository repository;

  UpdateUser({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(UpdateUserParams params) async {
    return repository.updateUser(
      id: params.userId,
      fullName: params.fullName,
      email: params.email,
      dateOfBirth: params.dateOfBirth,
      phoneNumber: params.phoneNumber,
      status: params.status,
      gender: params.gender,
      photo: params.photo,
      roleId: params.roleId,
    );
  }
}

final updateUserUseCaseProvider = Provider<UpdateUser>((ref) {
  final repository = ref.read(usersRepositoryProvider);
  return UpdateUser(
    repository: repository,
  );
});
