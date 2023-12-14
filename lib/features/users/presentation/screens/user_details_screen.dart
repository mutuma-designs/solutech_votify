import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/utils/utils.dart';
import '../controllers/user_controller.dart';
import '../controllers/users_controller.dart';
import '../states/user_state.dart';
import '../states/users_state.dart';
import '../widgets/user_details_view.dart';

class UserDetailsScreenExtra {
  final int userId;
  UserDetailsScreenExtra({
    required this.userId,
  });
}

class UserDetailsScreen extends ConsumerStatefulWidget {
  final int userId;
  static String routePath = "/user-details/:userId";

  const UserDetailsScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  ConsumerState<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  void deleteUser() async {
    var isConfirmed = await context.showConfirm(
      title: "Delete user?",
      message: "This action is irreversible",
      confirmText: "Delete",
    );

    if (isConfirmed) {
      ref.read(userStateProvider.notifier).deleteUser(widget.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider(widget.userId));
    final usersState = ref.watch(usersStateProvider);

    if (usersState is UsersLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (usersState is LoadingUsersFailed) {
      return Center(
        child: Text(usersState.failure.toMessage(context)),
      );
    }

    if (usersState is UsersEmpty || user == null) {
      return const Center(child: Text("User not found"));
    }

    ref.listen(userStateProvider, (previous, next) {
      if (next is UserDeleted) {
        context.showSuccessSnackBar("User deleted successfully");
        ref.read(usersStateProvider.notifier).getUsers();
        context.pop();
      }

      if (next is DeletingUserFailed) {
        next.failure.showSnackBar(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserDetailsView(
                user: user,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.red,
                    onPressed: deleteUser,
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  /* const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Edit'),
                  ), */
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
