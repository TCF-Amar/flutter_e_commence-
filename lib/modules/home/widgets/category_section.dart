import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/modules/product/product_controller.dart';

class CategorySection extends StatelessWidget {
  final ProductController productController;

  const CategorySection({super.key, required this.productController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AppText(
                'Categories',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const Spacer(),
              const AppText(
                'See All',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Reactive part
          Obx(() {
            final categories = productController.categoryMap;

            if (categories.isEmpty) {
              return const SizedBox(
                height: 50,
                child: Center(child: AppText('No categories')),
              );
            }

            final keys = categories.keys.toList();

            return SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: keys.length,
                itemBuilder: (context, index) {
                  final category = keys[index];

                  return Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 12),

                    // padding: const EdgeInsets.symmetric(
                    //   horizontal: 16,
                    //   vertical: 12,
                    // ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: categories[category]![0].image,
                              height: 70,
                              width: 150,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              colorBlendMode: BlendMode.darken,
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            top: 0,
                            child: Container(
                              // padding: const EdgeInsets.symmetric(
                              //   horizontal: 16,
                              //   vertical: 12,
                              // ),
                              width: .infinity,
                              height: .infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.black.withValues(alpha: 0.5),
                              ),
                              child: Center(
                                child: AppText(
                                  "${category.toLowerCase().capitalizeFirst}",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
