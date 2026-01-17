import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/features/auth/domain/entities/login_credentials.dart';
import 'package:flutter_commerce/features/auth/domain/entities/login_response.dart';
import 'package:flutter_commerce/features/auth/domain/entities/user.dart';

/// Abstract repository interface for authentication operations
/// This defines the contract that data layer must implement
abstract class AuthRepository {
  /// Authenticate user with credentials
  Future<Either<Failure, LoginResponse>> login(LoginCredentials credentials);

  /// Fetch user details by ID
  /// Returns Either<Failure, User>
  Future<Either<Failure, User>> getLoginUser(String accessToken);

  /// Logout current user
  // Future<Either<Failure, void>> logout();
}
