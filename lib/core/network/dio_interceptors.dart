import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(' ${options.method} ${options.uri}');
      if (options.headers.isNotEmpty) {
        debugPrint('Headers: ${options.headers}');
      }
      if (options.data != null) {
        debugPrint('Body: ${options.data}');
      }
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('${response.statusCode} ${response.requestOptions.uri}');
      debugPrint('Response: ${response.data}');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        'Error ${err.response?.statusCode ?? 'N/A'} ${err.requestOptions.uri}',
      );
      debugPrint(' Message: ${err.message}');
      if (err.response?.data != null) {
        debugPrint('Error Data: ${err.response?.data}');
      }
    }

    handler.next(err);
  }
}
