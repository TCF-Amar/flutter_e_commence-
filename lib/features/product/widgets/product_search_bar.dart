import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/widgets/app_text_form_field.dart';
import 'package:flutter_commerce/features/product/controllers/product_search_controller.dart';
import 'package:get/get.dart';

class ProductSearchBar extends StatelessWidget {
  final ProductSearchController controller;
  const ProductSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppTextFormField(
        hint: 'Search products...',
        controller: controller.searchTextController,
        onChanged: (value) {
          // Trigger search as user types
          if (value.length >= 2) {
            controller.search(value);
          }
          if (value.isEmpty) {
            controller.clearSearch();
          }
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
