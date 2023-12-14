import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/candidates/presentation/widgets/candidates_list_view.dart';
import 'package:solutech_votify/features/positions/presentation/states/position_state.dart';
import 'package:solutech_votify/features/positions/presentation/widgets/edit_position_form.dart';
import 'package:solutech_votify/utils/utils.dart';
import '../../../candidates/presentation/widgets/add_candidate_form.dart';
import '../../../elections/presentation/controllers/elections_controller.dart';
import '../controllers/position_controller.dart';
import '../widgets/position_details.dart';

class PositionScreen extends ConsumerWidget {
  static const routePath = '/positions/:id';
  final int positionId;

  const PositionScreen({
    super.key,
    required this.positionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(positionProvider(positionId));

    ref.listen(positionStateProvider, (prevState, state) {
      if (state is PositionDeleted) {
        context.showSuccessSnackBar("Position deleted successfully");
        context.pop();
        ref.read(electionsStateProvider.notifier).getElections();
      }

      if (state is DeletingPositionFailed) {
        state.failure.showSnackBar(context);
      }
    });

    if (position == null) {
      return const SizedBox();
    }

    final candidates = position.candidates;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await context.showModal(
              title: "Add Candidate",
              child: AddCandidateForm(
                positionId: position.id,
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  centerTitle: false,
                  expandedHeight: 180,
                  title: Text(
                    position.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        context.showModal(
                          title: "Update position",
                          child: UpdatePositionForm(positionId: positionId),
                        );
                      },
                      icon: const Icon(
                        FeatherIcons.edit3,
                        color: Colors.black,
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.all(10.0).copyWith(top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          PositionDetails(
                            position: position,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PositionHeaderDelegate("Candidates"),
                  pinned: true,
                ),
              ];
            },
            body: CandidatesListView(
              candidates: candidates,
            ),
          ),
        ),
      ),
    );
  }
}

class PositionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String positionName;

  PositionHeaderDelegate(this.positionName);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      alignment: Alignment.centerLeft,
      child: Text(
        positionName,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 64;

  @override
  double get minExtent => 64;

  @override
  bool shouldRebuild(PositionHeaderDelegate oldDelegate) {
    return positionName != oldDelegate.positionName;
  }
}
