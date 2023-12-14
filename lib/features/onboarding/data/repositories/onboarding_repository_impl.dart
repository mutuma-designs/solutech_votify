import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import '../datasources/onboarding_remote_datasource.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
  OnboardingRemoteDatasource remoteDataSource;
  OnboardingRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> getOnboardingStatus() async {
    return handleExceptions(() async {
      return await remoteDataSource.getOnboardingStatus();
    });
  }
}

final onboardingRepositoryProvider =
    Provider.autoDispose<OnboardingRepository>((ref) {
  final localDataSource = ref.watch(onboardingRemoteDatasourceProvider);
  return OnboardingRepositoryImpl(remoteDataSource: localDataSource);
});
