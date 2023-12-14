import 'package:solutech_votify/features/candidates/data/mappers/candidate.dart';

import '../../domain/entities/position.dart';
import '../models/position_model.dart';

extension PositionModelX on PositionModel {
  Position toEntity() {
    return Position(
      id: id,
      name: name,
      maxSelections: maxSelections,
      candidates: candidates.map((e) => e.toEntity()).toList(),
      description: description,
    );
  }
}

extension PositionX on Position {
  PositionModel toModel() {
    return PositionModel(
      id: id,
      name: name,
      maxSelections: maxSelections,
      candidates: candidates.map((e) => e.toModel()).toList(),
      description: description,
    );
  }
}
