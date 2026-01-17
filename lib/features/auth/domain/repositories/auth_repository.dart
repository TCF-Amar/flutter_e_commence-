import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/features/auth/domain/entities/login_credentials.dart';
import 'package:flutter_commerce/features/auth/domain/entities/login_response.dart';
import 'package:flutter_commerce/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  /// Authenticate user with credentials
  Future<Either<Failure, LoginResponse>> login(LoginCredentials credentials);

  /// Fetch user details by ID
  Future<Either<Failure, User>> getLoginUser(String accessToken);

  /// Refresh access token using refresh token
  Future<Either<Failure, LoginResponse>> refreshToken(String refreshToken);

  
}
