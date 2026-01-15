import 'package:get/get.dart';
import 'package:flutter_commerce/features/dashboard/controllers/dashboard_controller.dart';

class DashBoardDi {
  static void init() {
    Get.put(DashboardController());
  }
}
