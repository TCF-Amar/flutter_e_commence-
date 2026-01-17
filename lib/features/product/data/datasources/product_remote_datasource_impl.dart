import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/network/api_end_points.dart';
import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_commerce/features/product/data/models/category_dto.dart';
import 'package:flutter_commerce/features/product/data/models/product_dto.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioHelper dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, List<ProductDto>>> getProducts({
    int? offset,
    int? limit,
  }) async {
    try {
      final response = await dio.get(
        ApiEndpoints.products,
        queryParameters: {'offset': offset, 'limit': limit},
      );
      if (response.data == null || response.data is! List) {
        throw Exception('Products data is null or invalid');
      }
      final data = response.data as List;
      return Right(data.map((json) => ProductDto.fromJson(json)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryDto>>> getCategories() async {
    try {
      final response = await dio.get(ApiEndpoints.categories);
      if (response.data == null || response.data is! List) {
        throw Exception('Categories data is null or invalid');
      }
      final data = response.data as List;
      return Right(data.map((json) => CategoryDto.fromJson(json)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductDto>> getProductById(int productId) async {
    try {
      final response = await dio.get('${ApiEndpoints.products}/$productId');
      if (response.data == null) {
        throw Exception('Product data is null');
      }
      return Right(ProductDto.fromJson(response.data));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductDto>>> getProductsByCategory(
    String categorySlug,
  ) async {
    try {
      final response = await dio.get(
        ApiEndpoints.products,
        queryParameters: {"categorySlug": categorySlug},
      );

      if (response.data == null || response.data is! List) {
        throw Exception('Products data is null or invalid');
      }

      final data = response.data as List;
      return Right(data.map((json) => ProductDto.fromJson(json)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductDto>>> getSimilarProducts(
    String category,
  ) async {
    try {
      final response = await dio.get(ApiEndpoints.relatedProduct(category));

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      List<dynamic> data;
      if (response.data is List) {
        data = response.data;
      } else if (response.data is Map<String, dynamic>) {
        if (response.data['data'] is List) {
          data = response.data['data'];
        } else {
          throw Exception('Expected List but got Map: ${response.data}');
        }
      } else {
        throw Exception('Invalid response type: ${response.data.runtimeType}');
      }

      return Right(data.map((json) => ProductDto.fromJson(json)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductDto>>> getProductsBySearch(
    String search,
  ) async {
    try {
      final response = await dio.get(
        ApiEndpoints.products,
        queryParameters: {'title': search},
      );

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      List<dynamic> data;
      if (response.data is List) {
        data = response.data;
      } else if (response.data is Map<String, dynamic>) {
        if (response.data['data'] is List) {
          data = response.data['data'];
        } else {
          throw Exception('Expected List but got Map: ${response.data}');
        }
      } else {
        throw Exception('Invalid response type: ${response.data.runtimeType}');
      }

      return Right(data.map((json) => ProductDto.fromJson(json)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
