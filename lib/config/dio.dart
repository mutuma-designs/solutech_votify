import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/data/interceptors/auth_interceptor.dart';
import 'constants.dart';

final dioProvider = Provider<Dio>((ref) {
  final authInterceptor = ref.read(authInterceptorProvider);
  final dio = Dio();
  dio.options.baseUrl = apiUrl;
  dio.interceptors.add(authInterceptor);
  dio.interceptors.add(LogInterceptor(
    request: true,
    responseBody: true,
    requestBody: true,
    requestHeader: true,
    responseHeader: true,
    error: true,
  ));
  return dio;
});
