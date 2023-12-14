import 'package:solutech_votify/features/users/data/mappers/user.dart';

import '../../domain/entities/candidates.dart';
import '../models/candidate_model.dart';

extension CandidateModelX on CandidateModel {
  Candidate toEntity() {
    return Candidate(
      id: id,
      user: user.toEntity(),
    );
  }
}

extension CandidateX on Candidate {
  CandidateModel toModel() {
    return CandidateModel(
      id: id,
      user: user.toModel(),
    );
  }
}
