import 'package:flutter_commerce/features/auth/domain/entities/address.dart';

/// Domain entity representing a user
/// Pure Dart class with no external dependencies
class User {
  final int id;
  final String email;
  final String username;
  final String phone;
  final String firstname;
  final String lastname;
  final Address address;

  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.phone,
    required this.firstname,
    required this.lastname,
    required this.address,
  });

  User copyWith({
    int? id,
    String? email,
    String? username,
    String? phone,
    String? firstname,
    String? lastname,
    Address? address,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      address: address ?? this.address,
    );
  }

  String get fullName => '$firstname $lastname';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.email == email &&
        other.username == username &&
        other.phone == phone &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        username.hashCode ^
        phone.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        address.hashCode;
  }
}
