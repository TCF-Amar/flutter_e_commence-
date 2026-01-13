import 'package:dio/dio.dart';
import 'package:flutter_commerce/core/error/dio_failure_mapper.dart';
import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_commerce/features/auth/data/models/login_request_model.dart';
import 'package:flutter_commerce/features/auth/domain/entities/auth_token.dart';
import 'package:flutter_commerce/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remote;
  AuthRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, AuthToken>> login(
    String username,
    String password,
  ) async {
    try {
      final token = await remote.login(
        LoginRequestModel(username: username, password: password),
      );
      //* print(response.data);
      //* print(response.data.runtimeType);
      return Right(token as AuthToken);
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    }
  }
}
