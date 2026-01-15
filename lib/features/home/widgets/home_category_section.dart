import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/constants/colors/app_color_scheme.dart';
import 'package:flutter_commerce/core/routes/app_routes.dart';
// import 'package:flutter_commerce/features/dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_commerce/features/home/controllers/home_controller.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:go_router/go_router.dart';

class HomeCategorySection extends GetView<HomeController> {
  const HomeCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    // final DashboardController dashboardController = Get.find();

    final colorScheme = Theme.of(context).extension<AppColorScheme>()!;
    return Obx(() {
      final categories = controller.productController.categoryList;

      if (categories.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: AppText(
              'Categories',
              uppercase: true,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    // // Set the selected category for filtering
                    // controller.productController.selectedCategory.value =
                    //     category;

                    // // Switch to Collections tab
                    // dashboardController.changeTab(1);

                    context.pushNamed(
                      AppRoutes.catagory.name,
                      queryParameters: {'category': category},
                    );
                  },
                  child: Container(
                    height: 50,
                    width: double.tryParse((category.length * 13).toString()),
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl: "https://picsum.photos/200/300",
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
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(50),
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
                            borderRadius: BorderRadius.circular(50),
                            child: Center(
                              child: AppText(
                                "${category.capitalizeFirst}",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.surface,
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
