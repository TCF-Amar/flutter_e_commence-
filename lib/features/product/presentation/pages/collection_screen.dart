import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_product_card.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/features/home/presentation/widgets/home_search_bar.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/list_all__product.dart';
import 'package:get/get.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_controller.dart';

class CollectionScreen extends GetView<ProductController> {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        title: const AppText(
          'Collections',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeSearchBar(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.filteredProducts.isEmpty) {
                    return ListAllProduct();
                  }
                  return ListView.builder(
                    itemCount: controller.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.filteredProducts[index];
                      return AppProductCard(product: product);
                    },
                  );
                }),
              ),
            ],
          ),
        );
      }),
    );
  }
}
