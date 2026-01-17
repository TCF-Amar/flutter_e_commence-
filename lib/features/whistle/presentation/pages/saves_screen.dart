import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/prodcut_whistle_controller.dart';
// import 'package:flutter_commerce/features/product/presentation/widgets/list_all__product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SavesScreen extends GetView<ProdcutWhistleController> {
  const SavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        title: const AppText(
          'Saved Items',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
      ),
      body: Obx(() {
        // Show products if wishlist is not empty
        // if (controller.wishlistProducts.isNotEmpty) {
        //   return ListAllProduct(products: controller.wishlistProducts);
        // }

        // Show empty state
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.heart,
                size: 64,
                color: context.colorScheme.icon,
              ),
              const SizedBox(height: 16),
              AppText(
                'No Saved Items',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.textPrimary,
              ),
              const SizedBox(height: 8),
              AppText(
                'Save your favorite products',
                fontSize: 14,
                color: context.colorScheme.textSecondary,
              ),
            ],
          ),
        );
      }),
    );
  }
}
