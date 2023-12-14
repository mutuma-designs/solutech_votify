import 'package:core/core.dart';

abstract class CandidateState {
  const CandidateState();
}

class CandidateInitial extends CandidateState {}

class AddingCandidate extends CandidateState {}

class CandidateDeleting extends CandidateState {}

class CandidateAdded extends CandidateState {}

class CandidateUpdated extends CandidateState {}

class CandidateDeleted extends CandidateState {}

class CandidateStarted extends CandidateState {}

class CandidateEnded extends CandidateState {}

class AddingCandidateFailed extends CandidateState {
  final Failure failure;
  AddingCandidateFailed(this.failure);
}

class UpdatingCandidateFailed extends CandidateState {
  final Failure failure;
  UpdatingCandidateFailed(this.failure);
}

class DeletingCandidateFailed extends CandidateState {
  final Failure failure;
  DeletingCandidateFailed(this.failure);
}
