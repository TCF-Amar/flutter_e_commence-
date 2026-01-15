import 'package:flutter_commerce/features/product/controllers/product_controller.dart';
import 'package:flutter_commerce/features/product/models/product_model.dart';
import 'package:get/get.dart';

/// Controller for managing category screen state and filtering
class CategoryController extends GetxController {
  final ProductController productController = Get.find<ProductController>();

  final selectedCategory = ''.obs;
  final _filteredProducts = <ProductModel>[].obs;

  List<ProductModel> get filteredProducts => _filteredProducts;
  List<String> get categoryList => productController.categoryList;
  List<ProductModel> get allProducts => productController.products;
  bool get isLoading => productController.isLoading.value;

  @override
  void onInit() {
    super.onInit();
    // Listen to product changes and update filtered list
    ever(productController.isLoading, (_) {
      if (!productController.isLoading.value) {
        _updateFilteredProducts();
      }
    });
    // Initial filter update
    _updateFilteredProducts();
  }

  /// Initialize with a specific category
  void initializeWithCategory(String? category) {
    if (category != null && category.isNotEmpty) {
      setSelectedCategory(category);
    } else {
      setSelectedCategory('');
    }
  }

  /// Set the selected category and filter products
  void setSelectedCategory(String category) {
    selectedCategory.value = category;
    _updateFilteredProducts();
  }

  /// Update filtered products based on selected category
  void _updateFilteredProducts() {
    if (selectedCategory.value.isEmpty) {
      // Show all products when "All" is selected
      _filteredProducts.value = allProducts;
    } else {
      // Filter products by selected category
      _filteredProducts.value = allProducts
          .where((product) => product.category == selectedCategory.value)
          .toList();
    }
  }

  /// Clear category selection
  void clearSelection() {
    setSelectedCategory('');
  }
}
