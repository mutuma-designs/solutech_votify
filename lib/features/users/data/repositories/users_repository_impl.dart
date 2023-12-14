import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/users/data/mappers/user.dart';
import 'package:solutech_votify/features/users/domain/entities/user.dart';
import 'package:solutech_votify/features/users/domain/repositories/users_repository.dart';

import '../datasources/users_remote_datasource.dart';

class UsersRepositoryImpl extends UsersRepository {
  UsersRemoteDataSource remoteDataSource;
  UsersRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> deleteUser(
    int id,
  ) async {
    return handleExceptions(() async {
      await remoteDataSource.deleteUser(id);
    });
  }

  @override
  Future<Either<Failure, List<User>>> getUsers() {
    return handleExceptions(() async {
      var users = await remoteDataSource.getUsers();
      return users.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, void>> createUser({
    required String fullName,
    required String email,
    String? uniqueId,
    required DateTime dateOfBirth,
    String? phoneNumber,
    required String status,
    required String gender,
    File? photo,
    int? roleId,
  }) {
    return handleExceptions(() async {
      await remoteDataSource.createUser(
        fullName: fullName,
        email: email,
        uniqueId: uniqueId,
        dateOfBirth: dateOfBirth,
        phoneNumber: phoneNumber,
        gender: gender,
        status: status,
        photo: photo,
        roleId: roleId,
      );
    });
  }

  @override
  Future<Either<Failure, void>> updateUser({
    required int id,
    required String fullName,
    required String email,
    required DateTime dateOfBirth,
    String? phoneNumber,
    required String status,
    required String gender,
    File? photo,
    int? roleId,
  }) {
    return handleExceptions(() async {
      await remoteDataSource.updateUser(
        id: id,
        fullName: fullName,
        email: email,
        dateOfBirth: dateOfBirth,
        phoneNumber: phoneNumber,
        status: status,
        photo: photo,
        gender: gender,
        roleId: roleId,
      );
    });
  }

  @override
  Future<Either<Failure, void>> uploadUsers({required File usersFile}) {
    return handleExceptions(() async {
      await remoteDataSource.uploadUsers(usersFile);
    });
  }
}

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  return UsersRepositoryImpl(
    ref.watch(usersRemoteDataSourceProvider),
  );
});
