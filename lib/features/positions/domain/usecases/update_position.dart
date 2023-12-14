import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/position_repository_impl.dart';
import '../repositories/position_repository.dart';

class UpdatePositionParams {
  final int positionId;
  final String name;
  final String description;
  final int maxSelections;

  const UpdatePositionParams({
    required this.positionId,
    required this.name,
    required this.description,
    required this.maxSelections,
  });
}

class UpdatePosition extends UseCase<void, UpdatePositionParams> {
  final PositionRepository repository;

  UpdatePosition(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdatePositionParams params) async {
    return await repository.updatePosition(
      id: params.positionId,
      name: params.name,
      description: params.description,
      maxSelections: params.maxSelections,
    );
  }
}

final updatePositionUseCaseProvider = Provider<UpdatePosition>((ref) {
  return UpdatePosition(
    ref.watch(positionRepositoryProvider),
  );
});
