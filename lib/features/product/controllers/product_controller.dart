import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/widgets/app_snackbar.dart';
import 'package:flutter_commerce/features/product/models/product_model.dart';
import 'package:get/get.dart';
import 'package:flutter_commerce/features/product/repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository repository = Get.find();
  final _products = <ProductModel>[].obs;
  final _filteredProducts = <ProductModel>[].obs;
  final _category = <String>[].obs;
  final isLoading = false.obs;
  final selectedCategory = ''.obs; // Track selected category

  List<ProductModel> get products => _products;
  List<String> get categoryList => _category;
  List<ProductModel> get filteredProducts => _filteredProducts;

  // Get filtered products based on selected category
  void filterProducts() {
    if (selectedCategory.value.isEmpty) {
      _filteredProducts.value = products;
    } else {
      _filteredProducts.value = products
          .where((product) => product.category == selectedCategory.value)
          .toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProducts();
    getCategories();
    filterProducts();
  }

  void getProducts() async {
    isLoading.value = true;
    debugPrint('📦 Fetching products...');

    final result = await repository.getProducts();

    result.fold(
      (failure) {
        isLoading.value = false;
        debugPrint('❌ Error fetching products: ${failure.message}');
        AppSnackbar.error(
          message: 'Failed to load products: ${failure.message}',
        );
      },
      (productList) {
        isLoading.value = false;
        _products.value = productList;
        debugPrint('✅ Successfully fetched ${productList.length} products');
      },
    );
  }

  void getCategories() async {
    debugPrint('📂 Fetching categories...');

    final result = await repository.getCategories();

    result.fold(
      (failure) {
        debugPrint('❌ Error fetching categories: ${failure.message}');
      },
      (categoryList) {
        _category.value = categoryList;
        debugPrint('✅ Successfully fetched ${categoryList.length} categories');
      },
    );
  }
}
