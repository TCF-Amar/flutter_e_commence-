import 'package:dio/dio.dart';
import 'package:flutter_commerce/core/environment/environment.dart';
import 'package:flutter_commerce/core/network/dio_interceptors.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: Environment.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
        validateStatus: (status) => status != null && status < 500,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add interceptors for logging and error handling
    dio.interceptors.add(DioInterceptors());
  }

  /// Reset the Dio instance (useful for testing)
  void reset() {
    dio.interceptors.clear();
    dio.interceptors.add(DioInterceptors());
  }
}
