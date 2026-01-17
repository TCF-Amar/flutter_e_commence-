import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/product/domain/entities/category.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';
import 'package:flutter_commerce/features/product/domain/repositories/product_repository.dart';

class ProductUsecase {
  final ProductRepository repository;

  ProductUsecase(this.repository);

  Future<Either<Failure, List<Category>>> getCategories() async {
    return await repository.getCategories();
  }

  Future<Either<Failure, Product>> getProductById(int id) async {
    return await repository.getProductById(id);
  }

  Future<Either<Failure, List<Product>>> getProductsByCategory(
    String category,
  ) async {
    if (category.isEmpty) {
      return Left(NetworkFailure('Category cannot be empty'));
    }

    return await repository.getProductsByCategory(category);
  }

  /// Execute get products
  Future<Either<Failure, List<Product>>> getProducts({
    int? offset,
    int? limit,
  }) async {
    return await repository.getProducts(offset: offset, limit: limit);
  }

  Future<Either<Failure, List<Product>>> getProductsBySearch(
    String search,
  ) async {
    return await repository.getProductsBySearch(search);
  }

  Future<Either<Failure, List<Product>>> getSimilarProducts(
    String category,
  ) async {
    return await repository.getSimilarProducts(category);
  }
}
