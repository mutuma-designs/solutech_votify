import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/utils/utils.dart';
import 'package:solutech_votify/widgets/empty_widget.dart';
import 'package:solutech_votify/widgets/failure_widget.dart';

import '../../../../widgets/loading_widget.dart';
import '../controllers/elections_controller.dart';
import '../screens/elections_screen.dart';

class ElectionsListView extends ConsumerWidget {
  const ElectionsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final electionsState = ref.watch(electionsStateProvider);

    ref.listen(electionsStateProvider, (prevState, state) {
      if (state.status == ElectionsStatus.deleted) {
        context.showSuccessSnackBar("Election deleted successfully");
      }

      if (state.status == ElectionsStatus.deletingFailed) {
        state.failure!.showSnackBar(context);
      }
    });

    return switch (electionsState.status) {
      ElectionsStatus.loading => const LoadingWidget(),
      ElectionsStatus.loadingFailed => FailureWidget(electionsState.failure!),
      ElectionsStatus.empty => const EmptyWidget("No elections found"),
      _ => ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: electionsState.data.length,
          itemBuilder: (context, index) {
            final election = electionsState.data[index];
            return ElectionCard(
              election: election,
            );
          },
        ),
    };
  }
}
