import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:solutech_votify/features/auth/data/data.dart';
import 'package:solutech_votify/features/users/data/mappers/user.dart';

import '../../../users/data/models/user_model.dart';
import '../../../users/domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthLocalDataSource localDataSource;
  AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, User>> login(
    String phoneNumber,
    String password,
  ) async {
    return handleExceptions(() async {
      var userModel = await remoteDataSource.loginWithPhoneNumber(
        phoneNumber,
        password,
      );

      await localDataSource.save(userModel);

      UserModel model = await localDataSource.getUser();
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> setupAccount({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return handleExceptions(() async {
      await remoteDataSource.setUpAccount(
        fullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
    });
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    return handleExceptions(() async {
      UserModel model = await localDataSource.getUser();
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return handleExceptions(() async {
      await localDataSource.clear();
    });
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    localDataSource: ref.watch(authLocalDataSourceProvider),
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
  );
});
