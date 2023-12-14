import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/roles/presentation/controllers/role_controller.dart';
import 'package:solutech_votify/utils/utils.dart';

import '../../domain/entities/role.dart';

class RoleCard extends ConsumerWidget {
  const RoleCard({
    super.key,
    required this.role,
  });

  final Role role;

  void deleteRole(BuildContext context, WidgetRef ref) async {
    var isConfirmed = await context.showConfirm(
      title: "Delete role?",
      message: "This role will be deleted permanently.",
      confirmText: "Delete",
    );

    if (isConfirmed) {
      ref.read(roleStateProvider.notifier).deleteRole(role.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(FeatherIcons.user, size: 18),
                const SizedBox(width: 10),
                Text(
                  role.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                )
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                spacing: 6,
                runSpacing: 2,
                children: List.generate(
                  role.permissions.length,
                  (index) => Chip(
                    label: Text(
                      role.permissions[index],
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /*  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FeatherIcons.edit3,
                      size: 18,
                    ),
                  ), */
                  IconButton(
                    onPressed: () => deleteRole(context, ref),
                    icon: const Icon(
                      size: 18,
                      FeatherIcons.trash2,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
