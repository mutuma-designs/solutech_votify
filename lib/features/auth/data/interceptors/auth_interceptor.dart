import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/auth_local_datasource.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource authLocalDataSource;

  AuthInterceptor(this.authLocalDataSource);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = await authLocalDataSource.getToken();
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("AuthInterceptor: onResponse: ${response.data}");
    handler.next(response);
  }
}

final authInterceptorProvider = Provider<AuthInterceptor>((ref) {
  final authLocalDataSource = ref.read(authLocalDataSourceProvider);
  return AuthInterceptor(authLocalDataSource);
});
