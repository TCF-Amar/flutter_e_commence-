import 'package:dio/dio.dart';
import 'package:flutter_commerce/core/error/dio_failure_mapper.dart';
import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/network/api_end_points.dart';
import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/product/models/product_model.dart';

class ProductRepository {
  final DioHelper dio;
  ProductRepository(this.dio);

  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final response = await dio.get(ApiEndpoints.products);

      final data = response.data;
      if (data == null || data is! List) {
        return Left(
          DioFailureMapper.map(DioException(requestOptions: RequestOptions())),
        );
      }

      final products = data.map((json) => ProductModel.fromJson(json)).toList();

      return Right(products);
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    }
  }

  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final response = await dio.get(ApiEndpoints.categories);

      final data = response.data;
      if (data == null || data is! List) {
        return Left(
          DioFailureMapper.map(DioException(requestOptions: RequestOptions())),
        );
      }

      final categories = data.map((item) => item.toString()).toList();

      return Right(categories);
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    }
  }
}
