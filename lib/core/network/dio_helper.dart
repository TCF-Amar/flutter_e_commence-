import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum ApiMethod { get, post, put, delete, patch }

class DioHelper {
  final Dio dio;

  DioHelper(this.dio);

  /// Generic request method
  Future<Response<T>> request<T>({
    required String url,
    required ApiMethod method,
    Map<String, dynamic>? headers,

    Map<String, dynamic>? queryParameters,
    dynamic body,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint('${method.name.toUpperCase()} $url');
        if (queryParameters != null) {
          debugPrint('Query: $queryParameters');
        }
        if (body != null) {
          debugPrint('Body: $body');
        }
      }

      final response = await dio.request<T>(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(method: _mapMethod(method), headers: headers),
      );

      if (kDebugMode) {
        debugPrint('${response.statusCode} $url');
      }

      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('Error on $url: ${e.message}');
      }
      rethrow;
    }
  }

  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return request<T>(
      url: url,
      method: ApiMethod.get,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  /*
  Future<Response<T>> post<T>(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return request<T>(
      url: url,
      method: ApiMethod.post,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<Response<T>> put<T>(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return request<T>(
      url: url,
      method: ApiMethod.put,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<Response<T>> delete<T>(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return request<T>(
      url: url,
      method: ApiMethod.delete,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<Response<T>> patch<T>(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return request<T>(
      url: url,
      method: ApiMethod.patch,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

*/
  static String _mapMethod(ApiMethod method) {
    return method.name.toUpperCase();
  }
}
