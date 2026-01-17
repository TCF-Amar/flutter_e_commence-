import 'package:flutter/material.dart';
import 'package:flutter_commerce/features/product/domain/entities/category.dart';
import 'package:flutter_commerce/features/product/domain/usecases/product_usecase.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_controller.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';
import 'package:get/get.dart';

/// Controller for managing category screen state and filtering
class ProductCategoryController extends GetxController {
  final ProductUsecase productUsecase;
  ProductCategoryController(this.productUsecase);

  final ProductController productController = Get.find<ProductController>();
  // Changed to RxSet for proper reactive updates
  final selectedCategory = "".obs;
  final _filteredProducts = <Product>[].obs;
  final _isLoading = false.obs;
  List<Category> get categoryList => productController.categoryList;
  List<Product> get allProducts => productController.filteredProducts;
  bool get isLoading => _isLoading.value;
  List<Product> get filteredProducts => _filteredProducts;
  ScrollController get scrollController => productController.scrollController;

  @override
  void onInit() {
    super.onInit();
    // Listen to product changes and update filtered list
    ever(productController.isLoading, (_) {
      if (!productController.isLoading.value) {
        _updateFilteredProducts();
      }
    });

    // Listen to filteredProducts changes (for sorting in ProductController)
    ever(productController.filteredProductsRx, (_) {
      _updateFilteredProducts();
    });

    // Initial filter update
    _updateFilteredProducts();
  }

  /// Initialize with a specific category
  void initializeWithCategory(String? category) {
    if (category != null && category.isNotEmpty) {
      selectedCategory.value = category;
      selectedCategory.refresh(); // Trigger update
      _updateFilteredProducts();
    }
  }

  /// Toggle category selection (add if not selected, remove if selected)
  void toggleCategory(String category) {
    if (selectedCategory.value == category) {
      selectedCategory.value = "";
    } else {
      selectedCategory.value = category;
    }
    selectedCategory.refresh(); // Trigger reactive update
    _updateFilteredProducts();
  }

  /// Check if a category is selected
  bool isCategorySelected(String category) {
    return selectedCategory.value == category;
  }

  /// Update filtered products based on selected categories
  void _updateFilteredProducts() {
    if (selectedCategory.value.isEmpty) {
      // Show all products when no categories are selected
      _filteredProducts.value = allProducts;
    } else {
      _getProductsByCategory();
    }
    // Note: Sorting is handled by ProductController, no need to sort here
  }

  void _getProductsByCategory() async {
    _isLoading.value = true;
    final res = await productUsecase.getProductsByCategory(
      selectedCategory.value,
    );
    res.fold(
      (l) {
        _isLoading.value = false;
      },
      (r) {
        _filteredProducts.value = r;
        _isLoading.value = false;
      },
    );
  }

  /// Clear all category selections
  void clearAllSelections() {
    selectedCategory.value = "";
    selectedCategory.refresh();
    _updateFilteredProducts();
  }
}
