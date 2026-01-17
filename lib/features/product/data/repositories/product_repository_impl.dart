import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_commerce/features/product/data/models/category_dto.dart';
import 'package:flutter_commerce/features/product/data/models/product_dto.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';
import 'package:flutter_commerce/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductDto>>> getProducts({
    int? offset,
    int? limit,
  }) async {
    final result = await remoteDataSource.getProducts(
      offset: offset!,
      limit: limit!,
    );
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<CategoryDto>>> getCategories() async {
    final result = await remoteDataSource.getCategories();
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }

  @override
  Future<Either<Failure, ProductDto>> getProductById(int productId) async {
    final result = await remoteDataSource.getProductById(productId);
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<ProductDto>>> getProductsByCategory(
    String category,
  ) async {
    final result = await remoteDataSource.getProductsByCategory(category);
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<ProductDto>>> getSimilarProducts(
    String category,
  ) async {
    final result = await remoteDataSource.getSimilarProducts(category);
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsBySearch(
    String search,
  ) async {
    final result = await remoteDataSource.getProductsBySearch(search);
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }
}
