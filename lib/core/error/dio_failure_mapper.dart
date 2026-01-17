import 'dart:io';
import 'package:dio/dio.dart';
import './failure.dart';

class DioFailureMapper {
  static Failure map(DioException error) {
    final data = error.response?.data;
    final statusCode = error.response?.statusCode;

    //* Backend sent plain string
    if (data is String && data.isNotEmpty) {
      return ServerFailure(data, statusCode: statusCode);
    }

    //* Backend sent JSON message
    if (data is Map<String, dynamic>) {
      if (data['message'] != null) {
        return ServerFailure(
          data['message'].toString(),
          statusCode: statusCode,
        );
      }
      if (data['error'] != null) {
        return ServerFailure(data['error'].toString(), statusCode: statusCode);
      }
    }

    //* No Internet
    if (error.error is SocketException) {
      return const NetworkFailure('No internet connection');
    }

    //* Timeout
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return const TimeoutFailure();
    }

    //* Unauthorized (fallback)
    if (statusCode == 401) {
      return const UnauthorizedFailure();
    }

    //* Other server errors
    if (error.type == DioExceptionType.badResponse) {
      return ServerFailure('Server error', statusCode: statusCode);
    }

    //* Cancel / unknown
    if (error.type == DioExceptionType.cancel) {
      return const NetworkFailure('Request cancelled');
    }

    return UnknownFailure("Something went wrong");
  }
}
