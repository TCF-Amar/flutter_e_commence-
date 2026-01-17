import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/widgets/app_product_card.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';

class ListAllProduct extends StatelessWidget {
  final List<Product> products;
  final ScrollController? controller;
  const ListAllProduct({super.key, required this.products, this.controller});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const PageStorageKey<String>('product_grid'),
      controller: controller,
      padding: const EdgeInsets.only(bottom: 45, left: 16, right: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return AppProductCard(key: ValueKey(product.id), product: product);
      },
    );
  }
}

/*
 refactor wishlist functionality and fix critical bugs

Major Changes:
- Refactored product search controller for better UX
  * Separated search API calls from saving recent searches
  * Added commitSearch() method for explicit user actions
  * Implemented proper debounce mechanism
  * Added onFieldSubmitted callback to AppTextFormField


- Fixed profile page overflow
  * Wrapped content in SingleChildScrollView
  * Added proper spacing and const optimizations
  * Fixed null check errors for user data (avatar, name, email)

- Fixed category page scroll-to-top issue
  * Added PageStorageKey to GridView.builder
  * Added ValueKey to AppProductCard for better widget identity
  * Preserves scroll position across rebuilds

- Updated test cases to match current architecture
  * Rewrote product repository tests for Platzi API structure
  * Updated auth repository tests with proper mocking
  * Fixed DioClient tests to work with singleton pattern
  * Added proper fallback values for mocktail

- Added functional image carousel to product details
  * Implemented PageController for image swiping
  * Added dynamic image indicator with current page tracking
  * Proper state management with StatefulWidget

- Improved storage and dependency injection
  * Added wishlist, cart, orders to AppStorage
  * Registered ProdcutWhistleController in ProductDependencies
  * Updated storage keys for new features

Bug Fixes:
- Fixed Stack Overflow in product details wishlist button
- Fixed GetX improper use errors with controller registration checks
- Fixed null pointer exceptions in profile details
- Fixed search suggestions not committing searches properly
- Fixed category screen scroll position reset on filter changes

Technical Improvements:
- Better separation of concerns in search functionality
- Improved error handling in wishlist operations
- Enhanced reactive state management with GetX
- Added proper widget keys for performance optimization
- Removed duplicate code and unused imports

------------------------------------------------
 */