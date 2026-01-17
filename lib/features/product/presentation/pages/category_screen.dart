import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/routes/app_routes.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_back_button.dart';
import 'package:flutter_commerce/core/widgets/app_scaffold.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_category_controller.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/list_all__product.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/sort_filter_tile.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/loaders/product_list_skeleton.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CategoryScreen extends StatefulWidget {
  final String? category;
  const CategoryScreen({super.key, this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final ProductCategoryController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ProductCategoryController>();
    controller.initializeWithCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      // padding: const EdgeInsets.only(bottom: 45),
      safeArea: false,
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        leading: const AppBackButton(),
        centerTitle: true,
        title: const AppText(
          "Category",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: context.colorScheme.background,
        surfaceTintColor: context.colorScheme.background,
        elevation: 0,
        actions: [
          Obx(() {
            if (controller.selectedCategory.value.isNotEmpty) {
              return IconButton(
                icon: const Icon(Icons.clear_all_outlined),
                tooltip: 'Clear all',
                onPressed: controller.clearAllSelections,
              );
            }
            return const SizedBox.shrink();
          }),
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
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 30,
            child: Obx(() {
              // Force reactivity by accessing length
              final selectedCount = controller.selectedCategory.value;

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: controller.categoryList.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildCategoryChip(
                      category: 'All',
                      isSelected: selectedCount == "",
                      showRemove: false,
                    );
                  }

                  final category = controller.categoryList[index - 1];
                  // Directly check to ensure reactivity
                  final isSelected =
                      controller.selectedCategory.value == category.slug;
                  return _buildCategoryChip(
                    category: category.slug,
                    isSelected: isSelected,
                    showRemove: isSelected,
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 5),
          const SortFilterTile(),
          const SizedBox(height: 5),
          Expanded(
            child: Obx(() {
              final filteredProducts = controller.filteredProducts;
              final isLoading = controller.isLoading;

              if (isLoading) {
                return const ProductListSkeleton();
              }
              if (controller.allProducts.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 64,
                        color: context.textColors.secondary,
                      ),
                      const SizedBox(height: 16),
                      AppText(
                        'No products found',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8),
                      AppText(
                        'Try selecting different categories',
                        fontSize: 14,
                        color: context.textColors.secondary,
                      ),
                    ],
                  ),
                );
              }
              return ListAllProduct(
                products: filteredProducts,
                controller: controller.scrollController,
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
        if (category.toLowerCase() == 'all') {
          controller.clearAllSelections();
        } else {
          controller.toggleCategory(category.toLowerCase());
        }
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        duration: const Duration(milliseconds: 300),
        clipBehavior: Clip.hardEdge,
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
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: isSelected ? Colors.white : context.textColors.primary,
            ),

            if (showRemove) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {
                  controller.toggleCategory(category.toLowerCase());
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
