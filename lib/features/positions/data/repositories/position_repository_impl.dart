import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/positions/data/datasources/positions_remote_datasource.dart';

import '../../domain/repositories/position_repository.dart';

class PositionRepositoryImpl implements PositionRepository {
  PositionsRemoteDataSource remoteDataSource;
  PositionRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, void>> addPosition({
    required int electionId,
    required String name,
    required int maxSelections,
    required String description,
  }) {
    return handleExceptions(() async {
      await remoteDataSource.createPosition(
        electionId: electionId,
        name: name,
        maxSelections: maxSelections,
        description: description,
      );
    });
  }

  @override
  Future<Either<Failure, void>> deletePosition({required int id}) {
    return handleExceptions(() async {
      await remoteDataSource.deletePosition(
        id,
      );
    });
  }

  @override
  Future<Either<Failure, void>> updatePosition(
      {required int id,
      required String name,
      required String description,
      required int maxSelections}) {
    return handleExceptions(() async {
      await remoteDataSource.updatePosition(
        id: id,
        name: name,
        maxSelections: maxSelections,
        description: description,
      );
    });
  }
}

final positionRepositoryProvider = Provider<PositionRepository>((ref) {
  return PositionRepositoryImpl(
    ref.watch(positionsRemoteDataSourceProvider),
  );
});
