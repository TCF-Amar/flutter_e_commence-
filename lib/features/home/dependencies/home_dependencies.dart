import 'package:flutter_commerce/features/home/controllers/home_controller.dart';
import 'package:get/get.dart';

/// Dependency injection for Home feature
/// Initializes all home-related controllers and dependencies
class HomeDependencies {
  static void dependencies() {
    Get.put(HomeController());
  }
}
