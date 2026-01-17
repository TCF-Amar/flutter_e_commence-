import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/widgets/app_text_form_field.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_search_controller.dart';
import 'package:get/get.dart';

class ProductSearchBar extends StatelessWidget {
  final ProductSearchController controller;
  const ProductSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: AppTextFormField(
        hint: 'Search products...',
        controller: controller.searchTextController,
        onChanged: (value) {
          // Clear search when empty
          if (value.isEmpty) {
            controller.clearSearch();
          }
          // Debounce in controller will trigger search automatically
        },
        onFieldSubmitted: (value) {
          // Commit search when user presses Enter
          controller.commitSearch(value);
        },
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        autoFocus: true,
        suffixIcon: Obx(() {
          if (controller.searchQuery.value.isNotEmpty) {
            return IconButton(
              icon: const Icon(Icons.clear, size: 16),
              onPressed: controller.clearSearch,
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
