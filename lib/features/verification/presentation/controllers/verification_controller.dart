import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/verify_user.dart';
import '../states/verification_state.dart';

class VerificationController extends StateNotifier<VerificationState> {
  VerifyVoter verifyVoterUseCase;
  VerificationController({
    required this.verifyVoterUseCase,
  }) : super(VerificationInitial());

  void verifyVoter({
    required String uniqueId,
    required int electionId,
  }) async {
    state = Verifying();
    var response = await verifyVoterUseCase(VerifyVoterParams(
      uniqueId: uniqueId,
      electionId: electionId,
    ));
    await response.fold((failure) {
      state = VerificationFailed(failure);
    }, (success) async {
      state = Verified(success);
    });
  }
}

final verificationStateProvider = StateNotifierProvider.autoDispose<
    VerificationController, VerificationState>((ref) {
  VerifyVoter verifyVoter = ref.watch(verifyVoterUseCaseProvider);
  return VerificationController(
    verifyVoterUseCase: verifyVoter,
  );
});
