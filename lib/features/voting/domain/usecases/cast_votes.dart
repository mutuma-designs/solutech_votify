import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/voting_repository_impl.dart';
import '../repositories/voting_repository.dart';

class CastVotesParams {
  int tokenId;
  List<int> selectedCandidates;
  CastVotesParams({
    required this.tokenId,
    required this.selectedCandidates,
  });
}

class CastVotes extends UseCase<void, CastVotesParams> {
  VotingRepository repository;

  CastVotes({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(CastVotesParams params) async {
    return repository.castVotes(
      params.tokenId,
      params.selectedCandidates,
    );
  }
}

final castVotesUseCaseProvider = Provider<CastVotes>((ref) {
  final repository = ref.read(votingRepositoryProvider);
  return CastVotes(
    repository: repository,
  );
});
