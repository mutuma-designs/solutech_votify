import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/add_candidate.dart';
import '../../domain/usecases/delete_candidate.dart';
import '../states/candidate_state.dart';

class CandidateController extends StateNotifier<CandidateState> {
  AddCandidate addCandidateUseCase;
  DeleteCandidate deleteCandidateUseCase;
  CandidateController({
    required this.addCandidateUseCase,
    required this.deleteCandidateUseCase,
  }) : super(CandidateInitial());

  void saveCandidate({
    required int userId,
    required int positionId,
  }) async {
    state = AddingCandidate();
    var response = await addCandidateUseCase(AddCandidateParams(
      userId: userId,
      positionId: positionId,
    ));

    await response.fold((failure) {
      state = AddingCandidateFailed(failure);
    }, (success) async {
      state = CandidateAdded();
    });
  }

  void deleteCandidate(int candidateId) async {
    state = CandidateDeleting();

    var response = await deleteCandidateUseCase(DeleteCandidateParams(
      candidateId: candidateId,
    ));

    await response.fold((failure) {
      state = DeletingCandidateFailed(failure);
    }, (success) async {
      state = CandidateDeleted();
    });
  }
}

final candidateStateProvider =
    StateNotifierProvider.autoDispose<CandidateController, CandidateState>(
  (ref) {
    AddCandidate addCandidate = ref.watch(addCandidateUseCaseProvider);
    DeleteCandidate deleteCandidate = ref.watch(deleteCandidateUseCaseProvider);
    return CandidateController(
      addCandidateUseCase: addCandidate,
      deleteCandidateUseCase: deleteCandidate,
    );
  },
);
