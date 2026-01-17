import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:flutter_commerce/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:flutter_commerce/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_commerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_commerce/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:flutter_commerce/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_commerce/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_commerce/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:flutter_commerce/features/auth/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

/// Dependency injection for Authentication feature
class AuthDependencies {
  static void dependencies() {
    // Data sources
    Get.lazyPut<AuthRemoteDataSourceImpl>(
      () => AuthRemoteDataSourceImpl(Get.find<DioHelper>()),
    );

    // Repositories
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));

    // Use cases
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => GetUserUseCase(Get.find()));
    Get.lazyPut(() => LogoutUseCase(Get.find()));
    Get.lazyPut(() => RefreshTokenUseCase(Get.find()));

    // Controllers
    Get.lazyPut(
      () => AuthController(
        loginUseCase: Get.find(),
        getUserUseCase: Get.find(),
        logoutUseCase: Get.find(),
        refreshTokenUseCase: Get.find(),
        storage: Get.find(),
      ),
    );
  }
}
