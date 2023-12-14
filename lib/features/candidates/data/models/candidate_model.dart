import 'package:hive_flutter/hive_flutter.dart';

import '../../../users/data/models/user_model.dart';

part 'candidate_model.g.dart';

@HiveType(typeId: 5)
class CandidateModel {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final UserModel user;

  CandidateModel({
    required this.id,
    required this.user,
  });

  factory CandidateModel.fromMap(Map<String, dynamic> json) => CandidateModel(
        id: json["id"],
        user: UserModel.fromMap(json["user"]),
      );
}
