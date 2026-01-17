import 'package:flutter_commerce/features/auth/domain/entities/login_response.dart';

/// DTO for login response
class LoginResponseDto extends LoginResponse {
  // final String token;

  const LoginResponseDto({
    required super.accessToken,
    required super.refreshToken,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'refresh_token': refreshToken};
  }
}
