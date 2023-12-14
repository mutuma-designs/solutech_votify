import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/elections/presentation/screens/update_election_screen.dart';
import 'package:solutech_votify/features/positions/presentation/widgets/add_position_form.dart';
import 'package:solutech_votify/utils/extensions/go_router.dart';
import 'package:solutech_votify/utils/utils.dart';

import '../../../../config/permissions.dart';
import '../../../auth/auth.dart';
import '../../../positions/presentation/widgets/positions_list_view.dart';
import '../../../verification/presentation/screens/verification_screen.dart';
import '../../../voting/presentation/screens/start_voting_screen.dart';
import '../../domain/entities/election.dart';
import '../../domain/usecases/end_election.dart';
import '../../domain/usecases/start_election.dart';
import '../controllers/elections_controller.dart';
import '../widgets/election_details.dart';
import '../../../results/presentation/widgets/results_view.dart';

class ElectionScreen extends ConsumerWidget {
  static const routePath = '/elections/:id';
  final int electionId;
  const ElectionScreen({
    Key? key,
    required this.electionId,
  }) : super(key: key);

  startElection(BuildContext context, WidgetRef ref) async {
    var isConfirmed = await context.showConfirm(
      title: "Start election?",
      message:
          "Once started, participants will be able to cast their votes. You will not be able to make any changes to the election settings or candidates after starting.",
      confirmText: "Start",
    );

    if (!isConfirmed) return;

    var startElectionParams = StartElectionParams(
      electionId: electionId,
    );

    var electionsController = ref.read(electionsStateProvider.notifier);
    electionsController.startElection(startElectionParams);
  }

  endElection(BuildContext context, WidgetRef ref) async {
    var isConfirmed = await context.showConfirm(
      title: "End election?",
      message:
          "Once ended, participants will no longer be able to cast their votes. You will still be able to view the results and make any necessary analysis..",
      confirmText: "End",
    );

    if (!isConfirmed) return;

    var endElectionParams = EndElectionParams(
      electionId: electionId,
    );

    var electionsController = ref.read(electionsStateProvider.notifier);
    electionsController.endElection(endElectionParams);
  }

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(electionsStateProvider, (prevState, state) {
      if (state.status == ElectionsStatus.deleted) {
        context.showSuccessSnackBar("Election deleted successfully");
        context.pop();
      }

      if (state.status == ElectionsStatus.started) {
        context.showSuccessSnackBar("Election started successfully");
      }

      if (state.status == ElectionsStatus.ended) {
        context.showSuccessSnackBar("Election ended successfully");
      }

      if (state.failure != null) {
        state.failure!.showSnackBar(context);
      }
    });

    final authState = ref.watch(authStateProvider);

    final election = ref.watch(electionProvider(electionId));

    if (authState.status != AuthStatus.authenticated || election == null) {
      return const SizedBox();
    }

    final user = authState.value!;

    final canShowStartElectionButton =
        !election.isStarted && user.hasPremission(Permissions.startElections);

    final canShowEndElectionButton = election.isStarted &&
        !election.isEnded &&
        user.hasPremission(Permissions.endElections);

    final canShowVerifyUsersButton = election.isStarted &&
        !election.isEnded &&
        user.hasPremission(Permissions.verifyUsers);

    final canShowVotingButton = election.isStarted &&
        !election.isEnded &&
        user.hasPremission(Permissions.createVotes);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.showModal(
              title: "Add Position",
              child: AddPositionForm(electionId: electionId),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  centerTitle: false,
                  expandedHeight: 290,
                  title: Text(
                    election.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        ref
                            .read(electionsStateProvider.notifier)
                            .getElections();
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                    IconButton(
                      onPressed: () {
                        context.push(
                          UpdateElectionScreen.routePath.withParams({
                            "id": electionId,
                          }),
                        );
                      },
                      icon: const Icon(FeatherIcons.edit3),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.all(10.0).copyWith(top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElectionDetails(
                            election: election,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (canShowStartElectionButton)
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: MaterialButton(
                                    color: Colors.green,
                                    textColor: Colors.white,
                                    onPressed: () =>
                                        startElection(context, ref),
                                    child: const Text('Start Election'),
                                  ),
                                ),
                              if (canShowVerifyUsersButton)
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.pushReplacement(
                                        VerificationScreen.routePath,
                                        extra: election,
                                      );
                                    },
                                    child: const Text('Verify Voters'),
                                  ),
                                ),
                              if (canShowVotingButton)
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.push<Election>(
                                        StartVotingScreen.routePath,
                                        extra: election,
                                      );
                                    },
                                    child: const Text('Vote'),
                                  ),
                                ),
                              if (canShowEndElectionButton)
                                MaterialButton(
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  onPressed: () => endElection(context, ref),
                                  child: const Text('End Election'),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _TabHeaderDelegate(
                    TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      labelColor: Colors.black,
                      tabs: const [
                        Tab(text: 'Positions'),
                        Tab(text: 'Results'),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: [
                PositionsListView(
                  positions: election.positions,
                ),
                ResultsView(
                  electionId: election.id,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _TabHeaderDelegate(this._tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_TabHeaderDelegate oldDelegate) {
    return false;
  }
}
