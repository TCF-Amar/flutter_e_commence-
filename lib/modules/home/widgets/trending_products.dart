import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/widgets/app_product_card.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/data/models/product_model.dart';

class TrendingProducts extends StatelessWidget {
  final List<ProductModel> products;

  const TrendingProducts({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    final itemCount = products.length > 5 ? 5 : products.length;
    // final cardWidth = MediaQuery.of(context).size.width * 0.65;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: [
              const AppText(
                'Trending',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const AppText(
                  'See All',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Horizontal product list
          SizedBox(
            height: 220, // Fixed height for horizontal scroll
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                final product = products[index];

                return SizedBox(
                  width: 165, // Fixed width for each card
                  child: AppProductCard(product: product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
