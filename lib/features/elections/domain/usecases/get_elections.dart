import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/elections_repository_impl.dart';
import '../entities/election.dart';
import '../repositories/elections_repository.dart';

class GetElections extends NoParamsUseCase<List<Election>> {
  ElectionsRepository repository;

  GetElections({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Election>>> call() async {
    return repository.getElections();
  }
}

final getElectionsUseCaseProvider = Provider<GetElections>((ref) {
  final repository = ref.read(electionsRepositoryProvider);
  return GetElections(
    repository: repository,
  );
});
