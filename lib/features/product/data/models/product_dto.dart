import 'package:flutter_commerce/features/product/data/models/category_dto.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';

/// DTO for Product
/// Handles JSON serialization/deserialization and conversion to/from domain entity
class ProductDto extends Product {
  const ProductDto({
    required super.id,
    required super.title,
    required super.slug,
    required super.price,
    required super.description,
    required super.category,
    required super.images,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? '',
      category: CategoryDto.fromJson(json['category']),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': {
        'id': category.id,
        'name': category.name,
        'slug': category.slug,
        'image': category.image,
      },
      'images': images,
    };
  }

  /// Convert DTO to domain entity
  Product toEntity() {
    return Product(
      id: id,
      title: title,
      slug: slug,
      price: price,
      description: description,
      category: category,
      images: images,
    );
  }

  /// Create DTO from domain entity
  factory ProductDto.fromEntity(Product entity) {
    return ProductDto(
      id: entity.id,
      title: entity.title,
      slug: entity.slug,
      price: entity.price,
      description: entity.description,
      category: entity.category,
      images: entity.images,
    );
  }
}
