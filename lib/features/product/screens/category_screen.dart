import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/routes/app_routes.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_back_button.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/features/product/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final ProductController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ProductController>();
    controller.selectedCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        title: AppText(
          widget.category.capitalizeFirst.toString(),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: context.colorScheme.surface,
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
      body: Center(
        child: AppText(controller.filteredProducts.length.toString()),
      ),
    );
  }
}
