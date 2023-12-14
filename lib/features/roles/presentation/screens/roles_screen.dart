import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/roles/presentation/controllers/roles_controller.dart';

import '../widgets/role_list_view.dart';
import 'add_roles_screen.dart';

class RolesScreen extends ConsumerWidget {
  static const routePath = '/roles';
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Roles',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(rolesStateProvider.notifier).getRoles();
            },
            icon: const Icon(FeatherIcons.refreshCw),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AddRolesScreen.routePath);
        },
        child: const Icon(FeatherIcons.plus),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: const RolesListView(),
        ),
      ),
    );
  }
}
