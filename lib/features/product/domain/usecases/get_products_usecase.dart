import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';
import 'package:flutter_commerce/features/product/domain/repositories/product_repository.dart';

/// Use case for fetching all products
class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  /// Execute get products
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getProducts();
  }
}
