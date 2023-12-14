import 'package:hive/hive.dart';

import '../../../positions/data/models/position_model.dart';

part 'election_model.g.dart';

@HiveType(typeId: 3)
class ElectionModel {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final DateTime date;
  @HiveField(5)
  final String status;
  @HiveField(6)
  final DateTime? startedAt;
  @HiveField(7)
  final DateTime? endedAt;
  @HiveField(8)
  final int minimumAge;
  @HiveField(9)
  final int votingTimeInMinutes;
  @HiveField(10)
  final DateTime createdAt;
  @HiveField(11)
  final DateTime? updatedAt;
  @HiveField(12)
  final List<PositionModel> positions;

  ElectionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.status,
    required this.startedAt,
    required this.endedAt,
    required this.minimumAge,
    required this.votingTimeInMinutes,
    required this.createdAt,
    required this.updatedAt,
    required this.positions,
  });

  factory ElectionModel.fromMap(Map<String, dynamic> json) => ElectionModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        startedAt: json["startedAt"] != null
            ? DateTime.parse(json["startedAt"])
            : null,
        endedAt:
            json["endedAt"] != null ? DateTime.parse(json["endedAt"]) : null,
        minimumAge: json["minimumAge"],
        votingTimeInMinutes: json["votingTimeInMinutes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        positions: List<PositionModel>.from(
            json["positions"].map((x) => PositionModel.fromMap(x))),
      );
}
