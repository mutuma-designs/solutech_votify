import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/roles_repository_impl.dart';
import '../entities/role.dart';
import '../repositories/roles_repository.dart';

class GetRoles extends NoParamsUseCase<List<Role>> {
  RolesRepository repository;

  GetRoles({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Role>>> call() async {
    return repository.getRoles();
  }
}

final getRolesUseCaseProvider = Provider<GetRoles>((ref) {
  final repository = ref.read(rolesRepositoryProvider);
  return GetRoles(
    repository: repository,
  );
});
