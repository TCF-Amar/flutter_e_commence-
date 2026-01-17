import 'package:flutter_commerce/features/product/domain/entities/category.dart';

class CategoryDto extends Category {
  CategoryDto({
    required super.id,
    required super.name,
    required super.slug,
    required super.image,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'slug': slug, 'image': image};
  }
}
