import 'package:flutter_commerce/features/auth/data/models/login_request_dto.dart';
import 'package:flutter_commerce/features/auth/data/models/login_response_dto.dart';
import 'package:flutter_commerce/features/auth/data/models/user_dto.dart';

/// Abstract interface for auth remote data source
abstract class AuthRemoteDataSource {
  /// Login with credentials
  /// Returns LoginResponseDto containing auth token
  Future<LoginResponseDto> login(LoginRequestDto request);

  /// Fetch user by ID
  /// Returns UserDto
  Future<UserDto> getUserById(int userId);
}
