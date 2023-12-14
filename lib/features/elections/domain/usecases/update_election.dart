import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/elections_repository_impl.dart';
import '../repositories/elections_repository.dart';

class UpdateElectionParams {
  int electionId;
  String name;
  String description;
  int minimumAge;
  DateTime date;
  int maximumVotingTimeInMinutes;
  UpdateElectionParams({
    required this.electionId,
    required this.name,
    required this.description,
    required this.minimumAge,
    required this.date,
    required this.maximumVotingTimeInMinutes,
  });
}

class UpdateElection extends UseCase<void, UpdateElectionParams> {
  ElectionsRepository repository;

  UpdateElection({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(UpdateElectionParams params) async {
    return repository.updateElection(
      id: params.electionId,
      name: params.name,
      description: params.description,
      minimumAge: params.minimumAge,
      date: params.date,
      votingTimeInMinutes: params.maximumVotingTimeInMinutes,
    );
  }
}

final updateElectionUseCaseProvider = Provider<UpdateElection>((ref) {
  final repository = ref.read(electionsRepositoryProvider);
  return UpdateElection(
    repository: repository,
  );
});
