import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:flutter_commerce/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_commerce/features/product/data/datasources/product_remote_datasource_impl.dart';
import 'package:flutter_commerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:flutter_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:flutter_commerce/features/product/domain/usecases/product_usecase.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/prodcut_whistle_controller.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_category_controller.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_controller.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_details_controller.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_search_controller.dart';
import 'package:get/get.dart';

class ProductDependencies {
  static void dependencies() {
    Get.lazyPut<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(Get.find<DioHelper>()),
    );

    // Repositories
    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl(Get.find()));

    //? Use cases

    Get.lazyPut(
      () => ProductUsecase(Get.find<ProductRepository>()),
      fenix: true,
    );

    // Controllers
    Get.lazyPut(() => ProductController(Get.find()), fenix: true);
    Get.lazyPut(
      () => ProductCategoryController(Get.find<ProductUsecase>()),
      fenix: true,
    );
    Get.lazyPut(
      () => ProductSearchController(Get.find<ProductUsecase>()),
      fenix: true,
    );
    Get.lazyPut(
      () => ProductDetailsController(Get.find<ProductUsecase>()),
      fenix: true,
    );
    Get.lazyPut(() => ProdcutWhistleController(Get.find()), fenix: true);
  }
}
