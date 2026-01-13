import 'package:flutter_commerce/features/auth/domain/entities/auth_token.dart';

class LoginResponseModel extends AuthToken {
  LoginResponseModel({required super.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(token: json['token']);
  }
}
