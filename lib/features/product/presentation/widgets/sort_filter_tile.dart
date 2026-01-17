import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/prodcut_sort_bottom_sheet.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/product_filter_bottom_sheet.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_controller.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_search_controller.dart';
import 'package:get/get.dart';

class SortFilterTile extends StatelessWidget {
  const SortFilterTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              final productController = Get.find<ProductController>();
              ProductFilterBottomSheet.show(
                context,
                categories: productController.categoryList
                    .map((e) => e.name)
                    .toList(),
                onApplyFilters: (filters) {
                  // Apply filters using static method
                  // final filteredProducts = ProductController.getFilteredProducts(
                  //   productController.products,
                  //   minPrice: filters.minPrice,
                  //   maxPrice: filters.maxPrice,
                  //   minRating: filters.minRating,
                  //   categories: filters.categories.isEmpty ? null : filters.categories,
                  // );

                  // Update filtered products
                  //   productController.setFilteredProducts(filteredProducts);

                  //   debugPrint('Filters applied: ${filters.categories}');
                  //   debugPrint('Price: ${filters.minPrice} - ${filters.maxPrice}');
                  //   debugPrint('Min Rating: ${filters.minRating}');
                  //   debugPrint('Filtered count: ${filteredProducts.length}');
                  productController.minPrice.value = filters.minPrice;
                  productController.maxPrice.value = filters.maxPrice;
                  productController.minRating.value = filters.minRating;
                  productController.categories.value = filters.categories;
                },
              );
            },
            child: Row(
              children: [
                const Icon(Icons.filter_list_outlined),
                const SizedBox(width: 5),
                AppText("Filters", fontSize: 16, fontWeight: FontWeight.bold),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              final productController = Get.find<ProductController>();
              // Try to get search controller if on search screen
              final searchController =
                  Get.isRegistered<ProductSearchController>()
                  ? Get.find<ProductSearchController>()
                  : null;

              ProductSortBottomSheet.show(
                context,
                currentSort:
                    searchController?.currentSort.value ??
                    productController.currentSort.value,
                onSortSelected: (sortOption) {
                  if (searchController != null) {
                    searchController.currentSort.value = sortOption;
                  } else {
                    productController.currentSort.value = sortOption;
                  }
                },
              );
            },
            child: Row(
              children: [
                RotatedBox(
                  quarterTurns: 1,
                  child: Icon(Icons.compare_arrows_outlined, size: 18),
                ),
                const SizedBox(width: 5),
                AppText("Sort", fontSize: 16, fontWeight: FontWeight.bold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
