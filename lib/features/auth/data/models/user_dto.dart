import 'package:flutter_commerce/features/auth/data/models/address_dto.dart';
import 'package:flutter_commerce/features/auth/domain/entities/user.dart';

/// Data Transfer Object for User
/// Handles JSON serialization/deserialization and conversion to/from domain entity
class UserDto {
  final int id;
  final String email;
  final String username;
  final String phone;
  final NameDto name;
  final AddressDto address;

  const UserDto({
    required this.id,
    required this.email,
    required this.username,
    required this.phone,
    required this.name,
    required this.address,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
      name: NameDto.fromJson(json['name'] ?? {}),
      address: AddressDto.fromJson(json['address'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'phone': phone,
      'name': name.toJson(),
      'address': address.toJson(),
    };
  }

  /// Convert DTO to domain entity
  User toEntity() {
    return User(
      id: id,
      email: email,
      username: username,
      phone: phone,
      firstname: name.firstname,
      lastname: name.lastname,
      address: address.toEntity(),
    );
  }

  /// Create DTO from domain entity
  factory UserDto.fromEntity(User entity) {
    return UserDto(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      phone: entity.phone,
      name: NameDto(firstname: entity.firstname, lastname: entity.lastname),
      address: AddressDto.fromEntity(entity.address),
    );
  }
}

/// DTO for Name nested object
class NameDto {
  final String firstname;
  final String lastname;

  const NameDto({required this.firstname, required this.lastname});

  factory NameDto.fromJson(Map<String, dynamic> json) {
    return NameDto(
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'firstname': firstname, 'lastname': lastname};
  }
}
