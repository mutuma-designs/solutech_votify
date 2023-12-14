import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/position_repository_impl.dart';
import '../repositories/position_repository.dart';

class AddPositionParams {
  final int electionId;
  final String name;
  final String description;
  final int maxSelections;

  const AddPositionParams({
    required this.electionId,
    required this.name,
    required this.description,
    required this.maxSelections,
  });
}

class AddPosition extends UseCase<void, AddPositionParams> {
  final PositionRepository repository;

  AddPosition(this.repository);

  @override
  Future<Either<Failure, void>> call(AddPositionParams params) async {
    return await repository.addPosition(
      electionId: params.electionId,
      name: params.name,
      description: params.description,
      maxSelections: params.maxSelections,
    );
  }
}

final addPositionUseCaseProvider = Provider<AddPosition>((ref) {
  return AddPosition(
    ref.watch(positionRepositoryProvider),
  );
});
