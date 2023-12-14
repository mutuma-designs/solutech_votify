import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/position_repository_impl.dart';
import '../repositories/position_repository.dart';

class DeletePositionParams {
  final int positionId;

  const DeletePositionParams({
    required this.positionId,
  });
}

class DeletePosition extends UseCase<void, DeletePositionParams> {
  final PositionRepository repository;

  DeletePosition(this.repository);

  @override
  Future<Either<Failure, void>> call(DeletePositionParams params) async {
    return await repository.deletePosition(
      id: params.positionId,
    );
  }
}

final deletePositionUseCaseProvider = Provider<DeletePosition>((ref) {
  return DeletePosition(
    ref.watch(positionRepositoryProvider),
  );
});
