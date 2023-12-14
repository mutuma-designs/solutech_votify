import 'package:core/core.dart';

abstract class RoleState {
  const RoleState();
}

class RoleInitial extends RoleState {}

class RoleSaving extends RoleState {}

class RoleDeleting extends RoleState {}

class StartingRole extends RoleState {}

class EndingRole extends RoleState {}

class RoleAdded extends RoleState {}

class RoleUpdated extends RoleState {}

class RoleDeleted extends RoleState {}

class RoleStarted extends RoleState {}

class RoleEnded extends RoleState {}

class AddingRoleFailed extends RoleState {
  final Failure failure;
  AddingRoleFailed(this.failure);
}

class UpdatingRoleFailed extends RoleState {
  final Failure failure;
  UpdatingRoleFailed(this.failure);
}

class DeletingRoleFailed extends RoleState {
  final Failure failure;
  DeletingRoleFailed(this.failure);
}
