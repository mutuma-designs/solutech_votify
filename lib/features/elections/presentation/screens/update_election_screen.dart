import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/elections/presentation/widgets/update_election_form.dart';

import '../../../auth/auth.dart';

class UpdateElectionScreen extends ConsumerWidget {
  static const routePath = '/update-election/:id';
  final int electionId;
  const UpdateElectionScreen({
    Key? key,
    required this.electionId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authStateProvider);

    if (authState.status == AuthStatus.authenticated) {
      return const SizedBox();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Update Election",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: UpdateElectionForm(
            electionId: electionId,
          ),
        ),
      ),
    );
  }
}
