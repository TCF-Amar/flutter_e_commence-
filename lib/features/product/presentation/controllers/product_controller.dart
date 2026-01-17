import 'package:flutter/material.dart';
import 'package:flutter_commerce/features/product/domain/entities/category.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';
import 'package:flutter_commerce/features/product/domain/usecases/product_usecase.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/prodcut_sort_bottom_sheet.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  //* Use Cases
final ProductUsecase productUsecase;
  ProductController(this.productUsecase);

  //* Observable State Variables
  final RxList<Product> _products = <Product>[].obs;
  final RxList<Product> _filteredProducts = <Product>[].obs;
  final RxList<Category> _category = <Category>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<SortOption> currentSort = SortOption.relevance.obs;
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = 2000.0.obs;
  final RxDouble minRating = 0.0.obs;
  final RxList<String> categories = <String>[].obs;

  //* Getters
  List<Product> get products => _products;
  List<Category> get categoryList => _category;
  List<Product> get filteredProducts => _filteredProducts;
  RxList<Product> get filteredProductsRx => _filteredProducts;

  //* scroll controller
  final ScrollController scrollController = ScrollController();

  final RxInt offset = 0.obs;
  final RxInt limit = 10.obs;
  final RxBool hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    getProducts();
    getCategories();
    _filteredProducts.value = _products;

    // Listen to sort changes - apply to current filtered products
    ever(currentSort, (sortOption) {
      _applyFiltersAndSort();
    });

    // Listen to filter changes - reapply filters and sort
    everAll([minPrice, maxPrice, minRating, categories], (values) {
      _applyFiltersAndSort();
    });

    // Listen to products updates (pagination)
    ever(_products, (_) {
      _applyFiltersAndSort();
    });

    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getProducts();
    }
  }

  // Apply filters and then sort the results
  void _applyFiltersAndSort() {
    // First, apply filters
    List<Product> filtered = getFilteredProducts(
      _products,
      minPrice: minPrice.value,
      maxPrice: maxPrice.value,
      minRating: minRating.value,
      categories: categories.isEmpty ? null : categories,
    );

    // Then, apply sort
    List<Product> sorted = getSortedProducts(filtered, currentSort.value);

    // Update filtered products
    _filteredProducts.value = sorted;

    debugPrint('Filtered: ${filtered.length}, Sorted by: ${currentSort.value}');
  }

  //* Fetch products from the data source
  void getProducts() async {
    isLoading.value = true;
    debugPrint(' Fetching products...');

    if (!hasMore.value) {
      isLoading.value = false;
      return;
    }
    final result = await productUsecase.getProducts(
      offset: offset.value,
      limit: limit.value,
    );

    result.fold(
      (failure) {
        //! Error handling for product retrieval
        isLoading.value = false;
        debugPrint(' Error fetching products:dfgd ${failure.message}');
        // AppSnackbar.error(
        //   message: 'Failed to load products: ${failure.message}',
        // );
        hasMore.value = false;
      },
      (productList) {
        //* Success: Update products list
        isLoading.value = false;
        if (productList.isEmpty) {
          hasMore.value = false;
        } else {
          _products.addAll(productList);
          offset.value += limit.value;
        }
        debugPrint('Successfully fetched ${productList.length} products');
      },
    );
  }

  //* Fetch categories from the data source
  void getCategories() async {
    debugPrint(' Fetching categories...');

    final result = await productUsecase.getCategories();

    result.fold(
      (failure) {
        //! Error handling for category retrieval
        debugPrint(' Error fetching categories: ${failure.message}');
      },
      (categoryList) {
        //! Success: Update category list
        _category.value = categoryList;
        debugPrint('Successfully fetched ${categoryList.length} categories');
      },
    );
  }

  //* Static method to get sorted products without modifying state
  static List<Product> getSortedProducts(
    List<Product> products,
    SortOption sortBy,
  ) {
    List<Product> sortedList = [...products];

    switch (sortBy) {
      case SortOption.priceLowToHigh:
        sortedList.sort((a, b) => a.price.compareTo(b.price));
        break;

      case SortOption.priceHighToLow:
        sortedList.sort((a, b) => b.price.compareTo(a.price));
        break;

      // case SortOption.rating:
      //   sortedList.sort((a, b) => b.rating.rate.compareTo(a.rating.rate));
      //   break;

      case SortOption.nameAZ:
        sortedList.sort((a, b) => a.title.compareTo(b.title));
        break;

      case SortOption.newest:
        sortedList.sort((a, b) => b.id.compareTo(a.id));
        break;

      case SortOption.relevance:
        sortedList.sort((a, b) => a.id.compareTo(b.id));
        break;
      // case SortOption.popularity:
      //   sortedList.sort((a, b) => b.rating.count.compareTo(a.rating.count));
      //   break;
    }

    return sortedList;
  }

  //* Static method to filter products by price, rating, and categories
  static List<Product> getFilteredProducts(
    List<Product> products, {
    double? minPrice,
    double? maxPrice,
    double? minRating,
    List<String>? categories,
  }) {
    List<Product> filteredList = [...products];

    // Filter by price range
    if (minPrice != null) {
      filteredList = filteredList.where((p) => p.price >= minPrice).toList();
    }
    if (maxPrice != null) {
      filteredList = filteredList.where((p) => p.price <= maxPrice).toList();
    }

    // Filter by categories
    if (categories != null && categories.isNotEmpty) {
      filteredList = filteredList
          .where((p) => categories.contains(p.category.name))
          .toList();
    }

    return filteredList;
  }
}
