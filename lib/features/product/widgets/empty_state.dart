import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: context.colorScheme.icon.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          AppText(
            'No results found',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.textPrimary,
          ),
          const SizedBox(height: 8),
          AppText(
            'Try searching with different keywords',
            fontSize: 14,
            color: context.colorScheme.textSecondary,
          ),
        ],
      ),
    );
  }
}
