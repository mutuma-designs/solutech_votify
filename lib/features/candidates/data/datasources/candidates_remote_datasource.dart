import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/dio.dart';

abstract class CandidatesRemoteDataSource {
  Future<void> addCandidate(int userId, int positionId);
  Future<void> deleteCandidate(int candidateId);
}

class CandidatesRemoteDataSourceImpl implements CandidatesRemoteDataSource {
  final Dio dio;

  CandidatesRemoteDataSourceImpl(this.dio);

  @override
  Future<void> addCandidate(int userId, int positionId) async {
    return handleErrors(() async {
      await dio.post(
        '/candidates',
        data: {
          'userId': userId,
          'positionId': positionId,
        },
      );
    });
  }

  @override
  Future<void> deleteCandidate(int candidateId) async {
    return handleErrors(() async {
      await dio.delete(
        '/candidates/$candidateId',
      );
    });
  }
}

final candidatesRemoteDataSourceProvider =
    Provider.autoDispose<CandidatesRemoteDataSource>(
  (ref) => CandidatesRemoteDataSourceImpl(
    ref.watch(dioProvider),
  ),
);
