/// Domain entity representing login credentials
class LoginCredentials {
  final String email;
  final String password;

  const LoginCredentials({required this.email, required this.password});

  bool get isValid => email.isNotEmpty && password.isNotEmpty;
}
