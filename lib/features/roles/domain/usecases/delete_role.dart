import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/roles_repository_impl.dart';
import '../repositories/roles_repository.dart';

class DeleteRoleParams {
  int id;

  DeleteRoleParams({
    required this.id,
  });
}

class DeleteRole extends UseCase<void, DeleteRoleParams> {
  RolesRepository repository;

  DeleteRole({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(DeleteRoleParams params) async {
    return repository.deleteRole(
      params.id,
    );
  }
}

final deleteRoleUseCaseProvider = Provider<DeleteRole>((ref) {
  final repository = ref.read(rolesRepositoryProvider);
  return DeleteRole(
    repository: repository,
  );
});
