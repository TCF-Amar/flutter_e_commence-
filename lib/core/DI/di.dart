import 'package:flutter_commerce/core/controllers/theme_controller.dart';
import 'package:flutter_commerce/core/network/dio_client.dart';
import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:flutter_commerce/features/auth/presentation/dependencies/auth_dependencies.dart';
import 'package:flutter_commerce/features/dashboard/dependencies/dash_dependencies.dart';
import 'package:flutter_commerce/features/home/dependencies/home_dependencies.dart';
import 'package:flutter_commerce/features/product/presentation/dependencies/product_dependencies.dart';
import 'package:flutter_commerce/features/splash/controllers/splash_controller.dart';
import 'package:get/instance_manager.dart';

/// Main Dependency Injection orchestrator
/// Initializes all core services and feature-specific dependencies
class DependenciesInjection {
  DependenciesInjection() {
    // Core Services - Always available
    Get.put(ThemeController(), permanent: true);
    Get.put(DioClient(), permanent: true);
    Get.put(DioHelper(Get.find<DioClient>().dio), permanent: true);
    Get.put(SplashController());

    // Feature-specific Dependencies
    DashDependencies.dependencies();
    AuthDependencies.dependencies();
    ProductDependencies.dependencies();
    HomeDependencies.dependencies();
  }
}
