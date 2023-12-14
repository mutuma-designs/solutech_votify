import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/settings/presentation/screens/settings_screen.dart';
import '../auth/auth.dart';
import '../users/presentation/screens/users_screen.dart';
import '../elections/presentation/screens/elections_screen.dart';
import '../../widgets/app_scaffold.dart';

class HomeFeature extends Feature {
  @override
  List<RouteBase> get routes => [
        ShellRoute(
          builder: (context, state, child) {
            return AppScaffold(child: child);
          },
          routes: <RouteBase>[
            GoRoute(
              path: ElectionsScreen.routePath,
              builder: (context, state) => const ElectionsScreen(),
              redirect: (context, state) {
                final ref = ProviderScope.containerOf(context);
                final authState = ref.read(authStateProvider);

                if (authState.status != AuthStatus.authenticated) {
                  return LoginScreen.routePath;
                }

                return null;
              },
            ),
            GoRoute(
              path: UsersScreen.routePath,
              builder: (context, state) => const UsersScreen(),
              redirect: (context, state) {
                var ref = ProviderScope.containerOf(context);
                var authState = ref.read(authStateProvider);

                if (authState.status != AuthStatus.authenticated) {
                  return LoginScreen.routePath;
                }
                return null;
              },
            ),
            GoRoute(
              path: SettingsScreen.routePath,
              builder: (context, state) => const SettingsScreen(),
              redirect: (context, state) {
                var ref = ProviderScope.containerOf(context);
                var authState = ref.read(authStateProvider);

                if (authState.status != AuthStatus.authenticated) {
                  return LoginScreen.routePath;
                }
                return null;
              },
            ),
          ],
        ),
      ];
}
