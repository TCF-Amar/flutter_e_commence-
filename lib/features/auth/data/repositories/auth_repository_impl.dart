import 'package:dio/dio.dart';
import 'package:flutter_commerce/core/error/dio_failure_mapper.dart';
import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:flutter_commerce/features/auth/data/models/login_request_dto.dart';
import 'package:flutter_commerce/features/auth/domain/entities/login_credentials.dart';
import 'package:flutter_commerce/features/auth/domain/entities/login_response.dart';
import 'package:flutter_commerce/features/auth/domain/entities/user.dart';
import 'package:flutter_commerce/features/auth/domain/repositories/auth_repository.dart';

/// Implementation of AuthRepository
/// Coordinates between data sources and domain layer
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSourceImpl remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginCredentials credentials) async {
    try {
      final requestDto = LoginRequestDto.fromEntity(credentials);
      final result = await remoteDataSource.login(requestDto);

      // result is already Either<Failure, LoginResponseDto>
      return result.fold(
        (failure) => Left(failure),
        (res) => Right(res),
      );
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    } catch (e) {
      return Left(UnknownFailure(e));
    }
  }

  @override
  Future<Either<Failure, User>> getLoginUser(String accessToken) async {
    try {
      final userDto = await remoteDataSource.getLoginuser(accessToken);
      return Right(userDto.toEntity());
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, void>> logout() async {
  //   try {
  //     // Implement logout logic (e.g., clear tokens, call logout endpoint)
  //     return Right(null);
  //   } on DioException catch (e) {
  //     return Left(DioFailureMapper.map(e));
  //   } catch (e) {
  //     return Left(UnknownFailure(e.toString()));
  //   }
  // }
}
