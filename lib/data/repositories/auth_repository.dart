import 'package:dio/dio.dart';
import 'package:flutter_commerce/core/network/dio_client.dart';
// import 'package:flutter_commerce/core/network/api_end_points.dart';
// import 'package:flutter_commerce/data/models/user_model.dart';

import '../../core/error/dio_failure_mapper.dart';
import '../../core/error/failure.dart';
import '../../core/network/dio_helper.dart';
import '../../core/utils/either.dart';
import '../models/login_response.dart';

class AuthRepository {
  final DioHelper dioHelper = DioHelper(DioClient().dio);
  AuthRepository();
  Future<Either<Failure, LoginResponse>> login(
    String username,
    String password,
  ) async {
    try {
      final response = await dioHelper.request<Map<String, dynamic>>(
        url: '/auth/login',
        method: ApiMethod.post,
        body: {'username': username, 'password': password},
      );
      // print(response.data);
      // print(response.data.runtimeType);
      if (response.data is Map<String, dynamic>) {
        return Right(
          LoginResponse.fromJson(response.data as Map<String, dynamic>),
        );
      }

      return Left(ServerFailure("Invalid response"));
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    }
  }

  // Future<Either<Failure, void>> logout() async {
  //   try {
  //     final response = await DioHelper.request(
  //       url: '/auth/logout',
  //       method: ApiMethod.post,
  //     );
  //     return Right(null);
  //   } on DioException catch (e) {
  //     return Left(DioFailureMapper.map(e));
  //   }
  // }

  /*
  Future<Either<Failure, UserModel>> getUser(int id) async {
    try {
      final response = await DioHelper.request(
        url: ApiEndpoints.userById(id),
        method: ApiMethod.get,
      );

      return Right(UserModel.fromJson(response.data as Map<String, dynamic>));
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    }
  }
 
  // Future<Either<Failure, List<UserModel>>> getUsers(int limit) async {
  //   try {
  //     final response = await DioHelper.request(
  //       url: ApiEndpoints.users,
  //       method: ApiMethod.get,
  //       queryParameters: {'limit': limit},
  //     );

  //     final List<dynamic> data = response.data as List<dynamic>;

  //     final List<UserModel> users = data
  //         .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
  //         .toList();

  //     return Right(users);
  //   } on DioException catch (e) {
  //     return Left(DioFailureMapper.map(e));
  //   }
  // }
  // */
}
