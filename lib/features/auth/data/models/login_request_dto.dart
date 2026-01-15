import 'package:flutter_commerce/features/auth/domain/entities/login_credentials.dart';

/// DTO for login request
class LoginRequestDto {
  final String username;
  final String password;

  const LoginRequestDto({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }

  /// Create DTO from domain entity
  factory LoginRequestDto.fromEntity(LoginCredentials credentials) {
    return LoginRequestDto(
      username: credentials.username,
      password: credentials.password,
    );
  }
}
