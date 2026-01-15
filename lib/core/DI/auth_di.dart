import 'package:flutter_commerce/features/auth/repositories/auth_repository.dart';
import 'package:flutter_commerce/features/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthDi {
  static void inject() {
    // Get.lazyPut<AuthRemoteDatasource>(() => AuthRemoteDatasource(Get.find()));
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find()));
    Get.lazyPut(() => AuthController());
  }
}
