import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/candidates/domain/entities/candidates.dart';
import 'package:solutech_votify/features/candidates/presentation/controllers/candidate_controller.dart';
import 'package:solutech_votify/utils/extensions/image.dart';
import 'package:solutech_votify/utils/utils.dart';

class CandidateCard extends ConsumerStatefulWidget {
  final Candidate candidate;

  const CandidateCard({
    super.key,
    required this.candidate,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CandidateCardState();
}

class _CandidateCardState extends ConsumerState<CandidateCard> {
  void deleteCandidate(int candidateId) async {
    var isConfirmed = await context.showConfirm(
      title: "Delete candidate?",
      message: "This action is not reversable.",
      confirmText: "Delete",
    );
    if (!isConfirmed) return;

    ref.watch(candidateStateProvider.notifier).deleteCandidate(candidateId);
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.candidate.user;
    var photo = user.photo;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Row(
        children: [
          if (photo != null)
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
                image: DecorationImage(
                  image: NetworkImage(photo.toAvatarUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (user.age != null)
                        Text(
                          'Age: ${user.age}',
                          style: const TextStyle(fontSize: 14),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () => deleteCandidate(widget.candidate.id),
                  icon: Icon(
                    FeatherIcons.trash2,
                    size: 17,
                    color: Colors.red[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
