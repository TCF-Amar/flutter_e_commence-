import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/product/domain/entities/category.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';

/// Abstract repository interface for product operations
/// This defines the contract that data layer must implement
abstract class ProductRepository {
  /// Fetch all products
  /// Returns Either<Failure, List<Product>>
  /// Fetch all products
  /// Returns Either<Failure, List<Product>>
  Future<Either<Failure, List<Product>>> getProducts({int? offset, int? limit});

  /// Fetch all categories
  /// Returns Either<Failure, List<CategoryDto>>
  Future<Either<Failure, List<Category>>> getCategories();

  /// Fetch products by category
  /// Returns Either<Failure, List<Product>>
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category);

  /// Fetch product by ID
  /// Returns Either<Failure, Product>
  Future<Either<Failure, Product>> getProductById(int productId);

  Future<Either<Failure, List<Product>>> getSimilarProducts(String category);

  Future<Either<Failure, List<Product>>> getProductsBySearch(String search);
}
