import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/dio.dart';
import '../models/token_model.dart';

abstract class VotingRemoteDataSource {
  Future<TokenModel> startVoting(
    String token,
  );

  Future<void> castVotes(
    int tokenId,
    List<int> candidates,
  );
}

class VotingRemoteDataSourceImpl extends VotingRemoteDataSource {
  final Dio dio;

  VotingRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<void> castVotes(int tokenId, List<int> candidates) async {
    return handleErrors(() async {
      await dio.post(
        "/votes",
        data: {
          "tokenId": tokenId,
          "candidates": candidates,
        },
      );
    });
  }

  @override
  Future<TokenModel> startVoting(String token) async {
    return handleErrors(() async {
      final response = await dio.get(
        "/verification/$token",
      );
      return TokenModel.fromMap(response.data);
    });
  }
}

final votingRemoteDataSourceProvider = Provider<VotingRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return VotingRemoteDataSourceImpl(
    dio: dio,
  );
});
