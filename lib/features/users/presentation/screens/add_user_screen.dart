import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/users/presentation/widgets/add_user_form.dart';

import '../widgets/upload_users_form.dart';

enum UserCreationMode {
  single,
  upload,
}

final userCreationModeProvider = StateProvider.autoDispose<UserCreationMode>(
  (ref) => UserCreationMode.single,
);

class AddUserScreen extends ConsumerWidget {
  static const routePath = '/add-user';
  const AddUserScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    var userCreationMode = ref.watch(userCreationModeProvider);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Add User",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        value: UserCreationMode.single,
                        groupValue: userCreationMode,
                        onChanged: (value) {
                          if (value != null) {
                            ref.read(userCreationModeProvider.notifier).state =
                                value;
                          }
                        },
                        title: const Text("Single"),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        value: UserCreationMode.upload,
                        groupValue: userCreationMode,
                        onChanged: (value) {
                          if (value != null) {
                            ref.read(userCreationModeProvider.notifier).state =
                                value;
                          }
                        },
                        title: const Text("Upload"),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: switch (userCreationMode) {
                    UserCreationMode.single => const AddUserForm(),
                    UserCreationMode.upload => const UploadUsersForm(),
                  },
                ),
              ],
            ),
          )),
    );
  }
}
