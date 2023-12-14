import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/add_role.dart';
import '../../domain/usecases/delete_role.dart';
import '../../domain/usecases/update_role.dart';
import '../states/role_state.dart';

class RoleController extends StateNotifier<RoleState> {
  AddRole addRoleUseCase;
  UpdateRole updateRoleUseCase;
  DeleteRole deleteRoleUseCase;

  RoleController({
    required this.addRoleUseCase,
    required this.updateRoleUseCase,
    required this.deleteRoleUseCase,
  }) : super(RoleInitial());

  void saveRole({
    required String name,
    required List<String> permissions,
  }) async {
    state = RoleSaving();
    var response = await addRoleUseCase(AddRoleParams(
      name: name,
      permissions: permissions,
    ));
    await response.fold((failure) {
      state = AddingRoleFailed(failure);
    }, (success) async {
      state = RoleAdded();
    });
  }

  void updateRole({
    required int roleId,
    required String name,
    required List<String> permissions,
  }) async {
    state = RoleSaving();
    var response = await updateRoleUseCase(UpdateRoleParams(
      id: roleId,
      name: name,
      permissions: permissions,
    ));
    await response.fold((failure) {
      state = UpdatingRoleFailed(failure);
    }, (success) async {
      state = RoleUpdated();
    });
  }

  void deleteRole(int id) async {
    state = RoleDeleting();

    var response = await deleteRoleUseCase(DeleteRoleParams(
      id: id,
    ));

    await response.fold((failure) {
      state = DeletingRoleFailed(failure);
    }, (success) async {
      state = RoleDeleted();
    });
  }
}

final roleStateProvider =
    StateNotifierProvider.autoDispose<RoleController, RoleState>((ref) {
  AddRole addRole = ref.watch(addRoleUseCaseProvider);
  UpdateRole updateRole = ref.watch(updateRoleUseCaseProvider);
  DeleteRole deleteRole = ref.watch(deleteRoleUseCaseProvider);

  return RoleController(
    addRoleUseCase: addRole,
    updateRoleUseCase: updateRole,
    deleteRoleUseCase: deleteRole,
  );
});
