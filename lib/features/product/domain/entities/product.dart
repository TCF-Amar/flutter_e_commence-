import 'package:flutter_commerce/features/product/domain/entities/category.dart';

/// Domain entity representing a product
/// Pure Dart class with no external dependencies
class Product {
  final int id;
  final String title;
  final String slug;
  final double price;
  final String description;
  final Category category;
  final List<String> images;
  // final Rating rating;

  const Product({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  Product copyWith({
    int? id,
    String? title,
    String? slug,
    double? price,
    String? description,
    Category? category,
    List<String>? images,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      images: images ?? this.images,
    );
  }

  /// Format price with currency symbol
  String get formattedPrice => '\$$price';

  /// Check if product is on sale (you can add sale logic later)
  bool get isOnSale => false; // Placeholder for future sale logic

  /// Get short description (first 100 characters)
  String get shortDescription {
    if (description.length <= 100) return description;
    return '${description.substring(0, 100)}...';
  }
}
