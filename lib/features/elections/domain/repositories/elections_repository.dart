import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/election.dart';

abstract class ElectionsRepository {
  Future<Either<Failure, List<Election>>> getElections();
  Future<Either<Failure, Unit>> createElection({
    required String name,
    required String description,
    required DateTime date,
    required int minimumAge,
    required int votingTimeInMinutes,
  });

  Future<Either<Failure, Unit>> updateElection({
    required int id,
    required String name,
    required String description,
    required DateTime date,
    required int minimumAge,
    required int votingTimeInMinutes,
  });

  Future<Either<Failure, void>> deleteElection(
    int id,
  );

  Future<Either<Failure, void>> startElection(
    int id,
  );

  Future<Either<Failure, void>> endElection(int electionId);
}
