import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/verification.dart';

abstract class VerificationRepository {
  Future<Either<Failure, Verification>> verifyVoter({
    required int electionId,
    required String uniqueId,
  });
}
