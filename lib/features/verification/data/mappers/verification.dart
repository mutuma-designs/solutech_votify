import 'package:solutech_votify/features/users/data/mappers/user.dart';

import '../../domain/entities/verification.dart';
import '../models/verification_model.dart';

extension VerificationX on VerificationModel {
  Verification toEntity() {
    return Verification(
      user: user.toEntity(),
      verificationResult: verificationResult.toEntity(),
    );
  }
}

extension VerificationResultX on VerificationResultModel {
  VerificationResult toEntity() {
    return VerificationResult(
      canVote: canVote,
      reason: reason,
      token: token,
      expiration: expiration,
    );
  }
}

extension VerificationResultEntityX on VerificationResult {
  VerificationResultModel toModel() {
    return VerificationResultModel(
      canVote: canVote,
      reason: reason,
      token: token,
      expiration: expiration,
    );
  }
}

extension VerificationEntityX on Verification {
  VerificationModel toModel() {
    return VerificationModel(
      user: user.toModel(),
      verificationResult: verificationResult.toModel(),
    );
  }
}
