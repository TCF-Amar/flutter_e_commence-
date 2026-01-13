import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/storage/app_storage.dart';
import 'package:flutter_commerce/core/widgets/app_text_form_field.dart';
import 'package:flutter_commerce/modules/auth/auth_controller.dart';
import 'package:flutter_commerce/modules/home/widgets/category_section.dart';
import 'package:flutter_commerce/modules/home/widgets/home_carousel_slider.dart';
import 'package:flutter_commerce/modules/home/widgets/sale_section.dart';
import 'package:flutter_commerce/modules/home/widgets/trending_products.dart';
import 'package:flutter_commerce/modules/product/product_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AuthController controller = Get.find<AuthController>();
  final ProductController productController = Get.find<ProductController>();
  final AppStorage storage = Get.find<AppStorage>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Icon(Icons.menu),
                    SizedBox(width: 12),
                    Expanded(
                      child: AppTextFormField(
                        controller: TextEditingController(),
                        hint: "Search",
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              HomeCarouselSlider(),

              // Category Section with reactive updates
              Obx(() {
                if (productController.isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return CategorySection(productController: productController);
              }),

              // Trending Products with reactive updates
              Obx(() {
                if (productController.isLoading) {
                  return const SizedBox.shrink();
                }

                return TrendingProducts(products: productController.products);
              }),
              Obx(() {
                if (productController.isLoading) {
                  return const SizedBox.shrink();
                }

                return SaleSection(products: productController.products);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
