import 'package:core/core.dart';

import '../../domain/entities/verification.dart';

abstract class VerificationState {
  const VerificationState();
}

class VerificationInitial extends VerificationState {}

class Verifying extends VerificationState {}

class Verified extends VerificationState {
  final Verification verification;
  Verified(this.verification);
}

class VerificationFailed extends VerificationState {
  final Failure failure;
  VerificationFailed(this.failure);
}
