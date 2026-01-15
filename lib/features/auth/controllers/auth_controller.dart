import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/jwt/jwt.dart';
import 'package:flutter_commerce/core/routes/app_routes.dart';
import 'package:flutter_commerce/core/storage/app_storage.dart';
import 'package:flutter_commerce/core/widgets/app_snackbar.dart';
import 'package:flutter_commerce/features/auth/models/user_model.dart';
import 'package:flutter_commerce/features/auth/repositories/auth_repository.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthController extends GetxController {
  //* AppStorage
  final AppStorage storage = Get.find<AppStorage>();

  //* AuthRepository
  AuthRepository repo = Get.find<AuthRepository>();

  //* GlobalKey<FormState>
  final formKey = GlobalKey<FormState>();
  //* TextEditingController
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //* isLoading
  final isLoading = false.obs;

  //* Rxn<UserModel>
  final Rxn<UserModel> _user = Rxn<UserModel>();
  UserModel? get user => _user.value;

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
      final result = await repo.login(username, password);
      result.fold(
        (l) {
          isLoading.value = false;
          AppSnackbar.error(message: l.message);
        },
        (r) {
          isLoading.value = false;
          storage.setToken(r.token);
          storage.setIsLoggedIn(true);
          AppSnackbar.success(message: "Login successful");
          checkSession();
          usernameController.clear();
          passwordController.clear();

          //* Navigate to home page after successful login
          if (context.mounted) {
            context.go(AppRoutes.dashboard.path);
          }
        },
      );
    }
  }

  //* fetchLoginUser
  Future<void> fetchLoginUser(int id) async {
    final result = await repo.fetchLoginUser(id);
    result.fold(
      (l) {
        AppSnackbar.error(message: l.message);
      },
      (r) {
        _user.value = r;
      },
    );
  }

  //* Logout User
  Future<void> logout() async {
    storage.clear();
    //? if backend provide logout api then call it
    //! await repo.logout();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}
