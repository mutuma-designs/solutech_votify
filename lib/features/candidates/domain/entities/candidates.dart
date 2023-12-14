import 'package:equatable/equatable.dart';

import '../../../users/domain/entities/user.dart';

class Candidate extends Equatable {
  final int id;
  final User user;

  const Candidate({
    required this.id,
    required this.user,
  });

  @override
  List<Object?> get props => [id, user];
}
