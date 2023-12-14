import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/utils/extensions/context.dart';

import '../../../auth/auth.dart';
import '../../../roles/presentation/screens/roles_screen.dart';
import '../widgets/user_account_view.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static String get routePath => "/settings";

  void logout(BuildContext context, WidgetRef ref) async {
    var isConfirmed = await context.showConfirm(
      title: "Logout?",
      message:
          "You will be logged out of the app and will need to login again.",
      confirmText: "Logout",
    );

    if (isConfirmed) {
      ref.read(authStateProvider.notifier).logout();
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (next.status == AuthStatus.unauthenticated) {
        context.go(LoginScreen.routePath);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            const UserAccountView(),
            Divider(
              color: Colors.grey.shade200,
            ),
            ListTile(
              leading: const Icon(
                FeatherIcons.userX,
              ),
              minLeadingWidth: 0,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Roles',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () {
                context.push(RolesScreen.routePath);
              },
            ),
            ListTile(
              leading: const Icon(
                FeatherIcons.logOut,
                color: Colors.redAccent,
              ),
              minLeadingWidth: 0,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Logout',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.redAccent,
                    ),
              ),
              onTap: () => logout(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}
