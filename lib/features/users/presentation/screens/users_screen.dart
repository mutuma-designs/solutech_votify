import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/users_controller.dart';
import '../widgets/users_list_view.dart';
import 'add_user_screen.dart';

class UsersScreen extends ConsumerStatefulWidget {
  static String routePath = "/users";
  const UsersScreen({super.key});

  @override
  ConsumerState<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AddUserScreen.routePath);
        },
        child: const Icon(FeatherIcons.plus),
      ),
      appBar: AppBar(
        title: Text(
          'Users',
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
        child: const UsersListView(),
      ),
    );
  }
}
