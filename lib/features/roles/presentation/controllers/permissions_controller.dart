import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedPermissionsController extends StateNotifier<List<String>> {
  SelectedPermissionsController() : super([]);

  void togglePermission(String permission) {
    if (state.contains(permission)) {
      state = [...state.where((element) => element != permission).toList()];
    } else {
      state = [...state, permission];
    }
  }
}

final selectedPermissionsProvider = StateNotifierProvider.autoDispose<
    SelectedPermissionsController, List<String>>((ref) {
  return SelectedPermissionsController();
});
