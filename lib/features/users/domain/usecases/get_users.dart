import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/users_repository_impl.dart';
import '../entities/user.dart';
import '../repositories/users_repository.dart';

class GetUsers extends NoParamsUseCase<List<User>> {
  UsersRepository repository;

  GetUsers({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<User>>> call() async {
    return repository.getUsers();
  }
}

final getUsersUseCaseProvider = Provider<GetUsers>((ref) {
  final repository = ref.read(usersRepositoryProvider);
  return GetUsers(
    repository: repository,
  );
});
