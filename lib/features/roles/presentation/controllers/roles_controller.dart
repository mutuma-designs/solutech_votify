import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_roles.dart';
import '../states/roles_state.dart';

class RolesController extends StateNotifier<RolesState> {
  GetRoles getRolesUseCase;
  RolesController({
    required this.getRolesUseCase,
  }) : super(RolesInitial()) {
    getRoles();
  }

  void getRoles() async {
    state = RolesLoading(
      state.roles,
    );
    var response = await getRolesUseCase();
    await response.fold((failure) {
      state = LoadingRolesFailed(failure);
    }, (roles) async {
      if (roles.isEmpty) {
        state = RolesEmpty();
        return;
      }
      state = RolesLoaded(roles);
    });
  }
}

final rolesStateProvider =
    StateNotifierProvider.autoDispose<RolesController, RolesState>((ref) {
  GetRoles getRolesUseCase = ref.watch(getRolesUseCaseProvider);

  return RolesController(
    getRolesUseCase: getRolesUseCase,
  );
});
