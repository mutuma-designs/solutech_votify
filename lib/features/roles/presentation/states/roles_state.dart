import 'package:core/core.dart';

import '../../domain/entities/role.dart';

sealed class RolesState {
  final List<Role> roles;
  const RolesState(this.roles);
}

class RolesInitial extends RolesState {
  RolesInitial() : super([]);
}

class RolesLoading extends RolesState {
  RolesLoading(super.roles);
}

class RolesLoaded extends RolesState {
  RolesLoaded(super.roles);
}

class RolesEmpty extends RolesState {
  RolesEmpty() : super([]);
}

class LoadingRolesFailed extends RolesState {
  final Failure failure;
  LoadingRolesFailed(this.failure) : super([]);
}
