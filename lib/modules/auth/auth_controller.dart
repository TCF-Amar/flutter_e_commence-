import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/jwt/jwt.dart';
import 'package:flutter_commerce/core/routes/app_routes.dart';
import 'package:flutter_commerce/core/storage/app_storage.dart';
// import 'package:flutter_commerce/core/widgets/snackbar_utils.dart';
import 'package:flutter_commerce/core/widgets/app_snackbar.dart';
import 'package:flutter_commerce/data/models/user_model.dart';
import 'package:flutter_commerce/data/repositories/auth_repository.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthController extends GetxController {
  final AppStorage storage = Get.find<AppStorage>();
  final AuthRepository authRepository = AuthRepository();

  AuthController();

  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  final Rxn<UserModel> user = Rxn<UserModel>();

  @override
  void onReady() {
    super.onReady();
    // storage.clear();
    // checkSession();
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
  void checkSession() {
    final token = storage.token.value;
    final isLoggedIn = storage.isLoggedIn.value;
    debugPrint("token: $token");

    // Only check expiration if we have a valid token
    if (token.isNotEmpty && isLoggedIn) {
      final isExpired = Jwt.isExpired(token);
      debugPrint("Token expired: $isExpired");
      if (isExpired) {
        debugPrint("Clearing expired session");
        storage.clear();
      }
    } else if (token.isEmpty && isLoggedIn) {
      // If logged in but no token, clear the session
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
      final result = await authRepository.login(username, password);
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

          // Navigate to home page after successful login
          if (context.mounted) {
            context.go(AppRoutes.home.path);
          }
        },
      );
    }
  }

  void logout() {
    storage.clear();
  }
}
