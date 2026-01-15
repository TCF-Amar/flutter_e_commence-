import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';
import 'package:flutter_commerce/features/product/domain/repositories/product_repository.dart';

/// Use case for fetching products by category
class GetProductsByCategoryUseCase {
  final ProductRepository repository;

  GetProductsByCategoryUseCase(this.repository);

  /// Execute get products by category
  Future<Either<Failure, List<Product>>> call(String category) async {
    if (category.isEmpty) {
      return Left(NetworkFailure('Category cannot be empty'));
    }

    return await repository.getProductsByCategory(category);
  }
}
