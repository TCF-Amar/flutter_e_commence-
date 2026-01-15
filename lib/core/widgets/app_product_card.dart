import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/features/product/models/product_model.dart';

import 'app_button.dart';
import 'app_text.dart';

class AppProductCard extends StatelessWidget {
  final ProductModel product;
  final bool? isSale;
  const AppProductCard({this.isSale, super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(
        color: context.colorScheme.card,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// IMAGE + FAVORITE
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.cover,
                      placeholder: (_, _) =>
                          Container(color: Colors.grey.shade200),
                      errorWidget: (_, _, _) => Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image_not_supported, size: 30),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 16,
                      ),
                    ),
                  ),
                ),
                isSale == true
                    ? Positioned(
                        top: 8,
                        left: 8,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: AppText("10% ", fontSize: 12),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),

          /// CONTENT
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 2),
                      AppText(
                        product.rating.toStringAsFixed(1),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  /// Title
                  Expanded(
                    flex: 1,
                    child: AppText(
                      product.title,
                      maxLines: 1,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // const SizedBox(height: 4),

                  /// Price
                  Expanded(
                    flex: 1,
                    child: AppText(
                      '₹${product.price.toStringAsFixed(0)}',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  // const SizedBox(height: 10),

                  /// Add to cart
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: AppButton(
                      radius: 8,
                      onPressed: () {},
                      child: const AppText(
                        'Add',
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
