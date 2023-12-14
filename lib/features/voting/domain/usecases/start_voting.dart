import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/voting_repository_impl.dart';
import '../entities/token.dart';
import '../repositories/voting_repository.dart';

class StartVotingParams {
  String token;
  StartVotingParams({
    required this.token,
  });
}

class StartVoting extends UseCase<Token, StartVotingParams> {
  VotingRepository repository;

  StartVoting({
    required this.repository,
  });

  @override
  Future<Either<Failure, Token>> call(StartVotingParams params) async {
    return repository.startVoting(
      params.token,
    );
  }
}

final startVotingUseCaseProvider = Provider<StartVoting>((ref) {
  final repository = ref.read(votingRepositoryProvider);
  return StartVoting(
    repository: repository,
  );
});
