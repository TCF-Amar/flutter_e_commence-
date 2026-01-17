import 'package:flutter_commerce/features/auth/domain/entities/login_credentials.dart';

/// DTO for login request
class LoginRequestDto {
  final String email;
  final String password;

  const LoginRequestDto({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  /// Create DTO from domain entity
  factory LoginRequestDto.fromEntity(LoginCredentials credentials) {
    return LoginRequestDto(
      email: credentials.email,
      password: credentials.password,
    );
  }
}
