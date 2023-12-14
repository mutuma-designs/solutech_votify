import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/roles_repository_impl.dart';
import '../repositories/roles_repository.dart';

class UpdateRoleParams {
  int id;
  String name;
  List<String> permissions;

  UpdateRoleParams({
    required this.id,
    required this.name,
    required this.permissions,
  });
}

class UpdateRole extends UseCase<void, UpdateRoleParams> {
  RolesRepository repository;

  UpdateRole({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(UpdateRoleParams params) async {
    return repository.updateRole(
      id: params.id,
      name: params.name,
      permissions: params.permissions,
    );
  }
}

final updateRoleUseCaseProvider = Provider<UpdateRole>((ref) {
  final repository = ref.read(rolesRepositoryProvider);
  return UpdateRole(
    repository: repository,
  );
});
