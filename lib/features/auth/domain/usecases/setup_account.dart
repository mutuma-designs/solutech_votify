import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../repositories/auth_repository.dart';

class SetupAccount extends UseCase<void, SetupAccountParams> {
  AuthRepository repository;
  SetupAccount({
    required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(SetupAccountParams params) {
    return repository.setupAccount(
      fullName: params.fullName,
      email: params.email,
      password: params.password,
      confirmPassword: params.confirmPassword,
    );
  }
}

class SetupAccountParams {
  String fullName;
  String email;
  String password;
  String confirmPassword;

  SetupAccountParams({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

final registerUseCaseProvider = Provider<SetupAccount>(
  (ref) => SetupAccount(
    repository: ref.watch(authRepositoryProvider),
  ),
);
