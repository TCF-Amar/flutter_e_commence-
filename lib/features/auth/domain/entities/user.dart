import 'package:flutter_commerce/features/auth/domain/entities/address.dart';

class User {
  final int id;
  final String email;
  final String username;
  final String phone;
  final Name name;
  final Address address;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.phone,
    required this.name,
    required this.address,
  });
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
