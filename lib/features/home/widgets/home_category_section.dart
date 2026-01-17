import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/routes/app_routes.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/features/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:go_router/go_router.dart';

class HomeCategorySection extends GetView<HomeController> {
  const HomeCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    // final DashboardController dashboardController = Get.find();

    return Obx(() {
      final categories = controller.productController.categoryList;

      if (categories.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const AppText(
                  'Categories',
                  // uppercase: true,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    context.pushNamed(AppRoutes.catagory.name);
                  },
                  child: AppText(
                    'See All',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: context.textColors.link,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.catagory.name,
                      queryParameters: {'category': category.slug},
                    );
                  },
                  child: Container(
                    height: 40,
                    width: double.tryParse(
                      (category.name.length * 13).toString(),
                    ),
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: category.image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: context.colorScheme.surface.withValues(
                                  alpha: 0.6,
                                ),
                                // .withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Center(
                              child: AppText(
                                "${category.name.capitalizeFirst}",
                                fontSize: 16,

                                fontWeight: FontWeight.w700,
                                color: context.textColors.primary,
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
          ),
        ],
      );
    });
  }
}
