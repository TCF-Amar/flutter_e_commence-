import 'package:flutter_commerce/features/dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

/// Dependency injection for Dashboard feature
/// Initializes all dashboard-related controllers and dependencies
class DashboardDi {
  static void init() {
    Get.put(DashboardController());
  }
}
