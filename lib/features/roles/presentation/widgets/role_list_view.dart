import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/roles/presentation/widgets/role_card.dart';
import 'package:solutech_votify/utils/utils.dart';
import '../controllers/role_controller.dart';
import '../controllers/roles_controller.dart';
import '../states/role_state.dart';
import '../states/roles_state.dart';

class RolesListView extends ConsumerWidget {
  const RolesListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(roleStateProvider, (prevState, state) {
      if (state is RoleDeleted) {
        context.showSuccessSnackBar("Role deleted successfully");
        ref.read(rolesStateProvider.notifier).getRoles();
      }

      if (state is DeletingRoleFailed) {
        state.failure.showSnackBar(context);
      }
    });

    var rolesState = ref.watch(rolesStateProvider);
    var roles = rolesState.roles;

    if (rolesState is RolesLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (rolesState is LoadingRolesFailed) {
      return Center(
        child: Text(
          rolesState.failure.toMessage(context),
        ),
      );
    }

    if (rolesState is RolesEmpty) {
      return const Center(
        child: Text(
          "No roles found",
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: roles.length,
      itemBuilder: (context, index) {
        var role = roles[index];
        return RoleCard(role: role);
      },
    );
  }
}
