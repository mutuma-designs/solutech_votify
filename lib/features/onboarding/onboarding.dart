import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/presentation/controllers/auth_controller.dart';
import '../auth/presentation/screens/login_screen.dart';
import 'presentation/presentation.dart';

export 'presentation/presentation.dart';

class OnboardingFeature extends Feature {
  @override
  List<GoRoute> get routes => [
        GoRoute(
          path: SplashScreen.routePath,
          builder: (context, state) => const SplashScreen(),
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
}
