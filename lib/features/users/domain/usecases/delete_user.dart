import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/users_repository_impl.dart';
import '../repositories/users_repository.dart';

class DeleteUserParams {
  int userId;
  DeleteUserParams({
    required this.userId,
  });
}

class DeleteUser extends UseCase<void, DeleteUserParams> {
  UsersRepository repository;

  DeleteUser({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(DeleteUserParams params) async {
    return repository.deleteUser(
      params.userId,
    );
  }
}

final deleteUserUseCaseProvider = Provider<DeleteUser>((ref) {
  final repository = ref.read(usersRepositoryProvider);
  return DeleteUser(
    repository: repository,
  );
});
