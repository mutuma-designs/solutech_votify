import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/auth/auth.dart';

import '../../config/go_router.dart';
import 'presentation/screens/add_election_screen.dart';
import 'presentation/screens/election_screen.dart';
import 'presentation/screens/update_election_screen.dart';

class ElectionsFeature extends Feature {
  @override
  List<RouteBase> get routes => [
        GoRoute(
          parentNavigatorKey: parentNavigatorKey,
          path: ElectionScreen.routePath,
          builder: (context, state) {
            final int electionId = int.parse("${state.params["id"]}");
            return ElectionScreen(
              electionId: electionId,
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
          path: AddElectionScreen.routePath,
          builder: (context, state) => const AddElectionScreen(),
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
          path: UpdateElectionScreen.routePath,
          builder: (context, state) {
            final int electionId = int.parse("${state.params["id"]}");
            return UpdateElectionScreen(
              electionId: electionId,
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
        )
      ];
}
