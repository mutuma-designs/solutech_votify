import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/utils/utils.dart';

import '../../../elections/presentation/controllers/elections_controller.dart';
import '../../domain/entities/candidates.dart';
import '../controllers/candidate_controller.dart';
import '../states/candidate_state.dart';
import 'candidate_card.dart';

class CandidatesListView extends ConsumerWidget {
  const CandidatesListView({
    super.key,
    required this.candidates,
  });

  final List<Candidate> candidates;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(candidateStateProvider, (previous, next) {
      if (next is CandidateAdded) {
        ref.read(electionsStateProvider.notifier).getElections();
      }

      if (next is CandidateDeleted) {
        context.showSuccessSnackBar("Candidate deleted successfully");
        ref.read(electionsStateProvider.notifier).getElections();
      }
      if (next is DeletingCandidateFailed) {
        next.failure.showSnackBar(context);
      }
    });

    final electionsState = ref.watch(electionsStateProvider);

    if (electionsState.status == ElectionsStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: ListView.builder(
        itemCount: candidates.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final candidate = candidates[index];
          return CandidateCard(
            candidate: candidate,
          );
        },
      ),
    );
  }
}
