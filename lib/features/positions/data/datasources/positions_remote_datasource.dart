import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/dio.dart';

abstract class PositionsRemoteDataSource {
  Future<void> createPosition({
    required int electionId,
    required String name,
    required String description,
    required int maxSelections,
  });

  Future<void> updatePosition(
      {required int id,
      required String name,
      required int maxSelections,
      required String description});

  Future<void> deletePosition(int id);
}

class PositionsRemoteDataSourceImpl implements PositionsRemoteDataSource {
  Dio dio;
  PositionsRemoteDataSourceImpl(this.dio);
  @override
  Future<void> createPosition({
    required int electionId,
    required String name,
    required String description,
    required int maxSelections,
  }) async {
    await handleErrors(() {
      return dio.post(
        "/positions",
        data: {
          "electionId": electionId,
          "name": name,
          "description": description,
          "maxSelections": maxSelections,
        },
      );
    });
  }

  @override
  Future<void> deletePosition(int id) async {
    await handleErrors(() {
      return dio.delete("/positions/$id");
    });
  }

  @override
  Future<void> updatePosition(
      {required int id,
      required String name,
      required int maxSelections,
      required String description}) async {
    await handleErrors(() {
      return dio.patch(
        "/positions/$id",
        data: {
          "name": name,
          "description": description,
          "maxSelections": maxSelections,
        },
      );
    });
  }
}

final positionsRemoteDataSourceProvider =
    Provider<PositionsRemoteDataSource>((ref) {
  return PositionsRemoteDataSourceImpl(
    ref.watch(dioProvider),
  );
});
