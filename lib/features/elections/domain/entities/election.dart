import 'package:equatable/equatable.dart';

import '../../../candidates/domain/entities/candidates.dart';
import '../../../positions/domain/entities/position.dart';

class Election extends Equatable {
  final int id;
  final String name;
  final String description;
  final DateTime date;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final String status;
  final int minimumAge;
  final int votingTimeInMinutes;
  final List<Position> positions;

  bool get isStarted => startedAt != null;
  bool get isEnded => endedAt != null;

  List<Candidate> get candidates {
    List<Candidate> allCandidates = [];
    for (var position in positions) {
      allCandidates.addAll(position.candidates);
    }
    return allCandidates;
  }

  final DateTime createdAt;
  final DateTime? updatedAt;

  const Election({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    this.startedAt,
    this.endedAt,
    required this.status,
    required this.minimumAge,
    required this.votingTimeInMinutes,
    required this.positions,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        startedAt,
        endedAt,
        status,
        minimumAge,
        votingTimeInMinutes,
        positions,
        createdAt,
        updatedAt,
      ];
}
