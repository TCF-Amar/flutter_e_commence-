import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';

class ProductListSkeleton extends StatelessWidget {
  const ProductListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 45, left: 16, right: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 6, // Show 6 skeleton items
      itemBuilder: (context, index) {
        return const ProductCardSkeleton();
      },
    );
  }
}

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// IMAGE
          Expanded(
            flex: 2,
            child: _buildShimmer(
              context,
              width: double.infinity,
              height: double.infinity,
              borderRadius: 5,
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
                  const SizedBox(height: 4),

                  /// Title
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // _buildShimmer(
                        //   context,
                        //   width: double.infinity,
                        //   height: 16,
                        //   borderRadius: 4,
                        // ),
                        const SizedBox(height: 4),
                        _buildShimmer(
                          context,
                          width: 80, // Shorter width for second line if needed
                          height: 16,
                          borderRadius: 4,
                        ),
                      ],
                    ),
                  ),

                  /// Price
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildShimmer(
                          context,
                          width: 60,
                          height: 18,
                          borderRadius: 4,
                        ),
                      ],
                    ),
                  ),

                  /// Add to cart button
                  _buildShimmer(
                    context,
                    width: double.infinity,
                    height: 32,
                    borderRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer(
    BuildContext context, {
    required double width,
    required double height,
    double borderRadius = 8,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: const _ShimmerEffect(),
      ),
    );
  }
}

class _ShimmerEffect extends StatefulWidget {
  const _ShimmerEffect();

  @override
  State<_ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<_ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      Colors.grey.shade800,
                      Colors.grey.shade700,
                      Colors.grey.shade600,
                      Colors.grey.shade700,
                      Colors.grey.shade800,
                    ]
                  : [
                      Colors.grey.shade300,
                      Colors.grey.shade200,
                      Colors.grey.shade100,
                      Colors.grey.shade200,
                      Colors.grey.shade300,
                    ],
              stops: [
                (_animation.value - 0.5).clamp(0.0, 1.0),
                (_animation.value - 0.25).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 0.25).clamp(0.0, 1.0),
                (_animation.value + 0.5).clamp(0.0, 1.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
