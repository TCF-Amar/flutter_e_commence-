import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/list_all__product.dart';
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
          // SortFilterTile(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppText(
              '${results.length} Results',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.colorScheme.textPrimary,
            ),
          ),
          Expanded(child: ListAllProduct(products: results)),
        ],
      );
    });
  }
}
