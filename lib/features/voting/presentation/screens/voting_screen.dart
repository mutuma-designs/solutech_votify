import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/utils/extensions/image.dart';
import 'package:solutech_votify/utils/utils.dart';

import '../../../elections/domain/entities/election.dart';
import '../../domain/entities/token.dart';
import '../controllers/voting_controller.dart';
import '../states/voting_state.dart';
import 'done_screen.dart';

class VotingScreenExtras {
  final Election election;
  final Token token;
  VotingScreenExtras({
    required this.election,
    required this.token,
  });
}

class VotingScreen extends ConsumerStatefulWidget {
  static const routePath = '/voting';
  final Election election;
  final Token token;

  const VotingScreen({
    super.key,
    required this.election,
    required this.token,
  });
  @override
  VotingScreenState createState() => VotingScreenState();
}

class VotingScreenState extends ConsumerState<VotingScreen> {
  List<List<int>> selectedCandidates = [];
  PageController pageController = PageController(initialPage: 0);
  int currentPositionIndex = 0;

  void toggleCandidate(int candidateId) {
    setState(() {
      if (selectedCandidates[currentPositionIndex].contains(candidateId)) {
        selectedCandidates[currentPositionIndex].remove(candidateId);
      } else {
        selectedCandidates[currentPositionIndex].add(candidateId);
      }
    });
  }

  bool isCandidateSelected(int candidateId) {
    return selectedCandidates[currentPositionIndex].contains(candidateId);
  }

  void nextPage() async {
    if (selectedCandidates[currentPositionIndex].isEmpty) {
      context.showAlert(
        title: "Please select a candidate",
        message: "You must select a candidate in this position to proceed",
      );
      return;
    }

    if (selectedCandidates[currentPositionIndex].length <
        widget.election.positions[currentPositionIndex].maxSelections) {
      context.showAlert(
        title:
            "Please select ${widget.election.positions[currentPositionIndex].maxSelections} candidates",
        message:
            "You must select ${widget.election.positions[currentPositionIndex].maxSelections} candidates in this position to proceed",
      );
      return;
    }

    if (currentPositionIndex < widget.election.positions.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      bool isConfirmed = await context.showConfirm(
        title: "Confirm votes",
        message: "Are you sure you want to cast your votes?",
      );
      if (!isConfirmed) return;
      ref.read(votingStateProvider.notifier).castVotes(
            widget.token.id,
            selectedCandidates.flattened.toList(),
          );
    }
  }

  void previousPage() {
    if (currentPositionIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedCandidates.isEmpty) {
      selectedCandidates = List.generate(
        widget.election.positions.length,
        (index) => [],
      );
    }
    ref.listen(votingStateProvider, (previous, next) {
      if (next is CastingVotes) {
        context.showLoadingDialog("Casting votes...");
      }

      if (next is VotesCastFailed) {
        context.pop();
        next.failure.showSnackBar(context);
      }

      if (next is VotesCasted) {
        context.pop();
        context.showSuccessSnackBar("Votes casted successfully");
        context.go(
          DoneScreen.routePath,
          extra: widget.election,
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.election.positions.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPositionIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  var position = widget.election.positions[index];
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            position.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            position.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[700],
                                ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${selectedCandidates[currentPositionIndex].length} of ${position.maxSelections} candidates",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: position.candidates.length,
                            itemBuilder: (context, candidateIndex) {
                              var candidate =
                                  position.candidates[candidateIndex].user;
                              var candidateId =
                                  position.candidates[candidateIndex].id;
                              var photo = candidate.photo;

                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    if (photo != null)
                                      Image.network(
                                        photo.toAvatarUrl,
                                        fit: BoxFit.cover,
                                        height: 80,
                                        width: 80,
                                      ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        candidate.fullName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                    Checkbox(
                                      value: isCandidateSelected(candidateId),
                                      onChanged: (selectedCandidates[
                                                          currentPositionIndex]
                                                      .length <
                                                  position.maxSelections ||
                                              isCandidateSelected(candidateId))
                                          ? (value) =>
                                              toggleCandidate(candidateId)
                                          : (value) {
                                              context.showAlert(
                                                title:
                                                    "Maximum selection reached",
                                                message:
                                                    "You can only select ${position.maxSelections} candidates for this position",
                                              );
                                            },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            LinearProgressIndicator(
              value:
                  (currentPositionIndex + 1) / widget.election.positions.length,
              backgroundColor: Colors.blueGrey.shade100,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 110,
              child: MaterialButton(
                onPressed: currentPositionIndex == 0 ? null : previousPage,
                disabledColor: Colors.grey.shade300,
                color: Theme.of(context).primaryColor,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 16,
                      color: Colors.white,
                    ),
                    Text(
                      'Previous',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${currentPositionIndex + 1} of ${widget.election.positions.length}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.blueGrey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ),
            SizedBox(
              width: 110,
              child: ElevatedButton(
                onPressed: nextPage,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      currentPositionIndex ==
                              widget.election.positions.length - 1
                          ? 'Cast Votes'
                          : 'Next',
                    ),
                    if (currentPositionIndex !=
                        widget.election.positions.length - 1)
                      const Icon(
                        Icons.arrow_forward,
                        size: 16,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
