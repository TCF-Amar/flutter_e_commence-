import 'package:dio/dio.dart';
import 'package:flutter_commerce/core/error/dio_failure_mapper.dart';
import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';
import 'package:flutter_commerce/features/product/domain/repositories/product_repository.dart';

/// Implementation of ProductRepository
/// Coordinates between data sources and domain layer
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final productDtos = await remoteDataSource.getProducts();
      final products = productDtos.map((dto) => dto.toEntity()).toList();
      return Right(products);
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int productId) async {
    try {
      final productDto = await remoteDataSource.getProductById(productId);
      return Right(productDto.toEntity());
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final productDtos = await remoteDataSource.getProductsByCategory(
        category,
      );
      final products = productDtos.map((dto) => dto.toEntity()).toList();
      return Right(products);
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
