import 'package:flutter/material.dart';
import 'package:flutter_commerce/features/product/controllers/product_controller.dart';
import 'package:flutter_commerce/features/product/models/product_model.dart';
import 'package:get/get.dart';

class ProductSearchController extends GetxController {
  final ProductController productController = Get.find<ProductController>();
  final TextEditingController searchTextController = TextEditingController();

  final searchQuery = ''.obs;
  final searchResults = <ProductModel>[].obs;
  final recentSearches = <String>[].obs;
  final isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Debounce search - wait 500ms after user stops typing
    debounce(
      searchQuery,
      (_) => search(searchQuery.value),
      time: const Duration(milliseconds: 500),
    );

    // Listen to search text changes
    searchTextController.addListener(() {
      searchQuery.value = searchTextController.text;
      if (searchQuery.value.isEmpty) {
        searchResults.clear();
        isSearching.value = false;
      }
    });
  }

  // Perform search
  void search(String query) {
    // if query is empty clear search results
    if (query.trim().isEmpty) {
      searchResults.clear();
      isSearching.value = false;
      return;
    }

    isSearching.value = true;
    final allProducts = productController.products;

    // Filter products based on search query
    searchResults.value = allProducts.where((product) {
      final titleMatch = product.title.toLowerCase().contains(
        query.toLowerCase(),
      );
      final categoryMatch = product.category.toLowerCase().contains(
        query.toLowerCase(),
      );
      final descriptionMatch = product.description.toLowerCase().contains(
        query.toLowerCase(),
      );

      return titleMatch || categoryMatch || descriptionMatch;
    }).toList();

    // Add to recent searches if not empty
    if (query.trim().isNotEmpty && !recentSearches.contains(query)) {
      recentSearches.insert(0, query);
      if (recentSearches.length > 10) {
        recentSearches.removeLast();
      }
    }
  }

  // Get search suggestions based on current query
  List<String> get suggestions {
    if (searchQuery.value.isEmpty) {
      return recentSearches.take(5).toList();
    }

    final allProducts = productController.products;
    final suggestions = <String>{};

    // Add matching product titles
    for (var product in allProducts) {
      if (product.title.toLowerCase().contains(
        searchQuery.value.toLowerCase(),
      )) {
        suggestions.add(product.title);
      }
      if (suggestions.length >= 5) break;
    }

    // Add matching categories
    for (var category in productController.categoryList) {
      if (category.toLowerCase().contains(searchQuery.value.toLowerCase())) {
        suggestions.add(category);
      }
      if (suggestions.length >= 5) break;
    }

    return suggestions.toList();
  }

  void clearSearch() {
    searchTextController.clear();
    searchQuery.value = '';
    searchResults.clear();
    isSearching.value = false;
  }

  void clearRecentSearches() {
    recentSearches.clear();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
