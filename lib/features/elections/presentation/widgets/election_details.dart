import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/utils/extensions/context.dart';
import 'package:solutech_votify/utils/extensions/date_time.dart';
import '../../domain/entities/election.dart';
import '../../domain/usecases/delete_election.dart';
import '../controllers/elections_controller.dart';

class ElectionDetails extends ConsumerWidget {
  final Election election;
  const ElectionDetails({
    super.key,
    required this.election,
  });

  void deleteElection(BuildContext context, WidgetRef ref) async {
    bool isConfirmed = await context.showConfirm(
      title: "Delete Election?",
      message:
          "This action cannot be undone. Deleting the election will permanently remove results and other associated election data.",
      confirmText: "Delete",
    );

    if (!isConfirmed) return;

    var deleteElectionParams = DeleteElectionParams(
      electionId: election.id,
    );

    var electionsController = ref.read(electionsStateProvider.notifier);
    electionsController.deleteElection(deleteElectionParams);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var startedAt = election.startedAt;
    var endedAt = election.endedAt;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                election.description,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            IconButton(
              onPressed: () => deleteElection(context, ref),
              icon: Icon(
                FeatherIcons.trash2,
                size: 17,
                color: Colors.red[600],
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: 'Date: ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextSpan(
              text: election.date.toFormattedStringWithMonth(),
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        )),
        const SizedBox(height: 4),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: 'Minimum Age: ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextSpan(
              text: "${election.minimumAge} years",
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        )),
        const SizedBox(height: 4),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: 'Positions: ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextSpan(
              text: '${election.positions.length}',
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        )),
        if (startedAt != null) const SizedBox(height: 4),
        if (startedAt != null)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Started: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextSpan(
                  text: startedAt.toFormattedStringWithMonthAndTime(),
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        if (endedAt != null) const SizedBox(height: 4),
        if (endedAt != null)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Ended: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextSpan(
                  text: endedAt.toFormattedStringWithMonthAndTime(),
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}
