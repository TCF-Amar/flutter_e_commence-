
/// Domain entity representing a user
/// Pure Dart class with no external dependencies
class User {
  final int id;
  final String name;
  final String role;
  final String email;
  final String password;

  final String? avatar;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.password,
    required this.avatar,
  });

  User copyWith({
    int? id,
    String? email,
    String? name,
    String? role,
    String? password,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
    );
  }
}
