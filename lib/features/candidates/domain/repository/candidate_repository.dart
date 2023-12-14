import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class CandidateRepository {
  Future<Either<Failure, void>> addCandidate(int userId, int positionId);
  Future<Either<Failure, void>> deleteCandidate(int candidateId);
}
