import 'package:dio/dio.dart';
import 'package:flutter_commerce/core/error/dio_failure_mapper.dart';
import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/auth/domain/entities/login_credentials.dart';
import 'package:flutter_commerce/features/auth/domain/entities/login_response.dart';
import 'package:flutter_commerce/features/auth/domain/repositories/auth_repository.dart';

//* Use case for user login
//* Encapsulates business logic for authentication
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  //* Execute login with credentials
  //* Returns auth token on success
  Future<Either<Failure, LoginResponse>> call(
    LoginCredentials credentials,
  ) async {
    //* Validate credentials
    if (!credentials.isValid) {
      return Left(
        DioFailureMapper.map(DioException(requestOptions: RequestOptions())),
      );
    }

    //* Delegate to repository
    return await repository.login(credentials);
  }
}
