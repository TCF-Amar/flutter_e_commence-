import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:flutter_commerce/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_commerce/features/product/data/datasources/product_remote_datasource_impl.dart';
import 'package:flutter_commerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:flutter_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:flutter_commerce/features/product/domain/usecases/get_categories_usecase.dart';
import 'package:flutter_commerce/features/product/domain/usecases/get_products_usecase.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_controller.dart';
import 'package:get/get.dart';

/// Dependency injection for Product feature
class ProductDi {
  static void init() {
    // Data sources
    Get.lazyPut<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(Get.find<DioHelper>()),
    );

    // Repositories
    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl(Get.find()));

    // Use cases
    Get.lazyPut(() => GetProductsUseCase(Get.find()));
    Get.lazyPut(() => GetCategoriesUseCase(Get.find()));

    // Controllers
    Get.put(
      ProductController(
        getProductsUseCase: Get.find(),
        getCategoriesUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
