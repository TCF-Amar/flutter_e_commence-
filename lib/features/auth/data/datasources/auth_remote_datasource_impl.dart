import 'package:flutter_commerce/core/network/api_end_points.dart';
import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:flutter_commerce/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_commerce/features/auth/data/models/login_request_dto.dart';
import 'package:flutter_commerce/features/auth/data/models/login_response_dto.dart';
import 'package:flutter_commerce/features/auth/data/models/user_dto.dart';

/// Implementation of AuthRemoteDataSource using Dio
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioHelper dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<LoginResponseDto> login(LoginRequestDto request) async {
    final response = await dio.post(ApiEndpoints.login, body: request);

    if (response.data == null) {
      throw Exception('Login response is null');
    }

    return LoginResponseDto.fromJson(response.data);
  }

  @override
  Future<UserDto> getUserById(int userId) async {
    final response = await dio.get(ApiEndpoints.userById(userId));

    if (response.data == null) {
      throw Exception('User data is null');
    }

    return UserDto.fromJson(response.data);
  }
}
