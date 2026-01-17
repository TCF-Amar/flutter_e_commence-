import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:go_router/go_router.dart';

class ProductSortBottomSheet extends StatefulWidget {
  final Function(SortOption)? onSortSelected;
  final SortOption? currentSort;

  const ProductSortBottomSheet({
    super.key,
    this.onSortSelected,
    this.currentSort,
  });

  static void show(
    BuildContext context, {
    Function(SortOption)? onSortSelected,
    SortOption? currentSort,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: ProductSortBottomSheet(
            onSortSelected: onSortSelected,
            currentSort: currentSort ?? SortOption.relevance,
          ),
        );
      },
    );
  }

  @override
  State<ProductSortBottomSheet> createState() => _ProductSortBottomSheetState();
}

class _ProductSortBottomSheetState extends State<ProductSortBottomSheet> {
  late SortOption selectedSort;

  @override
  void initState() {
    super.initState();
    selectedSort = widget.currentSort ?? SortOption.relevance;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.sort,
                    size: 20,
                    color: context.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                AppText('Sort By', fontSize: 20, fontWeight: FontWeight.bold),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Divider(height: 1, color: Colors.grey.shade200),

          // Sort options - Scrollable to prevent overflow
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  _SortOption(
                    icon: Icons.shuffle,
                    title: 'Relevance',
                    subtitle: 'No specific order',
                    isSelected: selectedSort == SortOption.relevance,
                    onTap: () {
                      setState(() => selectedSort = SortOption.relevance);
                      widget.onSortSelected?.call(SortOption.relevance);
                      context.pop();
                    },
                  ),

                  // _SortOption(
                  //   icon: Icons.trending_up,
                  //   title: 'Popularity',
                  //   subtitle: 'Most popular first',
                  //   isSelected: selectedSort == SortOption.popularity,
                  //   onTap: () {
                  //     setState(() => selectedSort = SortOption.popularity);
                  //     widget.onSortSelected?.call(SortOption.popularity);
                  //     context.pop();
                  //   },
                  // ),

                  _SortOption(
                    icon: Icons.arrow_downward,
                    title: 'Price: Low to High',
                    subtitle: 'Cheapest first',
                    isSelected: selectedSort == SortOption.priceLowToHigh,
                    onTap: () {
                      setState(() => selectedSort = SortOption.priceLowToHigh);
                      widget.onSortSelected?.call(SortOption.priceLowToHigh);
                      context.pop();
                    },
                  ),

                  _SortOption(
                    icon: Icons.arrow_upward,
                    title: 'Price: High to Low',
                    subtitle: 'Most expensive first',
                    isSelected: selectedSort == SortOption.priceHighToLow,
                    onTap: () {
                      setState(() => selectedSort = SortOption.priceHighToLow);
                      widget.onSortSelected?.call(SortOption.priceHighToLow);
                      context.pop();
                    },
                  ),

                  // _SortOption(
                  //   icon: Icons.star,
                  //   title: 'Rating',
                  //   subtitle: 'Highest rated first',
                  //   isSelected: selectedSort == SortOption.rating,
                  //   onTap: () {
                  //     setState(() => selectedSort = SortOption.rating);
                  //     widget.onSortSelected?.call(SortOption.rating);
                  //     // print(selectedSort);
                  //     context.pop();
                  //   },
                  // ),

                  _SortOption(
                    icon: Icons.access_time,
                    title: 'Newest First',
                    subtitle: 'Latest products',
                    isSelected: selectedSort == SortOption.newest,
                    onTap: () {
                      setState(() => selectedSort = SortOption.newest);
                      widget.onSortSelected?.call(SortOption.newest);
                      context.pop();
                    },
                  ),

                  _SortOption(
                    icon: Icons.sort_by_alpha,
                    title: 'Name: A to Z',
                    subtitle: 'Alphabetical order',
                    isSelected: selectedSort == SortOption.nameAZ,
                    onTap: () {
                      setState(() => selectedSort = SortOption.nameAZ);
                      widget.onSortSelected?.call(SortOption.nameAZ);
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _SortOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isSelected;

  const _SortOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.primary.withValues(alpha: 0.05)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: context.colorScheme.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(title, fontSize: 15, fontWeight: FontWeight.w600),
                    const SizedBox(height: 2),
                    AppText(
                      subtitle,
                      fontSize: 12,
                      color: context.textColors.secondary,
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: context.colorScheme.primary,
                  size: 22,
                )
              else
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

enum SortOption {
  relevance,
  // popularity,
  priceLowToHigh,
  priceHighToLow,
  newest,
  nameAZ,
}
