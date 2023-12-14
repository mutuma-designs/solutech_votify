import 'package:hive_flutter/hive_flutter.dart';

import '../../../candidates/data/models/candidate_model.dart';

part 'position_model.g.dart';

@HiveType(typeId: 4)
class PositionModel {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final int maxSelections;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final List<CandidateModel> candidates;

  PositionModel({
    required this.id,
    required this.name,
    required this.maxSelections,
    required this.description,
    required this.candidates,
  });

  factory PositionModel.fromMap(Map<String, dynamic> json) => PositionModel(
        id: json["id"],
        name: json["name"],
        maxSelections: json["maxSelections"],
        description: json["description"],
        candidates: List<CandidateModel>.from(
            json["candidates"].map((x) => CandidateModel.fromMap(x))),
      );
}
