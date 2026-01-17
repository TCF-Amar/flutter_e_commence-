import 'package:flutter_commerce/features/dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

class DashDependencies {
  static void dependencies() {
    Get.put(DashboardController());
  }
}
