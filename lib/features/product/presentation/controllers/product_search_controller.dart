import 'package:flutter/material.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';
import 'package:flutter_commerce/features/product/domain/usecases/product_usecase.dart';
import 'package:flutter_commerce/core/storage/app_storage.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_controller.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/prodcut_sort_bottom_sheet.dart';
import 'package:get/get.dart';

class ProductSearchController extends GetxController {
  final ProductUsecase productUsecase;

  ProductSearchController(this.productUsecase);
  final ProductController productController = Get.find<ProductController>();
  final AppStorage appStorage = Get.find<AppStorage>();
  final TextEditingController searchTextController = TextEditingController();

  final searchQuery = ''.obs;
  final searchResults = <Product>[].obs;
  final recentSearches = <String>[].obs;
  final isSearching = false.obs;
  final hasSearched = false.obs;
  final currentSort = SortOption.relevance.obs;

  @override
  void onInit() {
    super.onInit();

    // Load recent searches
    recentSearches.value = appStorage.recentSearches;

    //* Debounce search - wait 500ms after user stops typing
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
        hasSearched.value = false;
        isSearching.value = false;
      }
    });
  }

  /// Perform search - ONLY fetches results, does NOT save to recent searches
  /// This is triggered by debounce as user types
  void search(String query) async {
    //! if query is empty clear search results
    if (query.trim().isEmpty) {
      searchResults.clear();
      isSearching.value = false;
      return;
    }

    isSearching.value = true;

    //* Filter products based on search query
    final results = await productUsecase.getProductsBySearch(query);

    results.fold(
      (failure) {
        isSearching.value = false;
        hasSearched.value = true;
        Get.snackbar(
          "Error",
          failure.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
      (products) {
        isSearching.value = false;
        hasSearched.value = true;
        searchResults.value = products;
      },
    );
  }

  /// Add query to recent searches with deduplication and max limit
  /// This is a private helper method for managing recent search history
  void addToRecentSearches(String query) {
    if (query.trim().isEmpty) return;

    // Remove if already exists (to move to top)
    if (recentSearches.contains(query)) {
      recentSearches.remove(query);
    }

    // Add to top
    recentSearches.insert(0, query);

    // Maintain max 10 items
    if (recentSearches.length > 10) {
      recentSearches.removeLast();
    }

    // Persist to storage
    appStorage.setRecentSearches(recentSearches);
  }

  /// Commit search - performs search AND saves to recent searches
  /// This should be called when user explicitly commits a search:
  /// - Pressing Enter/Search button on keyboard
  /// - Tapping a suggestion
  /// - Any explicit search action
  void commitSearch(String query) {
    if (query.trim().isEmpty) return;

    // Save to recent searches first
    addToRecentSearches(query);

    // Then perform the search
    search(query);
  }

  // Get search suggestions based on current query

  void clearSearch() {
    searchTextController.clear();
    searchQuery.value = '';
    searchResults.clear();
    isSearching.value = false;
  }

  void clearRecentSearches() {
    recentSearches.clear();
    appStorage.setRecentSearches([]);
  }

  //* Sort search results

  @override
  void onClose() {
    //! Ensure controller is disposed to prevent memory leaks
    searchTextController.dispose();
    super.onClose();
  }
}
