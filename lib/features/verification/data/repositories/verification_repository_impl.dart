import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/verification/data/mappers/verification.dart';

import '../../domain/entities/verification.dart';
import '../../domain/repositories/verification_repository.dart';
import '../datasources/verification_remote_datasource.dart';

class VerificationRepositoryImpl extends VerificationRepository {
  VerificationRemoteDataSource remoteDataSource;
  VerificationRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, Verification>> verifyVoter({
    required int electionId,
    required String uniqueId,
  }) {
    return handleExceptions(() async {
      var verificationModel = await remoteDataSource.verifyVoter(
        electionId: electionId,
        uniqueId: uniqueId,
      );
      return verificationModel.toEntity();
    });
  }
}

final verificationRepositoryProvider = Provider<VerificationRepository>(
  (ref) => VerificationRepositoryImpl(
    ref.watch(verificationRemoteDataSourceProvider),
  ),
);
