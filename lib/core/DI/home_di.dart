import 'package:flutter_commerce/features/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeDi {
  static void init() {
    Get.put(HomeController());
  }
}
