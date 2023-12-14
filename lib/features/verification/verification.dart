import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:solutech_votify/config/go_router.dart';
import 'package:solutech_votify/features/elections/domain/entities/election.dart';
import 'package:solutech_votify/features/verification/domain/entities/verification.dart';

import '../auth/presentation/controllers/auth_controller.dart';
import '../auth/presentation/screens/login_screen.dart';
import 'data/models/verification_model.dart';
import 'presentation/screens/verification_result_screen.dart';
import 'presentation/screens/verification_screen.dart';

class VerificationFeature extends Feature {
  @override
  List<RouteBase> get routes => [
        GoRoute(
          parentNavigatorKey: parentNavigatorKey,
          path: VerificationScreen.routePath,
          builder: (context, state) {
            final election = state.extra as Election;
            return VerificationScreen(
              election: election,
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
          path: VerificationResultScreen.routePath,
          builder: (context, state) {
            final verification = state.extra as Verification;
            return VerificationResultScreen(verification);
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
    Hive.registerAdapter(VerificationModelAdapter());
    Hive.registerAdapter(VerificationResultModelAdapter());
  }
}
