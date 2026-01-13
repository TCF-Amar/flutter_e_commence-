import 'package:flutter_commerce/features/auth/data/models/address_model.dart';
import 'package:flutter_commerce/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.username,
    required super.phone,
    required super.name,
    required super.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
      name: Name.fromJson(json['name'] ?? {}),
      address: AddressModel.fromJson(json['address'] ?? {}),
    );
  }
}
