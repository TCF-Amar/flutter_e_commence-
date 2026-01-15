import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_back_button.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/features/product/controllers/product_search_controller.dart';
import 'package:flutter_commerce/features/product/widgets/empty_state.dart';
import 'package:flutter_commerce/features/product/widgets/product_search_bar.dart';
import 'package:flutter_commerce/features/product/widgets/search_result.dart';
import 'package:flutter_commerce/features/product/widgets/search_suggestions.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final ProductSearchController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProductSearchController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        leading: const AppBackButton(),
        backgroundColor: context.colorScheme.surface,
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
              // Show suggestions when not searching
              if (!controller.isSearching.value) {
                return SearchSuggestions(controller: controller);
              }

              // Show empty state when searching but no results
              if (controller.searchResults.isEmpty) {
                return const EmptyState();
              }

              // Show search results
              return SearchResult(controller: controller);
            }),
          ),
        ],
      ),
    );
  }
}
