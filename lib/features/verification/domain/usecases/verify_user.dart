import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/verification_repository_impl.dart';
import '../entities/verification.dart';
import '../repositories/verification_repository.dart';

class VerifyVoterParams {
  int electionId;
  String uniqueId;
  VerifyVoterParams({
    required this.electionId,
    required this.uniqueId,
  });
}

class VerifyVoter extends UseCase<Verification, VerifyVoterParams> {
  VerificationRepository repository;

  VerifyVoter({
    required this.repository,
  });

  @override
  Future<Either<Failure, Verification>> call(VerifyVoterParams params) async {
    return repository.verifyVoter(
      electionId: params.electionId,
      uniqueId: params.uniqueId,
    );
  }
}

final verifyVoterUseCaseProvider = Provider<VerifyVoter>((ref) {
  final repository = ref.read(verificationRepositoryProvider);
  return VerifyVoter(
    repository: repository,
  );
});
