import 'package:dio/dio.dart';
import 'package:flutter_commerce/core/error/dio_failure_mapper.dart';
import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/network/api_end_points.dart';
import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/auth/models/login_request_model.dart';
import 'package:flutter_commerce/features/auth/models/login_response_model.dart';
import 'package:flutter_commerce/features/auth/models/user_model.dart';

class AuthRepository {
  final DioHelper dio;

  AuthRepository(this.dio);
  Future<Either<Failure, LoginResponseModel>> login(
    String username,
    String password,
  ) async {
    try {
      final response = await dio.post(
        ApiEndpoints.login,
        body: LoginRequestModel(username: username, password: password),
      );
      final data = response.data;
      if (data == null) {
        return Left(
          DioFailureMapper.map(DioException(requestOptions: RequestOptions())),
        );
      }

      return Right(LoginResponseModel.fromJson(data));
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    }
  }

  //* fetchLoginUser
  Future<Either<Failure, UserModel>> fetchLoginUser(int id) async {
    try {
      final res = await dio.get(ApiEndpoints.userById(id));
      final data = res.data;
      if (data == null) {
        return Left(
          DioFailureMapper.map(DioException(requestOptions: RequestOptions())),
        );
      }
      return Right(UserModel.fromJson(data));
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    }
  }
}
