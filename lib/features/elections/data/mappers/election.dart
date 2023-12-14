import 'package:solutech_votify/features/positions/data/mappers/position.dart';

import '../../domain/entities/election.dart';
import '../models/election_model.dart';

extension ElectionModelX on ElectionModel {
  Election toEntity() => Election(
        id: id,
        name: name,
        description: description,
        date: date,
        startedAt: startedAt,
        endedAt: endedAt,
        minimumAge: minimumAge,
        votingTimeInMinutes: votingTimeInMinutes,
        createdAt: createdAt,
        updatedAt: updatedAt,
        status: status,
        positions: positions.map((e) => e.toEntity()).toList(),
      );
}

extension ExpenseX on Election {
  ElectionModel toModel() => ElectionModel(
        id: id,
        name: name,
        description: description,
        date: date,
        startedAt: startedAt,
        endedAt: endedAt,
        minimumAge: minimumAge,
        votingTimeInMinutes: votingTimeInMinutes,
        createdAt: createdAt,
        updatedAt: updatedAt,
        status: status,
        positions: positions.map((e) => e.toModel()).toList(),
      );
}
