import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/elections_repository_impl.dart';
import '../repositories/elections_repository.dart';

class EndElectionParams {
  int electionId;
  EndElectionParams({
    required this.electionId,
  });
}

class EndElection extends UseCase<void, EndElectionParams> {
  ElectionsRepository repository;

  EndElection({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(EndElectionParams params) async {
    return repository.endElection(
      params.electionId,
    );
  }
}

final endElectionUseCaseProvider = Provider<EndElection>((ref) {
  final repository = ref.read(electionsRepositoryProvider);
  return EndElection(
    repository: repository,
  );
});
