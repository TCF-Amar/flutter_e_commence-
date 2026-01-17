import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_back_button.dart';
import 'package:flutter_commerce/core/widgets/app_scaffold.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_search_controller.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/empty_state.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/list_all__product.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/product_search_bar.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/search_result.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/loaders/product_list_skeleton.dart';

import 'package:get/get.dart';

class SearchScreen extends GetView<ProductSearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      // backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        leading: const AppBackButton(),
        backgroundColor: context.colorScheme.background,
        surfaceTintColor: context.colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: const AppText(
          "Search",
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          // Search bar always visible
          ProductSearchBar(controller: controller),

          // Dynamic content based on search state
          Expanded(
            child: Obx(() {
              // Show loading skeleton when searching
              if (controller.isSearching.value) {
                return const ProductListSkeleton();
              }

              // Show suggestions when query is empty
              if (controller.searchQuery.value.isEmpty) {
                return ListAllProduct(
                  products: controller.productController.products,
                );
              }

              // Show search results if available
              if (controller.searchResults.isNotEmpty) {
                return SearchResult(controller: controller);
              }

              // Show empty state if searched and no results
              if (controller.hasSearched.value &&
                  controller.searchResults.isEmpty) {
                return const EmptyState();
              }

              // Fallback (e.g. typing but not yet confirmed) - show suggestions
              return ListAllProduct(
                products: controller.productController.products,
              );
            }),
          ),
        ],
      ),
    );
  }
}
