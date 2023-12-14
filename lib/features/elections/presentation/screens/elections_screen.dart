import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/elections/presentation/controllers/elections_controller.dart';
import 'package:solutech_votify/utils/extensions/go_router.dart';

import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../domain/entities/election.dart';
import '../widgets/election_details.dart';
import '../widgets/elections_list_view.dart';
import 'add_election_screen.dart';
import 'election_screen.dart';

class ElectionsScreen extends ConsumerWidget {
  static String routePath = "/";
  const ElectionsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(authStateProvider, (previous, next) async {
      if (next.status == AuthStatus.unauthenticated) {
        context.go(LoginScreen.routePath);
      }
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AddElectionScreen.routePath);
        },
        child: const Icon(FeatherIcons.plus),
      ),
      appBar: AppBar(
        title: Text(
          "Elections",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(electionsStateProvider.notifier).getElections();
            },
            icon: const Icon(FeatherIcons.refreshCw),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(FeatherIcons.search),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: const ElectionsListView(),
      ),
    );
  }
}

class ElectionCard extends ConsumerWidget {
  final Election election;
  const ElectionCard({
    super.key,
    required this.election,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        context.push(
          ElectionScreen.routePath.withParams({"id": election.id}),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              election.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElectionDetails(
              election: election,
            ),
          ],
        ),
      ),
    );
  }
}
