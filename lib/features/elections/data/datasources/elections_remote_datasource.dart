import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/config/dio.dart';

import '../models/election_model.dart';

abstract class ElectionsRemoteDataSource {
  Future<void> createElection({
    required String name,
    required String description,
    required int votingTimeInMinutes,
    required int minimumAge,
    required DateTime date,
  });
  Future<List<ElectionModel>> getElections();
  Future<void> updateElection({
    required int id,
    required String name,
    required String description,
    required DateTime date,
    required int minimumAge,
    required int votingTimeInMinutes,
  });
  Future<void> deleteElection(int id);

  Future<void> startElection(int id);

  Future<void> endElection(int id);
}

class ElectionsRemoteDataSourceImpl implements ElectionsRemoteDataSource {
  Dio dio;
  ElectionsRemoteDataSourceImpl(this.dio);
  @override
  Future<void> createElection({
    required String name,
    required String description,
    required int votingTimeInMinutes,
    required int minimumAge,
    required DateTime date,
  }) async {
    await handleErrors(() {
      return dio.post(
        "/elections",
        data: {
          "name": name,
          "description": description,
          "votingTimeInMinutes": votingTimeInMinutes,
          "minimumAge": minimumAge,
          "date": date.toIso8601String()
        },
      );
    });
  }

  @override
  Future<List<ElectionModel>> getElections() {
    return handleErrors(() async {
      var response = await dio.get("/elections");
      return response.data
          .map<ElectionModel>((election) => ElectionModel.fromMap(election))
          .toList();
    });
  }

  @override
  Future<void> deleteElection(int id) {
    return handleErrors(() async {
      await dio.delete("/elections/$id");
    });
  }

  @override
  Future<void> updateElection({
    required int id,
    required String name,
    required String description,
    required int votingTimeInMinutes,
    required int minimumAge,
    required DateTime date,
  }) async {
    await handleErrors(() {
      return dio.patch(
        "/elections/$id",
        data: {
          "name": name,
          "description": description,
          "votingTimeInMinutes": votingTimeInMinutes,
          "minimumAge": minimumAge,
          "date": date.toString(),
        },
      );
    });
  }

  @override
  Future<void> startElection(int id) {
    return handleErrors(() async {
      await dio.post("/elections/$id/start");
    });
  }

  @override
  Future<void> endElection(int id) {
    return handleErrors(() async {
      await dio.post("/elections/$id/end");
    });
  }
}

final electionsRemoteDataSourceProvider =
    Provider<ElectionsRemoteDataSource>((ref) {
  return ElectionsRemoteDataSourceImpl(
    ref.watch(dioProvider),
  );
});
