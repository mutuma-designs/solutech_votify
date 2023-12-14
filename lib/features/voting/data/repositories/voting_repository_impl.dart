import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/voting/data/mappers/token.dart';

import '../../domain/entities/token.dart';
import '../../domain/repositories/voting_repository.dart';
import '../datasources/voting_remote_datasource.dart';

class VotingRepositoryImpl extends VotingRepository {
  final VotingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  VotingRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Token>> startVoting(String tokenValue) async {
    return handleExceptions(() async {
      final token = await remoteDataSource.startVoting(tokenValue);
      return token.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> castVotes(int tokenId, List<int> candidates) {
    return handleExceptions(() async {
      final result = await remoteDataSource.castVotes(tokenId, candidates);
      return result;
    });
  }
}

final votingRepositoryProvider = Provider<VotingRepository>((ref) {
  final remoteDataSource = ref.read(votingRemoteDataSourceProvider);
  final networkInfo = ref.read(networkInfoProvider);
  return VotingRepositoryImpl(
    remoteDataSource: remoteDataSource,
    networkInfo: networkInfo,
  );
});
