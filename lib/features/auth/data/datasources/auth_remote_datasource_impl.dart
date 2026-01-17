import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_commerce/features/auth/data/models/login_request_dto.dart';
import 'package:flutter_commerce/features/auth/data/models/login_response_dto.dart';
import 'package:flutter_commerce/features/auth/data/models/user_model.dart';

/// Implementation of AuthRemoteDataSource using Dio
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioHelper dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, LoginResponseDto>> login(
    LoginRequestDto request,
  ) async {
    final response = await dio.post("/auth/login", body: request.toJson());
    if (response.data == null) {
      throw Exception('Login response is null');
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data is Map<String, dynamic>) {
        return Right(LoginResponseDto.fromJson(response.data));
      } else {
        return Left(ServerFailure('Invalid login response format'));
      }
    } else {
      return Left(
        ServerFailure(response.data['message']?.toString() ?? 'Login failed'),
      );
    }
  }

  @override
  Future<UserModel> getLoginuser(String accessToken) async {
    final response = await dio.get(
      "/auth/profile",
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.data == null) {
      throw Exception('User data is null');
    }

    if (response.data is Map<String, dynamic>) {
      return UserModel.fromJson(response.data);
    }

    throw Exception('Invalid user data format');
  }

  @override
  Future<Either<Failure, LoginResponseDto>> refreshToken(
    String refreshToken,
  ) async {
    final response = await dio.post(
      "/auth/refresh-token",
      body: {"refreshToken": refreshToken},
    );

    if (response.data == null) {
      throw Exception('Refresh token response is null');
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data is Map<String, dynamic>) {
        return Right(LoginResponseDto.fromJson(response.data));
      } else {
        return Left(ServerFailure('Invalid refresh token response format'));
      }
    } else {
      return Left(
        ServerFailure(
          response.data['message']?.toString() ?? 'Token refresh failed',
        ),
      );
    }
  }
}
