import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_button.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProductFilterBottomSheet extends StatefulWidget {
  final List<String> categories;
  final Function(FilterOptions)? onApplyFilters;

  const ProductFilterBottomSheet({
    super.key,
    required this.categories,
    this.onApplyFilters,
  });

  static void show(
    BuildContext context, {
    required List<String> categories,
    Function(FilterOptions)? onApplyFilters,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: ProductFilterBottomSheet(
            categories: categories,
            onApplyFilters: onApplyFilters,
          ),
        );
      },
    );
  }

  @override
  State<ProductFilterBottomSheet> createState() =>
      _ProductFilterBottomSheetState();
}

class _ProductFilterBottomSheetState extends State<ProductFilterBottomSheet> {
  final ProductController productController = Get.find();
  late RangeValues _priceRange;
  late double _minRating;
  late Set<String> _selectedCategories;

  @override
  void initState() {
    super.initState();
    // Initialize with current filter values from ProductController
    // Clamp values to slider bounds (0-2000)
    final minPrice = productController.minPrice.value.clamp(0.0, 2000.0);
    final maxPrice = productController.maxPrice.value.clamp(0.0, 2000.0);

    _priceRange = RangeValues(minPrice, maxPrice);
    _minRating = productController.minRating.value;
    _selectedCategories = Set.from(productController.categories);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
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

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                const Icon(Icons.filter_list, size: 24),
                const SizedBox(width: 8),
                AppText('Filters', fontSize: 20, fontWeight: FontWeight.bold),
                const Spacer(),
                TextButton(
                  onPressed: _resetFilters,
                  child: AppText(
                    'Reset',
                    fontSize: 14,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price Range
                  _buildSectionTitle('Price Range'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        '₹${_priceRange.start.toInt()}',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      AppText(
                        '₹${_priceRange.end.toInt()}',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 2000,
                    divisions: 20,
                    semanticFormatterCallback: (value) =>
                        value.round().toString(),
                    labels: RangeLabels(
                      '₹${_priceRange.start.toInt()}',
                      '₹${_priceRange.end.toInt()}',
                    ),
                    onChanged: (values) {
                      setState(() {
                        _priceRange = values;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  // Rating Filter
                  _buildSectionTitle('Minimum Rating'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (int i = 1; i <= 5; i++)
                        _buildRatingChip(i.toDouble()),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Categories
                  _buildSectionTitle('Categories'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.categories.map((category) {
                      final isSelected = _selectedCategories.contains(category);
                      return FilterChip(
                        label: AppText(
                          category.capitalizeFirst ?? category,
                          fontSize: 14,
                          color: isSelected
                              ? Colors.white
                              : context.textColors.primary,
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedCategories.add(category);
                            } else {
                              _selectedCategories.remove(category);
                            }
                          });
                        },
                        backgroundColor: context.colorScheme.card,
                        selectedColor: context.colorScheme.primary,
                        checkmarkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? context.colorScheme.primary
                                : Colors.grey.shade300,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Apply Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: AppButton(
                onPressed: _applyFilters,
                child: const AppText(
                  'Apply Filters',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return AppText(title, fontSize: 16, fontWeight: FontWeight.bold);
  }

  Widget _buildRatingChip(double rating) {
    final isSelected = _minRating == rating;
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            rating.toInt().toString(),
            fontSize: 14,
            color: isSelected ? Colors.white : context.textColors.primary,
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.star,
            size: 16,
            color: isSelected ? Colors.white : Colors.amber,
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _minRating = selected ? rating : 0;
        });
      },
      backgroundColor: context.colorScheme.card,
      selectedColor: context.colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected
              ? context.colorScheme.primary
              : Colors.grey.shade300,
        ),
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      _priceRange = const RangeValues(0, 2000);
      _minRating = 0;
      _selectedCategories.clear();
    });

    // Reset ProductController filters
    productController.minPrice.value = 0.0;
    productController.maxPrice.value = 2000.0;
    productController.minRating.value = 0.0;
    productController.categories.clear();
  }

  void _applyFilters() {
    final filters = FilterOptions(
      minPrice: _priceRange.start,
      maxPrice: _priceRange.end,
      minRating: _minRating,
      categories: _selectedCategories.toList(),
    );
    widget.onApplyFilters?.call(filters);
    Navigator.pop(context);
  }
}

class FilterOptions {
  final double minPrice;
  final double maxPrice;
  final double minRating;
  final List<String> categories;

  FilterOptions({
    required this.minPrice,
    required this.maxPrice,
    required this.minRating,
    required this.categories,
  });

  bool get hasActiveFilters {
    return minPrice > 0 ||
        maxPrice < 2000 ||
        minRating > 0 ||
        categories.isNotEmpty;
  }
}
