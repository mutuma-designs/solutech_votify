import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/dio.dart';
import '../models/auth_data_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthDataModel> loginWithPhoneNumber(
    String phoneNumber,
    String password,
  );

  Future<void> setUpAccount({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  Dio dio;
  NetworkInfo networkInfo;
  AuthRemoteDataSourceImpl({required this.dio, required this.networkInfo});

  @override
  Future<AuthDataModel> loginWithPhoneNumber(
    String phoneNumber,
    String password,
  ) async {
    return handleErrors(() async {
      Map<String, dynamic> data = {
        "email": phoneNumber,
        "password": password,
      };

      var response = await dio.post("/login", data: data);

      AuthDataModel authData = AuthDataModel.fromMap(response.data["data"]);

      return authData;
    });
  }

  @override
  Future<void> setUpAccount({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return handleErrors(() async {
      Map<String, dynamic> data = {
        "fullName": fullName,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      };

      await dio.post("/setup", data: data);
    });
  }
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  var dio = ref.watch(dioProvider);
  return AuthRemoteDataSourceImpl(
    dio: dio,
    networkInfo: ref.watch(networkInfoProvider),
  );
});
