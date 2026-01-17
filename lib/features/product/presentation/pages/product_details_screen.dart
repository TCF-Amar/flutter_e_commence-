import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_back_button.dart';
import 'package:flutter_commerce/core/widgets/app_button.dart';
import 'package:flutter_commerce/core/widgets/app_scaffold.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_details_controller.dart';
import 'package:flutter_commerce/features/product/presentation/widgets/loaders/product_details_skeleton.dart';
import 'package:get/get.dart';
// ignore: unnecessary_underscores

class ProductDetails extends GetView<ProductDetailsController> {
  final String id;
  const ProductDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // Fetch product on build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getProductById(int.parse(id));
      // controller.toggleFavorite();
    });

    return AppScaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        surfaceTintColor: context.colorScheme.surface,
        leading: const AppBackButton(),
        title: AppText(
          'Product Details',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Badge(
              label: const Text('3'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const ProductDetailsSkeleton();
        }

        if (controller.product == null) {
          return const Center(child: Text('Product not found'));
        }

        final product = controller.product!;

        return Column(
          children: [
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    _ProductImageCarousel(product: product),
                    // Product Info
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Badge
                          _buildCategoryBadge(product, context),

                          const SizedBox(height: 12),

                          // Title
                          AppText(
                            product.title,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            maxLines: 3,
                          ),

                          const SizedBox(height: 12),

                          // Price
                          _buildPriceSection(product),

                          const SizedBox(height: 24),

                          // Quantity Selector
                          _buildQuantitySelector(controller),

                          const SizedBox(height: 24),

                          // Description
                          _buildDescription(product),

                          const SizedBox(height: 24),
                          // Text("sdf"),
                          // Similar Products
                          _buildSimilarProducts(
                            controller.similarProducts,
                            context,
                          ),

                          const SizedBox(height: 24),

                          // Product Details
                          _buildProductDetails(product),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Action Bar
            _buildBottomActionBar(product, context, controller),
          ],
        );
      }),
    );
  }
}

class _ProductImageCarousel extends StatefulWidget {
  final Product product;

  const _ProductImageCarousel({required this.product});

  @override
  State<_ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<_ProductImageCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          width: double.infinity,
          color: context.colorScheme.surface,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.product.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.product.images[index],
                fit: BoxFit.contain,
                placeholder: (_, __) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) =>
                    const Icon(Icons.image_not_supported, size: 100),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Image indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.product.images.length, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? context.colorScheme.primary
                    : Colors.grey.shade400,
              ),
            );
          }),
        ),
      ],
    );
  }
}

Widget _buildCategoryBadge(Product product, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: context.colorScheme.primary.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: AppText(
      product.category.name.toUpperCase(),
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: context.colorScheme.primary,
    ),
  );
}

Widget _buildPriceSection(Product product) {
  return Row(
    children: [
      AppText(
        '₹${product.price.toStringAsFixed(0)}',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
      const SizedBox(width: 12),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(4),
        ),
        child: AppText(
          '10% OFF',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    ],
  );
}

Widget _buildQuantitySelector(ProductDetailsController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText('Quantity', fontSize: 16, fontWeight: FontWeight.bold),
      const SizedBox(height: 8),
      Row(
        children: [
          // Decrease Button
          GestureDetector(
            onTap: controller.decrementQuantity,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.remove, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          // Quantity Display
          Obx(
            () => AppText(
              controller.quantity.value.toString(),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          // Increase Button
          GestureDetector(
            onTap: controller.incrementQuantity,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add, size: 20),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildDescription(Product product) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText('Description', fontSize: 18, fontWeight: FontWeight.bold),
      const SizedBox(height: 8),
      AppText(
        product.description,
        fontSize: 14,
        color: Colors.grey.shade700,
        maxLines: 10,
      ),
    ],
  );
}

Widget _buildSimilarProducts(List<Product> products, BuildContext context) {
  // debugPrint(products.toString());
  if (products.isEmpty) {
    return const SizedBox.shrink();
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText('Similar Products', fontSize: 18, fontWeight: FontWeight.bold),

      const SizedBox(height: 12),
      SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                Get.find<ProductDetailsController>().getProductById(product.id);
              },
              child: Container(
                width: 150,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      child: Image.network(
                        product.images[0],
                        height: 120,
                        width: 150,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Container(
                          height: 120,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            product.title,
                            fontSize: 12,
                            maxLines: 2,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 4),
                          AppText(
                            '₹${product.price.toStringAsFixed(0)}',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ],
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
}

Widget _buildProductDetails(Product product) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText('Product Details', fontSize: 18, fontWeight: FontWeight.bold),
      const SizedBox(height: 12),
      _buildDetailRow('Category', product.category.name),
      _buildDetailRow('Availability', 'In Stock'),
    ],
  );
}

Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(label, fontSize: 14, color: Colors.grey.shade600),
        AppText(value, fontSize: 14, fontWeight: FontWeight.w600),
      ],
    ),
  );
}

Widget _buildBottomActionBar(
  Product product,
  BuildContext context,
  ProductDetailsController controller,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: context.colorScheme.background,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, -5),
        ),
      ],
    ),
    child: SafeArea(
      child: Row(
        children: [
          // Buy Now Button
          Expanded(
            child: AppButton(
              onPressed: controller.buyNow,
              child: const AppText(
                'Buy Now',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Add to Cart Button
          Expanded(
            child: AppButton(
              onPressed: controller.addToCart,
              backgroundColor: context.colorScheme.surface,
              child: AppText(
                'Add to Cart',
                color: context.colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
