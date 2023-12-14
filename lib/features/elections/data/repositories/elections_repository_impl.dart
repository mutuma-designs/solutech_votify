import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/elections/data/datasources/elections_remote_datasource.dart';
import 'package:solutech_votify/features/elections/data/mappers/election.dart';
import 'package:solutech_votify/features/elections/domain/entities/election.dart';
import 'package:solutech_votify/features/elections/domain/repositories/elections_repository.dart';

class ElectionsRepositoryImpl extends ElectionsRepository {
  ElectionsRemoteDataSource remoteDataSource;
  ElectionsRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, Unit>> createElection({
    required String name,
    required String description,
    required DateTime date,
    required int minimumAge,
    required int votingTimeInMinutes,
  }) {
    return handleExceptions(() async {
      await remoteDataSource.createElection(
        name: name,
        description: description,
        date: date,
        minimumAge: minimumAge,
        votingTimeInMinutes: votingTimeInMinutes,
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, void>> deleteElection(
    int id,
  ) async {
    return handleExceptions(() async {
      await remoteDataSource.deleteElection(id);
    });
  }

  @override
  Future<Either<Failure, void>> startElection(
    int id,
  ) async {
    return handleExceptions(() async {
      await remoteDataSource.startElection(id);
    });
  }

  @override
  Future<Either<Failure, List<Election>>> getElections() {
    return handleExceptions(() async {
      var elections = await remoteDataSource.getElections();
      return elections.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> updateElection({
    required int id,
    required String name,
    required String description,
    required DateTime date,
    required int minimumAge,
    required int votingTimeInMinutes,
  }) {
    return handleExceptions(() async {
      await remoteDataSource.updateElection(
        id: id,
        name: name,
        description: description,
        date: date,
        minimumAge: minimumAge,
        votingTimeInMinutes: votingTimeInMinutes,
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, void>> endElection(int electionId) {
    return handleExceptions(() async {
      await remoteDataSource.endElection(electionId);
    });
  }
}

final electionsRepositoryProvider = Provider<ElectionsRepository>((ref) {
  return ElectionsRepositoryImpl(
    ref.watch(electionsRemoteDataSourceProvider),
  );
});
