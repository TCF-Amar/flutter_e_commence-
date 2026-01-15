import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/widgets/app_product_card.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_controller.dart';
import 'package:get/state_manager.dart';

class ListAllProduct extends GetView<ProductController> {
  const ListAllProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: controller.products.length,
      itemBuilder: (context, index) {
        final product = controller.products[index];
        return AppProductCard(product: product);
      },
    );
  }
}
