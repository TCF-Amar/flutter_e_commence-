import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_product_card.dart';
import 'package:get/get.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_search_controller.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';

class SearchResult extends StatelessWidget {
  final ProductSearchController controller;
  const SearchResult({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final results = controller.searchResults;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppText(
              '${results.length} Results',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.colorScheme.textPrimary,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final product = results[index];
                return AppProductCard(product: product);
              },
            ),
          ),
        ],
      );
    });
  }
}
