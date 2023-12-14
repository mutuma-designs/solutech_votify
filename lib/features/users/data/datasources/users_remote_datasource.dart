import 'dart:io';

import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/config/dio.dart';

import '../models/user_model.dart';

abstract class UsersRemoteDataSource {
  Future<void> createUser({
    required String fullName,
    required String email,
    String? uniqueId,
    required DateTime dateOfBirth,
    String? phoneNumber,
    required String gender,
    required String status,
    File? photo,
    int? roleId,
  });

  Future<List<UserModel>> getUsers();
  Future<void> updateUser({
    required int id,
    required String fullName,
    required String email,
    required DateTime dateOfBirth,
    String? phoneNumber,
    required String status,
    required String gender,
    File? photo,
    int? roleId,
  });
  Future<void> deleteUser(int id);

  Future<void> uploadUsers(File usersFile);
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  Dio dio;
  UsersRemoteDataSourceImpl(this.dio);
  @override
  Future<void> createUser({
    required String fullName,
    required String email,
    String? uniqueId,
    required DateTime dateOfBirth,
    required String gender,
    String? phoneNumber,
    required String status,
    File? photo,
    int? roleId,
  }) async {
    return await handleErrors(() async {
      await dio.post(
        "/users",
        data: FormData.fromMap({
          "fullName": fullName,
          "uniqueId": uniqueId,
          "email": email,
          "dateOfBirth": dateOfBirth.toIso8601String(),
          "gender": gender,
          "phoneNumber": phoneNumber,
          "status": status,
          "photo":
              photo != null ? await MultipartFile.fromFile(photo.path) : null,
          "roleId": roleId,
        }),
      );
    });
  }

  @override
  Future<List<UserModel>> getUsers() {
    return handleErrors(() async {
      var response = await dio.get("/users");
      return response.data
          .map<UserModel>((user) => UserModel.fromMap(user))
          .toList();
    });
  }

  @override
  Future<void> deleteUser(int id) {
    return handleErrors(() async {
      await dio.delete("/users/$id");
    });
  }

  @override
  Future<void> updateUser({
    required int id,
    required String fullName,
    required String email,
    required DateTime dateOfBirth,
    String? phoneNumber,
    required String status,
    required String gender,
    File? photo,
    int? roleId,
  }) async {
    await handleErrors(() {
      return dio.put(
        "/users/$id",
        data: {
          "fullName": fullName,
          "uniqueId": "uniqueId",
          "email": email,
          "phoneNumber": phoneNumber,
          "dateOfBirth": dateOfBirth.toIso8601String(),
          "status": status,
          "gender": gender,
          "photo": photo,
          "roleId": roleId,
        },
      );
    });
  }

  @override
  Future<void> uploadUsers(File usersFile) {
    return handleErrors(() async {
      await dio.post(
        "/users/upload",
        data: FormData.fromMap({
          "file": await MultipartFile.fromFile(usersFile.path),
        }),
      );
    });
  }
}

final usersRemoteDataSourceProvider = Provider<UsersRemoteDataSource>((ref) {
  return UsersRemoteDataSourceImpl(
    ref.watch(dioProvider),
  );
});
