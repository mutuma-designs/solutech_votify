import 'package:hive/hive.dart';

import '../../../users/data/models/user_model.dart';

part 'verification_model.g.dart';

@HiveType(typeId: 6)
class VerificationModel {
  @HiveField(1)
  final UserModel user;
  @HiveField(2)
  final VerificationResultModel verificationResult;

  VerificationModel({
    required this.user,
    required this.verificationResult,
  });

  factory VerificationModel.fromMap(Map<String, dynamic> json) =>
      VerificationModel(
        user: UserModel.fromMap(json["user"]),
        verificationResult:
            VerificationResultModel.fromMap(json["verificationResult"]),
      );
}

@HiveType(typeId: 7)
class VerificationResultModel {
  @HiveField(1)
  final bool canVote;
  @HiveField(2)
  final String reason;
  @HiveField(3)
  final String? token;
  @HiveField(4)
  final DateTime? expiration;

  VerificationResultModel({
    required this.canVote,
    required this.reason,
    required this.token,
    required this.expiration,
  });

  factory VerificationResultModel.fromMap(Map<String, dynamic> json) =>
      VerificationResultModel(
        canVote: json["canVote"],
        reason: json["reason"],
        token: json["token"],
        expiration: json["expiration"] != null
            ? DateTime.parse(json["expiration"])
            : null,
      );
}
