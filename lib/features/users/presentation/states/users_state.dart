import 'package:core/core.dart';

import '../../domain/entities/user.dart';

sealed class UsersState {
  final List<User> users;
  const UsersState(this.users);
}

class UsersInitial extends UsersState {
  UsersInitial() : super([]);
}

class UsersLoading extends UsersState {
  UsersLoading(super.users);
}

class UsersLoaded extends UsersState {
  UsersLoaded(super.users);
}

class UsersEmpty extends UsersState {
  UsersEmpty() : super([]);
}

class LoadingUsersFailed extends UsersState {
  final Failure failure;
  LoadingUsersFailed(this.failure) : super([]);
}
