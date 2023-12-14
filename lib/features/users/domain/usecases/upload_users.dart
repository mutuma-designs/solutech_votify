import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/users_repository_impl.dart';
import '../repositories/users_repository.dart';

class UploadUsersParams {
  File users;

  UploadUsersParams({
    required this.users,
  });
}

class UploadUsers extends UseCase<void, UploadUsersParams> {
  UsersRepository repository;

  UploadUsers({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(UploadUsersParams params) async {
    return repository.uploadUsers(
      usersFile: params.users,
    );
  }
}

final uploadUsersUseCaseProvider = Provider<UploadUsers>((ref) {
  final repository = ref.read(usersRepositoryProvider);
  return UploadUsers(
    repository: repository,
  );
});
