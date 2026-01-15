import 'package:flutter_commerce/features/auth/models/address_model.dart';

class UserModel {
  final int id;
  final String email;
  final String username;
  final String phone;
  final Name name;
  final AddressModel address;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.phone,
    required this.name,
    required this.address,
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

class Name {
  final String firstname;
  final String lastname;

  Name({required this.firstname, required this.lastname});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
    );
  }
}
