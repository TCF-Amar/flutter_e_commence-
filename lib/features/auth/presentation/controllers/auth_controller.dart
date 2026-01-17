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
import 'package:flutter_commerce/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthController extends GetxController {
  //* Use Cases
  final LoginUseCase loginUseCase;
  final GetUserUseCase getUserUseCase;
  final LogoutUseCase logoutUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;

  //* AppStorage
  final AppStorage storage;

  AuthController({
    required this.loginUseCase,
    required this.getUserUseCase,
    required this.logoutUseCase,
    required this.refreshTokenUseCase,
    required this.storage,
  });

  //* GlobalKey<FormState>
  final formKey = GlobalKey<FormState>();

  //* TextEditingController
  final emailController = TextEditingController();
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
    everAll([storage.accessToken, storage.refreshToken], (_) {
      if (storage.accessToken.isNotEmpty && storage.refreshToken.isNotEmpty) {
        checkSession();
      }
      if (storage.accessToken.isEmpty && storage.refreshToken.isEmpty) {
        storage.setIsLoggedIn(false);
      }
    });
  }

  //* Check user logged in or not
  void checkSession() async {
    final accessToken = storage.accessToken.value;
    final refreshToken = storage.refreshToken.value;
    final isLoggedIn = storage.isLoggedIn.value;

    if (accessToken.isNotEmpty && isLoggedIn) {
      final isAccessExpired = Jwt.isExpired(accessToken);
      final isRefreshExpired = Jwt.isExpired(refreshToken);

      if (isRefreshExpired) {
        storage.clear();
      } else if (isAccessExpired) {
        await refreshAccessToken();
      } else {
        await fetchLoginUser(accessToken);
      }
    } else if (accessToken.isEmpty && refreshToken.isEmpty && isLoggedIn) {
      storage.clear();
    }
  }

  //* Login User
  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      // Create credentials entity
      final credentials = LoginCredentials(email: email, password: password);

      // Call login use case
      final result = await loginUseCase(credentials);
      result.fold(
        (failure) {
          isLoading.value = false;
          AppSnackbar.error(message: "$failure");
        },
        (loginResponse) {
          isLoading.value = false;
          storage.setToken(
            loginResponse.accessToken,
            loginResponse.refreshToken,
          );
          storage.setIsLoggedIn(true);
          AppSnackbar.success(message: "Login successful");
          checkSession();
          emailController.clear();
          passwordController.clear();

          //* Navigate to dashboard after successful login
          if (context.mounted) {
            context.go(AppRoutes.dashboard.path);
          }
        },
      );
    }
  }

  //* Refresh access token using refresh token
  Future<void> refreshAccessToken() async {
    final refreshToken = storage.refreshToken.value;

    if (refreshToken.isEmpty) {
      debugPrint("No refresh token available");
      storage.clear();
      return;
    }

    final result = await refreshTokenUseCase(refreshToken);
    result.fold(
      (failure) {
        debugPrint("Token refresh failed: ${failure.message}");
        // Refresh failed, clear session
        storage.clear();
      },
      (loginResponse) {
        debugPrint("Token refreshed successfully");
        // Update tokens in storage
        storage.setToken(loginResponse.accessToken, loginResponse.refreshToken);
        // Fetch user with new token
        fetchLoginUser(loginResponse.accessToken);
      },
    );
  }

  //* fetchLoginUser
  Future<void> fetchLoginUser(String accessToken) async {
    final result = await getUserUseCase(accessToken);
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
    // await logoutUseCase();
    storage.clear();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
