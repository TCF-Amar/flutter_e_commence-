import 'package:flutter_commerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_commerce/features/auth/repositories/auth_repository.dart';
import 'package:get/get.dart';

/// Dependency injection for Authentication feature
/// Initializes all auth-related repositories and controllers
class AuthDi {
  static void init() {
    // Get.lazyPut<AuthRemoteDatasource>(() => AuthRemoteDatasource(Get.find()));
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find()));
    Get.lazyPut(() => AuthController());
  }
}
