import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';

class ProductDetailsSkeleton extends StatelessWidget {
  const ProductDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Skeleton
                _buildImageSkeleton(context),

                // Content Skeleton
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Badge Skeleton
                      _buildShimmer(
                        context,
                        width: 100,
                        height: 24,
                        borderRadius: 20,
                      ),

                      const SizedBox(height: 12),

                      // Title Skeleton
                      _buildShimmer(
                        context,
                        width: double.infinity,
                        height: 24,
                      ),
                      const SizedBox(height: 8),
                      _buildShimmer(context, width: 200, height: 24),

                      const SizedBox(height: 12),

                      // Rating Skeleton
                      Row(
                        children: [
                          _buildShimmer(context, width: 120, height: 20),
                          const SizedBox(width: 8),
                          _buildShimmer(context, width: 80, height: 20),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Price Skeleton
                      Row(
                        children: [
                          _buildShimmer(context, width: 120, height: 32),
                          const SizedBox(width: 12),
                          _buildShimmer(
                            context,
                            width: 60,
                            height: 24,
                            borderRadius: 4,
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Quantity Selector Skeleton
                      _buildShimmer(context, width: 80, height: 20),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildShimmer(
                            context,
                            width: 40,
                            height: 40,
                            borderRadius: 8,
                          ),
                          const SizedBox(width: 16),
                          _buildShimmer(
                            context,
                            width: 40,
                            height: 40,
                            borderRadius: 8,
                          ),
                          const SizedBox(width: 16),
                          _buildShimmer(
                            context,
                            width: 40,
                            height: 40,
                            borderRadius: 8,
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Description Skeleton
                      _buildShimmer(context, width: 100, height: 20),
                      const SizedBox(height: 8),
                      _buildShimmer(
                        context,
                        width: double.infinity,
                        height: 16,
                      ),
                      const SizedBox(height: 4),
                      _buildShimmer(
                        context,
                        width: double.infinity,
                        height: 16,
                      ),
                      const SizedBox(height: 4),
                      _buildShimmer(context, width: 250, height: 16),

                      const SizedBox(height: 24),

                      // Product Details Skeleton
                      _buildShimmer(context, width: 150, height: 20),
                      const SizedBox(height: 12),
                      ...List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildShimmer(context, width: 100, height: 16),
                              _buildShimmer(context, width: 120, height: 16),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Bottom Action Bar Skeleton
        _buildBottomBarSkeleton(context),
      ],
    );
  }

  Widget _buildImageSkeleton(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      color: context.colorScheme.surface,
      child: Center(
        // child: _buildShimmer(
        //   context,
        //   width: 200,
        //   height: 200,
        //   borderRadius: 100,
        // ),
      ),
    );
  }

  Widget _buildBottomBarSkeleton(BuildContext context) {
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
            Expanded(
              child: _buildShimmer(
                context,
                width: double.infinity,
                height: 48,
                borderRadius: 8,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildShimmer(
                context,
                width: double.infinity,
                height: 48,
                borderRadius: 8,
              ),
            ),
          ],
        ),
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
