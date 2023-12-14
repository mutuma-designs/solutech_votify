import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/role.dart';

abstract class RolesRepository {
  Future<Either<Failure, List<Role>>> getRoles();

  Future<Either<Failure, void>> addRole({
    required String name,
    required List<String> permissions,
  });

  Future<Either<Failure, void>> updateRole({
    required int id,
    required String name,
    required List<String> permissions,
  });
  Future<Either<Failure, void>> deleteRole(int id);
}
