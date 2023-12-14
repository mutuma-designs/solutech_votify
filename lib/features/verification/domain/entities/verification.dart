import '../../../users/domain/entities/user.dart';

class Verification {
  final User user;
  final VerificationResult verificationResult;

  Verification({
    required this.user,
    required this.verificationResult,
  });
}

class VerificationResult {
  final bool canVote;
  final String reason;
  final String? token;
  final DateTime? expiration;

  VerificationResult({
    required this.canVote,
    required this.reason,
    this.token,
    this.expiration,
  });
}
