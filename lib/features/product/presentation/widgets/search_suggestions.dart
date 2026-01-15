import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:get/get.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_search_controller.dart';

class SearchSuggestions extends StatelessWidget {
  final ProductSearchController controller;
  const SearchSuggestions({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final suggestions = controller.suggestions;
      final hasRecentSearches = controller.recentSearches.isNotEmpty;

      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (hasRecentSearches && controller.searchQuery.value.isEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  'Recent Searches',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.textPrimary,
                ),
                TextButton(
                  onPressed: controller.clearRecentSearches,
                  child: AppText(
                    'Clear',
                    fontSize: 14,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          if (controller.searchQuery.value.isNotEmpty) ...[
            AppText(
              'Suggestions',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.colorScheme.textPrimary,
            ),
            const SizedBox(height: 8),
          ],
          ...suggestions.map((suggestion) {
            return ListTile(
              leading: Icon(
                controller.searchQuery.value.isEmpty
                    ? Icons.history
                    : Icons.search,
                color: context.colorScheme.icon,
              ),
              title: AppText(
                suggestion,
                fontSize: 14,
                color: context.colorScheme.textPrimary,
              ),
              onTap: () {
                controller.searchTextController.text = suggestion;
                controller.search(suggestion);
              },
            );
          }),
        ],
      );
    });
  }
}