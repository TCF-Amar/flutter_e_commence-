import 'package:dio/dio.dart';
import 'package:flutter_commerce/core/error/dio_failure_mapper.dart';
import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/auth/domain/entities/user.dart';
import 'package:flutter_commerce/features/auth/domain/repositories/auth_repository.dart';

/// Use case for fetching user details
class GetUserUseCase {
  final AuthRepository repository;

  GetUserUseCase(this.repository);

  /// Execute get user by ID
  Future<Either<Failure, User>> call(String accessToken) async {
    if (accessToken.isEmpty) {
      return Left(
        DioFailureMapper.map(DioException(requestOptions: RequestOptions())),
      );
    }

    return await repository.getLoginUser(accessToken);
  }
}
