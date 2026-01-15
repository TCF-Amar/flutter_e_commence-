import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/widgets/app_snackbar.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';
import 'package:flutter_commerce/features/product/domain/usecases/get_products_usecase.dart';
import 'package:flutter_commerce/features/product/domain/usecases/get_categories_usecase.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  // Use Cases
  final GetProductsUseCase getProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  ProductController({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
  });

  final _products = <Product>[].obs;
  final _filteredProducts = <Product>[].obs;
  final _category = <String>[].obs;
  final isLoading = false.obs;

  List<Product> get products => _products;
  List<String> get categoryList => _category;
  List<Product> get filteredProducts => _filteredProducts;

  @override
  void onInit() {
    super.onInit();
    getProducts();
    getCategories();
  }

  void getProducts() async {
    isLoading.value = true;
    debugPrint('📦 Fetching products...');

    final result = await getProductsUseCase();

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

    final result = await getCategoriesUseCase();

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
