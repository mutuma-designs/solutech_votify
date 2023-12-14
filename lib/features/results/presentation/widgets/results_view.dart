import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/results/data/test_results.dart';

import '../../../../config/dio.dart';

final testResultsProvider = FutureProvider.family
    .autoDispose<TestResults, int>((ref, int electionId) async {
  var dio = ref.watch(dioProvider);
  var response = await dio.get(
    "/results/$electionId",
  );
  return TestResults.fromMap(response.data);
});

class PositionData {
  final String position;
  final List<CandidateData> candidates;

  PositionData(this.position, this.candidates);
}

class ResultsView extends ConsumerWidget {
  final int electionId;
  const ResultsView({
    super.key,
    required this.electionId,
  });

  @override
  Widget build(BuildContext context, ref) {
    var electionResults = ref.watch(testResultsProvider(electionId));

    return Scaffold(
        body: electionResults.when(
      data: (electionResults) {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: StatsCard(
                      title: 'Verified Voters',
                      value: '${electionResults.stats.totalVerified}',
                    ),
                  ),
                  Expanded(
                    child: StatsCard(
                      title: 'Voted Voters',
                      value: '${electionResults.stats.totalVotes}',
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Candidates',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: electionResults.results.map((result) {
                  return PositionResultCard(result);
                }).toList(),
              ),
            ),
          ],
        );
      },
      error: (error, s) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  const StatsCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                    )),
          ],
        ),
      ),
    );
  }
}

class PositionResultCard extends StatelessWidget {
  final Result result;

  const PositionResultCard(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            result.name,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: result.candidates.map((candidate) {
            return CandidateResultCard(candidate);
          }).toList(),
        ),
        const Divider(),
      ],
    );
  }
}

class CandidateData {
  final String name;
  final int votes;

  CandidateData(this.name, this.votes);
}

class CandidateResultCard extends StatelessWidget {
  final Candidate candidate;

  const CandidateResultCard(this.candidate, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: ListTile(
        title: Text(candidate.user.fullName),
        trailing: Text('${candidate.votes.length} votes'),
      ),
    );
  }
}
