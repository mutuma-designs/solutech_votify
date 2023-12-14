import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/users_repository_impl.dart';
import '../repositories/users_repository.dart';

class AddUserParams {
  String fullName;
  String email;
  String? uniqueId;
  DateTime dateOfBirth;
  String? phoneNumber;
  String status;
  String gender;
  File? photo;
  int? roleId;

  AddUserParams({
    required this.fullName,
    required this.email,
    this.uniqueId,
    required this.dateOfBirth,
    this.phoneNumber,
    required this.status,
    required this.gender,
    this.photo,
    this.roleId,
  });
}

class AddUser extends UseCase<void, AddUserParams> {
  UsersRepository repository;

  AddUser({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(AddUserParams params) async {
    return repository.createUser(
      fullName: params.fullName,
      email: params.email,
      uniqueId: params.uniqueId,
      dateOfBirth: params.dateOfBirth,
      phoneNumber: params.phoneNumber,
      status: params.status,
      gender: params.gender,
      photo: params.photo,
      roleId: params.roleId,
    );
  }
}

final addUserUseCaseProvider = Provider<AddUser>((ref) {
  final repository = ref.read(usersRepositoryProvider);
  return AddUser(
    repository: repository,
  );
});
