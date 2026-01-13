import 'package:get/get.dart';

import 'package:flutter_commerce/data/models/product_model.dart';
import 'package:flutter_commerce/data/repositories/product_repository.dart';

class ProductController extends GetxController {
  /// 🔹 Reactive product list
  final RxList<ProductModel> products = <ProductModel>[].obs;

  /// 🔹 Reactive category count map
  final RxMap<String, List<ProductModel>> categoryMap =
      <String, List<ProductModel>>{}.obs;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();

    // Set up reactive listener first
    ever<List<ProductModel>>(products, (_) {
      createCategoryMap();
    });

    // Then load products
    getProducts();
  }

  Future<void> getProducts() async {
    try {
      _isLoading.value = true;
      final result = await ProductRepository().getProducts();

      result.fold(
        (l) {
          products.clear();
        },
        (r) {
          products.assignAll(r);
          createCategoryMap();
        },
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  void createCategoryMap() {
    categoryMap.clear();
    for (final product in products) {
      categoryMap[product.category] = (categoryMap[product.category] ?? [])
        ..add(product);
    }
  }
}
