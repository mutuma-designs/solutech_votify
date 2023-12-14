import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/dio.dart';
import '../models/role_model.dart';

abstract class RolesRemoteDataSource {
  Future<List<RoleModel>> getRoles();

  Future<void> addRole({
    required String name,
    required List<String> permissions,
  });

  Future<void> updateRole({
    required int id,
    required String name,
    required List<String> permissions,
  });
  Future<void> deleteRole(int id);
}

class RolesRemoteDataSourceImpl extends RolesRemoteDataSource {
  Dio dio;

  RolesRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<void> addRole({
    required String name,
    required List<String> permissions,
  }) {
    return handleErrors(() async {
      await dio.post(
        "/roles",
        data: {
          "name": name,
          "permissions": permissions,
        },
      );
    });
  }

  @override
  Future<void> deleteRole(int id) {
    return handleErrors(() async {
      await dio.delete(
        "/roles/$id",
      );
    });
  }

  @override
  Future<List<RoleModel>> getRoles() {
    return handleErrors(() async {
      var response = await dio.get(
        "/roles",
      );
      return response.data.map<RoleModel>((e) => RoleModel.fromMap(e)).toList();
    });
  }

  @override
  Future<void> updateRole({
    required int id,
    required String name,
    required List<String> permissions,
  }) {
    return handleErrors(() async {
      await dio.put(
        "/roles/$id",
        data: {
          "name": name,
          "permissions": permissions,
        },
      );
    });
  }
}

final rolesRemoteDataSourceProvider = Provider<RolesRemoteDataSource>(
  (ref) => RolesRemoteDataSourceImpl(dio: ref.read(dioProvider)),
);
