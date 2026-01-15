import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';

/// Abstract repository interface for product operations
/// This defines the contract that data layer must implement
abstract class ProductRepository {
  /// Fetch all products
  /// Returns Either<Failure, List<Product>>
  Future<Either<Failure, List<Product>>> getProducts();

  /// Fetch all categories
  /// Returns Either<Failure, List<String>>
  Future<Either<Failure, List<String>>> getCategories();

  /// Fetch products by category
  /// Returns Either<Failure, List<Product>>
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category);

  /// Fetch product by ID
  /// Returns Either<Failure, Product>
  Future<Either<Failure, Product>> getProductById(int productId);
}
