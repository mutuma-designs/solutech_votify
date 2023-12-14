import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/users/presentation/controllers/users_controller.dart';
import 'package:solutech_votify/utils/utils.dart';

import '../states/users_state.dart';
import 'user_card.dart';

class UsersListView extends ConsumerWidget {
  const UsersListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(usersStateProvider);
    final users = usersState.users;

    if (usersState is UsersLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (usersState is LoadingUsersFailed) {
      return Center(
        child: Text(usersState.failure.toMessage(context)),
      );
    }

    if (usersState is UsersEmpty) {
      return const Center(child: Text("No users found"));
    }

    return ListView.builder(
      itemCount: users.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final user = users[index];
        return UserCard(
          user: user,
        );
      },
    );
  }
}
