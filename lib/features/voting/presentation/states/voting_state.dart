import 'package:core/core.dart';

import '../../domain/entities/token.dart';

abstract class VotingState {}

class VotingInitial extends VotingState {}

class StartingVoting extends VotingState {}

class VotingStarted extends VotingState {
  final Token token;

  VotingStarted({
    required this.token,
  });
}

class VotingStartFailed extends VotingState {
  final Failure failure;

  VotingStartFailed({
    required this.failure,
  });
}

class CastingVotes extends VotingState {}

class VotesCasted extends VotingState {}

class VotesCastFailed extends VotingState {
  final Failure failure;

  VotesCastFailed({
    required this.failure,
  });
}
