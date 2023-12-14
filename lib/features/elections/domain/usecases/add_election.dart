import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/elections_repository_impl.dart';
import '../repositories/elections_repository.dart';

class AddElectionParams {
  String name;
  String description;
  int minimumAge;
  DateTime date;
  int maximumVotingTimeInMinutes;
  AddElectionParams({
    required this.name,
    required this.description,
    required this.minimumAge,
    required this.date,
    required this.maximumVotingTimeInMinutes,
  });
}

class AddElection extends UseCase<void, AddElectionParams> {
  ElectionsRepository repository;

  AddElection({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(AddElectionParams params) async {
    return repository.createElection(
      name: params.name,
      description: params.description,
      minimumAge: params.minimumAge,
      date: params.date,
      votingTimeInMinutes: params.maximumVotingTimeInMinutes,
    );
  }
}

final addElectionUseCaseProvider = Provider<AddElection>((ref) {
  final repository = ref.read(electionsRepositoryProvider);
  return AddElection(
    repository: repository,
  );
});
