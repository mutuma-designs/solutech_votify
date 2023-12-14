import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/users_controller.dart';
import '../states/users_state.dart';

class SelectUserView extends ConsumerWidget {
  const SelectUserView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredUsers = ref.watch(filteredUsersProvider);
    final usersState = ref.watch(usersStateProvider);

    return Column(
      children: [
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Search',
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            ref.read(userSearchQueryProvider.notifier).state = value;
          },
        ),
        const SizedBox(height: 16),
        if (usersState is UsersEmpty)
          const Center(child: Text("No users found")),
        if (usersState is UsersLoading)
          const Center(child: CircularProgressIndicator()),
        if (usersState is! UsersLoading)
          ListView.builder(
            itemCount: filteredUsers.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final user = filteredUsers[index];
              return ListTile(
                onTap: () {
                  context.pop(user);
                },
                title: Text(user.fullName),
                subtitle: Text(user.email),
              );
            },
          )
      ],
    );
  }
}
