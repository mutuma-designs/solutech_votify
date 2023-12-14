import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/voting/presentation/screens/voting_screen.dart';
import 'package:solutech_votify/features/voting/presentation/states/voting_state.dart';
import 'package:solutech_votify/utils/utils.dart';

import '../../../../config/images.dart';
import '../../../../config/styles.dart';
import '../../../../widgets/primary_button.dart';
import '../../../elections/domain/entities/election.dart';
import '../controllers/voting_controller.dart';

class StartVotingScreen extends ConsumerStatefulWidget {
  static const routePath = '/start-voting';
  final Election election;
  const StartVotingScreen({
    super.key,
    required this.election,
  });
  @override
  StartVotingScreenState createState() => StartVotingScreenState();
}

class StartVotingScreenState extends ConsumerState<StartVotingScreen> {
  final formKey = GlobalKey<FormState>();
  final tokenController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    tokenController.dispose();
  }

  void startVoting() {
    if (formKey.currentState!.validate()) {
      ref.read(votingStateProvider.notifier).startVoting(tokenController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(votingStateProvider, (previous, next) {
      if (next is VotingStarted) {
        context.go(
          VotingScreen.routePath,
          extra: VotingScreenExtras(
            election: widget.election,
            token: next.token,
          ),
        );
      }

      if (next is VotingStartFailed) {
        next.failure.showSnackBar(context);
      }
    });
    final votingState = ref.watch(votingStateProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Images.appIcon, width: 100, height: 100),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.election.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.election.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Enter the token to start voting",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: tokenController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Token is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Enter Token",
                  hintStyle: const TextStyle(
                    color: Color(0xff565765),
                  ),
                  labelText: "Token",
                  isDense: true,
                  filled: true,
                  border: defaultInputBorder,
                  enabledBorder: defaultInputBorder,
                  focusedBorder: defaultInputBorder,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              PrimaryButton(
                isLoading: votingState is StartingVoting,
                onTap: startVoting,
                title: "Start Voting",
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
