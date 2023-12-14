import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:solutech_votify/config/go_router.dart';

import '../auth/presentation/controllers/auth_controller.dart';
import '../auth/presentation/screens/login_screen.dart';
import 'data/models/role_model.dart';
import 'presentation/screens/add_roles_screen.dart';
import 'presentation/screens/roles_screen.dart';

class RolesFeature extends Feature {
  @override
  List<RouteBase> get routes => [
        GoRoute(
          parentNavigatorKey: parentNavigatorKey,
          path: RolesScreen.routePath,
          builder: (context, state) => const RolesScreen(),
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
          parentNavigatorKey: parentNavigatorKey,
          path: AddRolesScreen.routePath,
          builder: (context, state) => const AddRolesScreen(),
          redirect: (context, state) {
            var ref = ProviderScope.containerOf(context);
            var authState = ref.read(authStateProvider);

            if (authState.status != AuthStatus.authenticated) {
              return LoginScreen.routePath;
            }
            return null;
          },
        ),
      ];

  @override
  Future<void> preregister() async {
    Hive.registerAdapter(RoleModelAdapter());
  }
}
