import 'package:flutter_commerce/core/DI/auth_di.dart';
import 'package:flutter_commerce/core/network/dio_client.dart';
import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:get/instance_manager.dart';

class AppDI {
  static void init() {
    Get.put(DioClient(), permanent: true);

    Get.put(DioHelper(Get.find<DioClient>().dio), permanent: true);

    AuthDi.inject();
  }
}
