import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:solutech_votify/features/voting/domain/entities/token.dart';

abstract class VotingRepository {
  Future<Either<Failure, Token>> startVoting(
    String tokenValue,
  );

  Future<Either<Failure, void>> castVotes(
    int tokenId,
    List<int> candidates,
  );
}
