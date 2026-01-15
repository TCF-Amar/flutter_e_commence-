import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/routes/app_routes.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_back_button.dart';
import 'package:flutter_commerce/core/widgets/app_product_card.dart';
import 'package:flutter_commerce/core/widgets/app_scaffold.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/category_controller.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CategoryScreen extends StatefulWidget {
  final String? category;
  const CategoryScreen({super.key, this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final CategoryController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CategoryController());
    controller.initializeWithCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      // padding: const EdgeInsets.only(bottom: 45),
      safeArea: false,
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        title: Obx(() {
          final category = controller.selectedCategory.value;
          return AppText(
            category.isEmpty
                ? "All Products"
                : category.capitalizeFirst ?? category,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          );
        }),
        backgroundColor: context.colorScheme.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context.pushNamed(AppRoutes.search.name);
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // Category filter chips
          AnimatedContainer(
            margin: const EdgeInsets.only(top: 10),
            height: 40,
            duration: const Duration(milliseconds: 600),
            child: Obx(() {
              // Access selectedCategory to ensure Obx tracks it
              final selected = controller.selectedCategory.value;

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: controller.categoryList.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildCategoryChip(
                      category: 'All',
                      isSelected: selected.isEmpty,
                      showRemove: false,
                    );
                  }

                  final category = controller.categoryList[index - 1];
                  return _buildCategoryChip(
                    category: category,
                    isSelected: selected == category,
                    showRemove: selected == category,
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              final filteredProducts = controller.filteredProducts;
              final isLoading = controller.isLoading;

              if (isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (filteredProducts.isEmpty) {
                return const Center(
                  child: AppText(
                    'No products found in this category',
                    fontSize: 16,
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.only(bottom: 45, left: 16, right: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return AppProductCard(product: product);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip({
    required String category,
    required bool isSelected,
    bool showRemove = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (category == 'All') {
          controller.setSelectedCategory('');
        } else {
          controller.setSelectedCategory(category);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.primary
              : context.colorScheme.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.card,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              category.capitalizeFirst ?? category,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : context.textColors.primary,
            ),

            if (showRemove) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {
                  controller.clearSelection();
                },
                child: const Icon(Icons.close, size: 16, color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
