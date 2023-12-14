import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/dio.dart';
import '../models/verification_model.dart';

abstract class VerificationRemoteDataSource {
  Future<VerificationModel> verifyVoter({
    required int electionId,
    required String uniqueId,
  });
}

class VerificationRemoteDataSourceImpl extends VerificationRemoteDataSource {
  final Dio dio;

  VerificationRemoteDataSourceImpl({required this.dio});

  @override
  Future<VerificationModel> verifyVoter({
    required int electionId,
    required String uniqueId,
  }) async {
    return handleErrors(() async {
      var response = await dio.post(
        "/verification",
        data: {
          "electionId": electionId,
          "uniqueId": uniqueId,
        },
      );
      return VerificationModel.fromMap(response.data);
    });
  }
}

final verificationRemoteDataSourceProvider =
    Provider<VerificationRemoteDataSource>((ref) {
  return VerificationRemoteDataSourceImpl(
    dio: ref.watch(dioProvider),
  );
});
