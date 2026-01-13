import 'package:flutter_commerce/modules/auth/auth_controller.dart';
import 'package:flutter_commerce/modules/product/product_controller.dart';
import 'package:get/instance_manager.dart';

class DependenciesInjection {
  static void init() {
    DependenciesInjection.dependencies();
  }

  static void dependencies() {
    Get.put(AuthController());
    Get.put(ProductController(), permanent: true);
  }
}
