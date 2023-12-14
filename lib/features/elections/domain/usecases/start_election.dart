import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/elections_repository_impl.dart';
import '../repositories/elections_repository.dart';

class StartElectionParams {
  int electionId;
  StartElectionParams({
    required this.electionId,
  });
}

class StartElection extends UseCase<void, StartElectionParams> {
  ElectionsRepository repository;

  StartElection({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(StartElectionParams params) async {
    return repository.startElection(
      params.electionId,
    );
  }
}

final startElectionUseCaseProvider = Provider<StartElection>((ref) {
  final repository = ref.read(electionsRepositoryProvider);
  return StartElection(
    repository: repository,
  );
});
