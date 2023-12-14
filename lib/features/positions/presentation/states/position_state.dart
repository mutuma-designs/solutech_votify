import 'package:core/core.dart';

abstract class PositionState {
  const PositionState();
}

class PositionInitial extends PositionState {}

class PositionSaving extends PositionState {}

class PositionDeleting extends PositionState {}

class PositionAdded extends PositionState {}

class PositionUpdated extends PositionState {}

class PositionDeleted extends PositionState {}

class AddingPositionFailed extends PositionState {
  final Failure failure;
  AddingPositionFailed(this.failure);
}

class UpdatingPositionFailed extends PositionState {
  final Failure failure;
  UpdatingPositionFailed(this.failure);
}

class DeletingPositionFailed extends PositionState {
  final Failure failure;
  DeletingPositionFailed(this.failure);
}
