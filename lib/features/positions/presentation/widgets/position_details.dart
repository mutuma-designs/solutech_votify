import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/utils/utils.dart';

import '../../domain/entities/position.dart';
import '../controllers/position_controller.dart';

class PositionDetails extends ConsumerWidget {
  final Position position;
  const PositionDetails({
    super.key,
    required this.position,
  });

  void deletePosition(BuildContext context, WidgetRef ref) async {
    bool isConfirmed = await context.showConfirm(
      title: "Delete Position?",
      message:
          "This action cannot be undone. Deleting the position will permanently remove all candidates and other associated position data.",
      confirmText: "Delete",
    );

    if (isConfirmed) {
      ref.read(positionStateProvider.notifier).deletePosition(position.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                position.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
              ),
            ),
            IconButton(
              onPressed: () => deletePosition(context, ref),
              icon: Icon(
                FeatherIcons.trash2,
                size: 17,
                color: Colors.red[600],
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Max Selections: ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              TextSpan(
                text: "${position.maxSelections}",
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Candidates: ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              TextSpan(
                text: "${position.candidates.length}",
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
