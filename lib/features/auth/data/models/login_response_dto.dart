/// DTO for login response
class LoginResponseDto {
  final String token;

  const LoginResponseDto({required this.token});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(token: json['token'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}
