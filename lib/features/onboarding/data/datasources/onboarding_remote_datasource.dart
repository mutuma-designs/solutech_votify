import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/config/dio.dart';

abstract class OnboardingRemoteDatasource {
  Future<bool> getOnboardingStatus();
}

class OnboardingRemoteDataSourceImpl implements OnboardingRemoteDatasource {
  Dio dio;
  OnboardingRemoteDataSourceImpl(this.dio);

  @override
  Future<bool> getOnboardingStatus() async {
    return handleErrors(() async {
      final response = await dio.get(
        "/setup",
      );
      return response.data["completed"] ?? false;
    });
  }
}

final onboardingRemoteDatasourceProvider =
    Provider.autoDispose<OnboardingRemoteDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return OnboardingRemoteDataSourceImpl(dio);
});
