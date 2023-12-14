import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class PositionRepository {
  Future<Either<Failure, void>> addPosition({
    required int electionId,
    required String name,
    required String description,
    required int maxSelections,
  });

  Future<Either<Failure, void>> updatePosition({
    required int id,
    required String name,
    required String description,
    required int maxSelections,
  });

  Future<Either<Failure, void>> deletePosition({
    required int id,
  });
}
