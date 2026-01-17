import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/auth/data/models/login_request_dto.dart';
import 'package:flutter_commerce/features/auth/data/models/login_response_dto.dart';
import 'package:flutter_commerce/features/auth/data/models/user_model.dart';

/// Abstract interface for auth remote data source
abstract class AuthRemoteDataSource {
  /// Login with credentials
  Future<Either<Failure, LoginResponseDto>> login(LoginRequestDto request);

  /// Fetch user by ID
  Future<UserModel> getLoginuser(String accessToken);

  /// Refresh access token using refresh token
  Future<Either<Failure, LoginResponseDto>> refreshToken(String refreshToken);
}
