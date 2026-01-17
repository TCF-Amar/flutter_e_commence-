import 'package:flutter/material.dart';
import 'package:flutter_commerce/features/home/widgets/home_search_bar.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/list_all__product.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/loaders/product_list_skeleton.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/sort_filter_tile.dart';
import 'package:get/get.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_controller.dart';

class CollectionScreen extends GetView<ProductController> {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.products.isEmpty) {
        return const ProductListSkeleton();
      }

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HomeSearchBar(),
            SortFilterTile(),
            Expanded(
              child: Obx(() {
                // if (controller.isLoading.value) {
                //   return const ProductListSkeleton();
                // }
                if (controller.filteredProducts.isEmpty &&
                    controller.products.isEmpty) {
                  return ListAllProduct(products: controller.products);
                }
                return ListAllProduct(
                  products: controller.filteredProducts,
                  controller: controller.scrollController,
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
