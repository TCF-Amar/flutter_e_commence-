import 'package:dio/dio.dart';
import 'package:flutter_commerce/core/error/dio_failure_mapper.dart';
import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/network/api_end_points.dart';
import 'package:flutter_commerce/core/network/dio_client.dart';
import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/data/models/product_model.dart';

class ProductRepository {
  final DioHelper dioHelper;

  ProductRepository({Dio? dio}) : dioHelper = DioHelper(dio ?? DioClient().dio);

  /// Get all products from the API
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      // Using the convenience get() method
      final response = await dioHelper.get<List<dynamic>>(
        ApiEndpoints.products,
      );

      final data = response.data as List<dynamic>;
      final products = data.map((e) => ProductModel.fromJson(e)).toList();
      return Right(products);
    } on DioException catch (e) {
      return Left(DioFailureMapper.map(e));
    }
  }
}
