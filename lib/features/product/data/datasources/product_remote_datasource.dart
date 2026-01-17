import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/product/data/models/category_dto.dart';
import 'package:flutter_commerce/features/product/data/models/product_dto.dart';

/// Abstract interface for product remote data source
abstract class ProductRemoteDataSource {
  /// Fetch all products
  Future<Either<Failure, List<ProductDto>>> getProducts({
    int offset,
    int limit,
  });

  /// Fetch all categories
  Future<Either<Failure, List<CategoryDto>>> getCategories();

  /// Fetch product by ID
  Future<Either<Failure, ProductDto>> getProductById(int productId);

  /// Fetch products by category
  Future<Either<Failure, List<ProductDto>>> getProductsByCategory(
    String category,
  );

  Future<Either<Failure, List<ProductDto>>> getSimilarProducts(String category);

  Future<Either<Failure, List<ProductDto>>> getProductsBySearch(String search);
}
