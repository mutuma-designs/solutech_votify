import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/roles/data/mappers/role.dart';
import 'package:solutech_votify/features/roles/domain/entities/role.dart';
import 'package:solutech_votify/features/roles/domain/repositories/roles_repository.dart';

import '../datasources/roles_remote_datasource.dart';

class RolesRepositoryImpl extends RolesRepository {
  RolesRemoteDataSource remoteDataSource;
  RolesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> addRole(
      {required String name, required List<String> permissions}) async {
    return handleExceptions(() async {
      await remoteDataSource.addRole(
        name: name,
        permissions: permissions,
      );
    });
  }

  @override
  Future<Either<Failure, void>> deleteRole(int id) {
    return handleExceptions(() async {
      await remoteDataSource.deleteRole(id);
    });
  }

  @override
  Future<Either<Failure, List<Role>>> getRoles() {
    return handleExceptions(() async {
      var roles = await remoteDataSource.getRoles();
      return roles.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, void>> updateRole({
    required int id,
    required String name,
    required List<String> permissions,
  }) {
    return handleExceptions(() async {
      await remoteDataSource.updateRole(
        id: id,
        name: name,
        permissions: permissions,
      );
    });
  }
}

final rolesRepositoryProvider = Provider<RolesRepository>((ref) {
  return RolesRepositoryImpl(
    ref.read(rolesRemoteDataSourceProvider),
  );
});
