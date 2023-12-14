import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../users/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> getUser();

  Future<Either<Failure, User>> login(
    String email,
    String password,
  );

  Future<Either<Failure, void>> setupAccount({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<Either<Failure, void>> logout();
}
