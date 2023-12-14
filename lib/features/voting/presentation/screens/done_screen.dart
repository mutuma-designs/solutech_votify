import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/voting/presentation/screens/start_voting_screen.dart';
import '../../../elections/domain/entities/election.dart';

class DoneScreen extends StatelessWidget {
  static const routePath = '/done';
  final Election election;
  const DoneScreen({super.key, required this.election});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.check_circle,
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              const Text(
                'Thank you for voting!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'You have successfully submitted your vote for the selected candidates.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              MaterialButton(
                onPressed: () => context.go(
                  StartVotingScreen.routePath,
                  extra: election,
                ),
                child: Text(
                  'FINISH PROCESS',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
