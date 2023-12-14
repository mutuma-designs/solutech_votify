import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/cast_votes.dart';
import '../../domain/usecases/start_voting.dart';
import '../states/voting_state.dart';

class VotingController extends StateNotifier<VotingState> {
  StartVoting startVotingUseCase;
  CastVotes castVotesUseCase;
  VotingController({
    required this.startVotingUseCase,
    required this.castVotesUseCase,
  }) : super(VotingInitial());

  void startVoting(String token) async {
    state = StartingVoting();
    var response = await startVotingUseCase(StartVotingParams(token: token));
    response.fold(
      (failure) => state = VotingStartFailed(failure: failure),
      (token) => state = VotingStarted(token: token),
    );
  }

  void castVotes(int tokenId, List<int> selectedCaandidates) async {
    state = CastingVotes();
    var response = await castVotesUseCase(CastVotesParams(
      tokenId: tokenId,
      selectedCandidates: selectedCaandidates,
    ));
    response.fold(
      (failure) => state = VotesCastFailed(failure: failure),
      (token) => state = VotesCasted(),
    );
  }
}

final votingStateProvider =
    StateNotifierProvider.autoDispose<VotingController, VotingState>((ref) {
  final startVotingUseCase = ref.read(startVotingUseCaseProvider);
  final castVotesUseCase = ref.read(castVotesUseCaseProvider);

  return VotingController(
    startVotingUseCase: startVotingUseCase,
    castVotesUseCase: castVotesUseCase,
  );
});
