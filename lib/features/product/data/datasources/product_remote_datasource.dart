import 'package:flutter_commerce/features/product/data/models/product_dto.dart';

/// Abstract interface for product remote data source
abstract class ProductRemoteDataSource {
  /// Fetch all products
  Future<List<ProductDto>> getProducts();

  /// Fetch all categories
  Future<List<String>> getCategories();

  /// Fetch product by ID
  Future<ProductDto> getProductById(int productId);

  /// Fetch products by category
  Future<List<ProductDto>> getProductsByCategory(String category);
}
