import 'package:flutter_commerce/modules/home/home_controller.dart';
import 'package:get/get.dart';

class HomeDI extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
