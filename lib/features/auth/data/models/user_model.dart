import 'package:flutter_commerce/features/auth/domain/entities/user.dart';

/// Data Transfer Object for User
/// Handles JSON serialization/deserialization and conversion to/from domain entity
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.role,
    required super.password,
    required super.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      password: json['password'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'password': password,
      'avatar': avatar,
    };
  }

  /// Convert DTO to domain entity
  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      role: role,
      password: password,
      avatar: avatar,
    );
  }

  /// Create DTO from domain entity
  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      role: entity.role,
      password: entity.password,
      avatar: entity.avatar,
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
