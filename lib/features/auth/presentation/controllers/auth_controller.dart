import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/jwt/jwt.dart';
import 'package:flutter_commerce/core/routes/app_routes.dart';
import 'package:flutter_commerce/core/storage/app_storage.dart';
import 'package:flutter_commerce/core/widgets/app_snackbar.dart';
import 'package:flutter_commerce/features/auth/domain/entities/login_credentials.dart';
import 'package:flutter_commerce/features/auth/domain/entities/user.dart';
import 'package:flutter_commerce/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:flutter_commerce/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_commerce/features/auth/domain/usecases/logout_usecase.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthController extends GetxController {
  //* Use Cases
  final LoginUseCase loginUseCase;
  final GetUserUseCase getUserUseCase;
  final LogoutUseCase logoutUseCase;

  //* AppStorage
  final AppStorage storage;

  AuthController({
    required this.loginUseCase,
    required this.getUserUseCase,
    required this.logoutUseCase,
    required this.storage,
  });

  //* GlobalKey<FormState>
  final formKey = GlobalKey<FormState>();

  //* TextEditingController
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //* isLoading
  final isLoading = false.obs;

  //* Rxn<User>
  final Rxn<User> _user = Rxn<User>();
  User? get user => _user.value;

  //* onReady if token is not empty then check session
  @override
  void onReady() {
    super.onReady();
    ever(storage.token, (_) {
      if (storage.token.isNotEmpty) {
        checkSession();
      }
    });
    if (storage.token.value.isNotEmpty) {
      checkSession();
    }
  }

  //* Check user logged in or not
  void checkSession() async {
    final token = storage.token.value;
    final isLoggedIn = storage.isLoggedIn.value;
    debugPrint("token: $token");

    //* Only check expiration if we have a valid token
    if (token.isNotEmpty && isLoggedIn) {
      final isExpired = Jwt.isExpired(token);
      debugPrint("Token expired: $isExpired");
      if (isExpired) {
        debugPrint("Clearing expired session");
        storage.clear();
      } else {
        final decoded = Jwt.decodeToken(token);
        debugPrint("decoded: ${decoded?["sub"]}");
        await fetchLoginUser(decoded?["sub"]);
      }
    } else if (token.isEmpty && isLoggedIn) {
      //* If logged in but no token, clear the session
      debugPrint("No token found, clearing session");
      storage.clear();
    }
  }

  //* Login User
  Future<void> login(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      // Create credentials entity
      final credentials = LoginCredentials(
        username: username,
        password: password,
      );

      // Call login use case
      final result = await loginUseCase(credentials);

      result.fold(
        (failure) {
          isLoading.value = false;
          AppSnackbar.error(message: failure.message);
        },
        (token) {
          isLoading.value = false;
          storage.setToken(token);
          storage.setIsLoggedIn(true);
          AppSnackbar.success(message: "Login successful");
          checkSession();
          usernameController.clear();
          passwordController.clear();

          //* Navigate to dashboard after successful login
          if (context.mounted) {
            context.go(AppRoutes.dashboard.path);
          }
        },
      );
    }
  }

  //* fetchLoginUser
  Future<void> fetchLoginUser(int id) async {
    final result = await getUserUseCase(id);
    result.fold(
      (failure) {
        AppSnackbar.error(message: failure.message);
      },
      (user) {
        _user.value = user;
      },
    );
  }

  //* Logout User
  Future<void> logout() async {
    await logoutUseCase();
    storage.clear();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}
