import 'package:flutter_commerce/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_commerce/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_commerce/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_commerce/features/auth/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthDi {
  static void inject() {
    Get.lazyPut<AuthRemoteDatasource>(() => AuthRemoteDatasource(Get.find()));

    Get.lazyPut(() => AuthRepositoryImpl(Get.find()));

    Get.lazyPut(() => LoginUsecase(Get.find()));

    Get.lazyPut(() => AuthController(Get.find()));
  }
}
