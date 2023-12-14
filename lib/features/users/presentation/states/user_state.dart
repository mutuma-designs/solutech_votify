import 'package:core/core.dart';

abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {}

class UserSaving extends UserState {}

class UserDeleting extends UserState {}

class UserAdded extends UserState {}

class UploadingUsers extends UserState {}

class UsersUploaded extends UserState {}

class UserUpdated extends UserState {}

class UserDeleted extends UserState {}

class UserStarted extends UserState {}

class UserEnded extends UserState {}

class AddingUserFailed extends UserState {
  final Failure failure;
  AddingUserFailed(this.failure);
}

class UpdatingUserFailed extends UserState {
  final Failure failure;
  UpdatingUserFailed(this.failure);
}

class UploadingUsersFailed extends UserState {
  final Failure failure;
  UploadingUsersFailed(this.failure);
}

class DeletingUserFailed extends UserState {
  final Failure failure;
  DeletingUserFailed(this.failure);
}
