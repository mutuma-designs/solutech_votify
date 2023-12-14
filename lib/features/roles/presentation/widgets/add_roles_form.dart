import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/roles/presentation/controllers/role_controller.dart';
import 'package:solutech_votify/utils/utils.dart';
import 'package:solutech_votify/widgets/primary_button.dart';
import '../../../../config/permissions.dart';
import '../../../../config/styles.dart';
import '../controllers/permissions_controller.dart';
import '../controllers/roles_controller.dart';
import '../states/role_state.dart';

class AddRolesForm extends ConsumerStatefulWidget {
  const AddRolesForm({super.key});

  @override
  ConsumerState<AddRolesForm> createState() => _AddRolesFormState();
}

class _AddRolesFormState extends ConsumerState<AddRolesForm> {
  final formKey = GlobalKey<FormState>();
  final roleNameController = TextEditingController();

  void submit() {
    if (formKey.currentState!.validate()) {
      final roleController = ref.read(roleStateProvider.notifier);
      roleController.saveRole(
        name: roleNameController.text.trim(),
        permissions: ref.read(selectedPermissionsProvider).toList(),
      );
    }
  }

  final permissions = [
    Permissions.listElections,
    Permissions.createElections,
    Permissions.readElections,
    Permissions.updateElections,
    Permissions.deleteElections,
    Permissions.startElections,
    Permissions.endElections,
    Permissions.listCandidates,
    Permissions.createCandidates,
    Permissions.readCandidates,
    Permissions.updateCandidates,
    Permissions.deleteCandidates,
    Permissions.listUsers,
    Permissions.createUsers,
    Permissions.readUsers,
    Permissions.updateUsers,
    Permissions.deleteUsers,
    Permissions.verifyUsers,
    Permissions.createVotes,
    Permissions.positions,
    Permissions.createPositions,
    Permissions.readPositions,
    Permissions.updatePositions,
    Permissions.deletePositions,
    Permissions.listRoles,
    Permissions.createRoles,
    Permissions.readRoles,
    Permissions.updateRoles,
    Permissions.deleteRoles,
  ];

  @override
  Widget build(BuildContext context) {
    ref.listen(roleStateProvider, (prevState, state) {
      if (state is RoleAdded) {
        context.showSuccessSnackBar("Role added successfully");
        ref.read(rolesStateProvider.notifier).getRoles();
        context.pop();
      }

      if (state is AddingRoleFailed) {
        state.failure.showSnackBar(context);
      }
    });

    var roleState = ref.watch(roleStateProvider);
    var selectedPermissions = ref.watch(selectedPermissionsProvider);
    return Form(
      key: formKey,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Select Permissions",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: permissions.length,
              itemBuilder: (context, index) {
                var permission = permissions[index];
                return CheckboxListTile(
                  value: selectedPermissions.contains(permission),
                  onChanged: (value) {
                    ref
                        .read(selectedPermissionsProvider.notifier)
                        .togglePermission(permission);
                  },
                  title: Text(permission),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: roleNameController,
            validator: (value) {
              if (value!.isEmpty) return "Please enter name";
              return null;
            },
            decoration: InputDecoration(
              hintText: "Role name",
              hintStyle: const TextStyle(
                color: Color(0xff565765),
              ),
              labelText: "Role name",
              isDense: true,
              filled: true,
              border: defaultInputBorder,
              enabledBorder: defaultInputBorder,
              focusedBorder: defaultInputBorder,
            ),
          ),
          const SizedBox(height: 10),
          PrimaryButton(
            isLoading: roleState is RoleSaving,
            onTap: submit,
            title: "Save role",
          ),
        ],
      ),
    );
  }
}
