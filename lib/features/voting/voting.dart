import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/voting/presentation/screens/done_screen.dart';
import 'package:solutech_votify/features/voting/presentation/screens/voting_screen.dart';

import '../../config/go_router.dart';
import '../auth/presentation/controllers/auth_controller.dart';
import '../auth/presentation/screens/login_screen.dart';
import '../elections/domain/entities/election.dart';
import 'presentation/screens/start_voting_screen.dart';

class VotingFeature extends Feature {
  @override
  List<RouteBase> get routes => [
        GoRoute(
          parentNavigatorKey: parentNavigatorKey,
          path: VotingScreen.routePath,
          builder: (context, state) {
            final extras = state.extra as VotingScreenExtras;
            return VotingScreen(
              election: extras.election,
              token: extras.token,
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
          path: StartVotingScreen.routePath,
          builder: (context, state) {
            final election = state.extra as Election;
            return StartVotingScreen(
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
          path: DoneScreen.routePath,
          builder: (context, state) {
            final election = state.extra as Election;
            return DoneScreen(
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
      ];
}
