import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/elections_repository_impl.dart';
import '../repositories/elections_repository.dart';

class DeleteElectionParams {
  int electionId;
  DeleteElectionParams({
    required this.electionId,
  });
}

class DeleteElection extends UseCase<void, DeleteElectionParams> {
  ElectionsRepository repository;

  DeleteElection({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(DeleteElectionParams params) async {
    return repository.deleteElection(
      params.electionId,
    );
  }
}

final deleteElectionUseCaseProvider = Provider<DeleteElection>((ref) {
  final repository = ref.read(electionsRepositoryProvider);
  return DeleteElection(
    repository: repository,
  );
});
