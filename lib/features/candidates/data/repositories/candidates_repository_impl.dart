import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/candidates/data/datasources/candidates_remote_datasource.dart';

import '../../domain/repository/candidate_repository.dart';

class CandidatesRepositoryImpl extends CandidateRepository {
  CandidatesRemoteDataSource remoteDataSource;
  CandidatesRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<Failure, void>> addCandidate(int userId, int positionId) {
    return handleExceptions(() {
      return remoteDataSource.addCandidate(userId, positionId);
    });
  }

  @override
  Future<Either<Failure, void>> deleteCandidate(int candidateId) {
    return handleExceptions(() {
      return remoteDataSource.deleteCandidate(candidateId);
    });
  }
}

final candidatesRepositoryProvider =
    Provider.autoDispose<CandidatesRepositoryImpl>(
  (ref) => CandidatesRepositoryImpl(
    ref.watch(candidatesRemoteDataSourceProvider),
  ),
);
