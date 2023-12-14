import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/user.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, void>> createUser({
    required String fullName,
    required String email,
    required String? uniqueId,
    required DateTime dateOfBirth,
    required String? phoneNumber,
    required String status,
    required File? photo,
    required String gender,
    int? roleId,
  });

  Future<Either<Failure, void>> updateUser({
    required int id,
    required String fullName,
    required String email,
    required DateTime dateOfBirth,
    required String? phoneNumber,
    required String status,
    required String gender,
    required File? photo,
    int? roleId,
  });

  Future<Either<Failure, void>> deleteUser(
    int id,
  );

  Future<Either<Failure, void>> uploadUsers({required File usersFile});
}
