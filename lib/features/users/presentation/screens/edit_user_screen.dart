import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/users/presentation/widgets/edit_user_form.dart';
import 'package:solutech_votify/utils/utils.dart';

import '../controllers/user_controller.dart';
import '../controllers/users_controller.dart';
import '../states/user_state.dart';
import 'add_user_screen.dart';

class EditUserScreenExtra {
  final int userId;
  EditUserScreenExtra({
    required this.userId,
  });
}

class EditUserScreen extends ConsumerStatefulWidget {
  static String routePath = "/edit-user/:userId";
  final int userId;
  const EditUserScreen({super.key, required this.userId});

  @override
  ConsumerState<EditUserScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<EditUserScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(userStateProvider, (prevState, next) {
      if (next is UserUpdated) {
        context.pop();
        context.showSuccessSnackBar("User updated successfully");
      }

      if (next is UpdatingUserFailed) {
        context.pop();
        next.failure.showSnackBar(context);
      }
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AddUserScreen.routePath);
        },
        child: const Icon(FeatherIcons.plus),
      ),
      appBar: AppBar(
        title: Text(
          'Edit user',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(usersStateProvider.notifier).getUsers();
            },
            icon: const Icon(FeatherIcons.refreshCw),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: const EditUserForm(),
      ),
    );
  }
}
