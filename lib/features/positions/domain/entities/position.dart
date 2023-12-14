import 'package:equatable/equatable.dart';

import '../../../candidates/domain/entities/candidates.dart';

class Position extends Equatable {
  final int id;
  final String name;
  final int maxSelections;
  final String description;
  final List<Candidate> candidates;

  const Position({
    required this.id,
    required this.name,
    required this.maxSelections,
    required this.description,
    required this.candidates,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        maxSelections,
        description,
        candidates,
      ];
}
