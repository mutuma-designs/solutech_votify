import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:solutech_votify/features/auth/data/models/auth_data_model.dart';
import 'package:solutech_votify/features/elections/presentation/screens/elections_screen.dart';
import "presentation/presentation.dart";
import 'presentation/screens/forgot_password_screen.dart';

export 'presentation/presentation.dart';

class AuthFeature extends Feature {
  @override
  List<GoRoute> get routes => [
        GoRoute(
          path: LoginScreen.routePath,
          builder: (context, state) => const LoginScreen(),
          redirect: (context, state) {
            final ref = ProviderScope.containerOf(context);
            final authState = ref.read(authStateProvider);

            if (authState.status == AuthStatus.authenticated) {
              return ElectionsScreen.routePath;
            }

            return null;
          },
        ),
        GoRoute(
          path: SetupScreen.routePath,
          builder: (context, state) => const SetupScreen(),
        ),
        GoRoute(
          path: ForgotPasswordScreen.routePath,
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
      ];
  @override
  Future<void> preregister() async {
    Hive.registerAdapter(AuthDataModelAdapter());
  }
}
