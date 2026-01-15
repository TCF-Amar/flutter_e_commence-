import 'package:flutter_commerce/core/DI/auth_di.dart';
import 'package:flutter_commerce/core/DI/dashboard_di.dart';
import 'package:flutter_commerce/core/DI/home_di.dart';
import 'package:flutter_commerce/core/DI/product_di.dart';
import 'package:flutter_commerce/core/controllers/theme_controller.dart';
import 'package:flutter_commerce/core/network/dio_client.dart';
import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:flutter_commerce/features/splash/controllers/splash_controller.dart';
import 'package:get/instance_manager.dart';

/// Main Dependency Injection orchestrator
/// Initializes all core services and feature-specific dependencies
class AppDI {
  static void init() {
    // Core Services - Always available
    Get.put(ThemeController(), permanent: true);
    Get.put(DioClient(), permanent: true);
    Get.put(DioHelper(Get.find<DioClient>().dio), permanent: true);
    Get.put(SplashController());

    // Feature-specific Dependencies
    DashboardDi.init();
    AuthDi.init();
    ProductDi.init();
    HomeDi.init();
  }
}
