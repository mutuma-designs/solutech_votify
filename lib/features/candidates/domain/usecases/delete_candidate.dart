import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/candidates_repository_impl.dart';
import '../repository/candidate_repository.dart';

class DeleteCandidateParams {
  final int candidateId;
  const DeleteCandidateParams({
    required this.candidateId,
  });
}

class DeleteCandidate extends UseCase<void, DeleteCandidateParams> {
  final CandidateRepository repository;

  DeleteCandidate(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteCandidateParams params) async {
    return await repository.deleteCandidate(
      params.candidateId,
    );
  }
}

final deleteCandidateUseCaseProvider = Provider.autoDispose<DeleteCandidate>(
  (ref) => DeleteCandidate(
    ref.watch(candidatesRepositoryProvider),
  ),
);
