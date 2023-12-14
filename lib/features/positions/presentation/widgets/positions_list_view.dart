import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/positions/presentation/widgets/position_card.dart';
import 'package:solutech_votify/utils/utils.dart';

import '../../../elections/presentation/controllers/elections_controller.dart';
import '../../domain/entities/position.dart';
import '../controllers/position_controller.dart';
import '../states/position_state.dart';

class PositionsListView extends ConsumerWidget {
  const PositionsListView({
    super.key,
    required this.positions,
  });

  final List<Position> positions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(positionStateProvider, (prevState, state) {
      if (state is PositionDeleted) {
        context.showSuccessSnackBar("Position deleted successfully");
        ref.read(electionsStateProvider.notifier).getElections();
      }

      if (state is DeletingPositionFailed) {
        state.failure.showSnackBar(context);
      }
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: ListView.builder(
        itemCount: positions.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final position = positions[index];
          return PositionCard(
            position: position,
          );
        },
      ),
    );
  }
}
