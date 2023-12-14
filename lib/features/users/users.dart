import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:solutech_votify/features/users/presentation/screens/edit_user_screen.dart';

import '../../config/go_router.dart';
import '../auth/presentation/controllers/auth_controller.dart';
import '../auth/presentation/screens/login_screen.dart';
import 'data/models/user_model.dart';
import 'presentation/screens/add_user_screen.dart';
import 'presentation/screens/user_details_screen.dart';

class UsersFeature extends Feature {
  @override
  List<RouteBase> get routes => [
        GoRoute(
          parentNavigatorKey: parentNavigatorKey,
          path: AddUserScreen.routePath,
          builder: (context, state) => const AddUserScreen(),
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
          path: EditUserScreen.routePath,
          builder: (context, state) {
            final extra = state.extra as EditUserScreenExtra;
            return EditUserScreen(
              userId: extra.userId,
            );
          },
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
          path: UserDetailsScreen.routePath,
          builder: (context, state) {
            final extra = state.extra as UserDetailsScreenExtra;
            return UserDetailsScreen(
              userId: extra.userId,
            );
          },
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
    Hive.registerAdapter(UserModelAdapter());
  }
}
