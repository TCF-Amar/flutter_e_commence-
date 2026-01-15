import 'package:flutter_commerce/core/DI/auth_di.dart';
import 'package:flutter_commerce/core/DI/dash_board_di.dart';
import 'package:flutter_commerce/core/DI/home_di.dart';
import 'package:flutter_commerce/core/DI/product_di.dart';
import 'package:flutter_commerce/core/network/dio_client.dart';
import 'package:flutter_commerce/core/network/dio_helper.dart';

import 'package:flutter_commerce/features/splash/controllers/splash_controller.dart';
import 'package:get/instance_manager.dart';

class AppDI {
  static void init() {
    Get.put(DioClient(), permanent: true);

    Get.put(DioHelper(Get.find<DioClient>().dio), permanent: true);
    Get.put(SplashController());
    DashBoardDi.init();
    AuthDi.inject();
    ProductDi.init();
    HomeDi.init();
  }
}
