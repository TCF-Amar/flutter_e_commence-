import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/product/domain/repositories/product_repository.dart';

/// Use case for fetching all categories
class GetCategoriesUseCase {
  final ProductRepository repository;

  GetCategoriesUseCase(this.repository);

  /// Execute get categories
  Future<Either<Failure, List<String>>> call() async {
    return await repository.getCategories();
  }
}
