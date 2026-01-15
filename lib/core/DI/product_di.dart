import 'package:get/get.dart';
import 'package:flutter_commerce/features/product/controllers/product_controller.dart';
import 'package:flutter_commerce/features/product/repositories/product_repository.dart';

class ProductDi {
  static void init() {
    Get.put(ProductRepository(Get.find()));
    Get.put(ProductController(), permanent: true);
  }
}
