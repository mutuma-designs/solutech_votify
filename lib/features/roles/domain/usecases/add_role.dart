import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/roles_repository_impl.dart';
import '../repositories/roles_repository.dart';

class AddRoleParams {
  String name;
  List<String> permissions;

  AddRoleParams({
    required this.name,
    required this.permissions,
  });
}

class AddRole extends UseCase<void, AddRoleParams> {
  RolesRepository repository;

  AddRole({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(AddRoleParams params) async {
    return repository.addRole(
      name: params.name,
      permissions: params.permissions,
    );
  }
}

final addRoleUseCaseProvider = Provider<AddRole>((ref) {
  final repository = ref.read(rolesRepositoryProvider);
  return AddRole(
    repository: repository,
  );
});
