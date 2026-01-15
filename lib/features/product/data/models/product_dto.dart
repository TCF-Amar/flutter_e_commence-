import 'package:flutter_commerce/features/product/data/models/rating_dto.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';

/// DTO for Product
/// Handles JSON serialization/deserialization and conversion to/from domain entity
class ProductDto {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingDto rating;

  const ProductDto({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] ?? '',
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      rating: RatingDto.fromJson(json['rating']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }

  /// Convert DTO to domain entity
  Product toEntity() {
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating.toEntity(),
    );
  }

  /// Create DTO from domain entity
  factory ProductDto.fromEntity(Product entity) {
    return ProductDto(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      description: entity.description,
      category: entity.category,
      image: entity.image,
      rating: RatingDto.fromEntity(entity.rating),
    );
  }
}
