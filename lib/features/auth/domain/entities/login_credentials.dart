/// Domain entity representing login credentials
class LoginCredentials {
  final String username;
  final String password;

  const LoginCredentials({required this.username, required this.password});

  bool get isValid => username.isNotEmpty && password.isNotEmpty;
}
