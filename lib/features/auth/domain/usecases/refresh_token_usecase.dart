import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/auth/domain/entities/login_response.dart';
import 'package:flutter_commerce/features/auth/domain/repositories/auth_repository.dart';

/// Use case for refreshing access token using refresh token
class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  /// Refresh the access token using the refresh token
  /// Returns Either<Failure, LoginResponse> with new tokens
  Future<Either<Failure, LoginResponse>> call(String refreshToken) async {
    return await repository.refreshToken(refreshToken);
  }
}


/*
feat: implement automatic token refresh mechanism

Implemented automatic token refresh to handle expired access tokens seamlessly
using refresh tokens, keeping users logged in without requiring re-authentication.

Changes:
- Created RefreshTokenUseCase in domain layer
  * Takes refresh token as input
  * Returns Either<Failure, LoginResponse> with new tokens

- Added refresh token endpoint to API configuration
  * Added /auth/refresh-token endpoint constant

- Implemented refresh token in data layer
  * Added refreshToken() method to AuthRemoteDataSource interface
  * Implemented refreshToken() in AuthRemoteDataSourceImpl
  * Added refreshToken() to AuthRepository interface
  * Implemented refreshToken() in AuthRepositoryImpl with error handling

- Updated AuthController with automatic refresh logic
  * Added RefreshTokenUseCase dependency
  * Implemented refreshAccessToken() method
  * Modified checkSession() to automatically refresh when access token expires
  * Handles refresh token expiration by logging out user
  * Removed debug print statements for cleaner logs

- Updated dependency injection
  * Registered RefreshTokenUseCase in AuthDependencies
  * Injected into AuthController

- Added comprehensive test coverage
  * Test for successful token refresh
  * Test for refresh token failure
  * Test for exception handling during refresh

Token Refresh Flow:
1. On app start, checkSession() verifies token expiration
2. If access token expired but refresh token valid, automatically refreshes
3. New tokens are stored and user data is fetched
4. If refresh token also expired, user is logged out
5. All handled seamlessly in background without user intervention

This ensures users remain logged in as long as their refresh token is valid,
improving user experience while maintaining security.
 */