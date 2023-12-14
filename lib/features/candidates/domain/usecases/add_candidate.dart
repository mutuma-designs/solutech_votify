import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/candidates_repository_impl.dart';
import '../repository/candidate_repository.dart';

class AddCandidateParams {
  final int userId;
  final int positionId;
  const AddCandidateParams({
    required this.userId,
    required this.positionId,
  });
}

class AddCandidate extends UseCase<void, AddCandidateParams> {
  final CandidateRepository repository;

  AddCandidate(this.repository);

  @override
  Future<Either<Failure, void>> call(AddCandidateParams params) async {
    return await repository.addCandidate(
      params.userId,
      params.positionId,
    );
  }
}

final addCandidateUseCaseProvider = Provider.autoDispose<AddCandidate>(
  (ref) => AddCandidate(
    ref.watch(candidatesRepositoryProvider),
  ),
);
