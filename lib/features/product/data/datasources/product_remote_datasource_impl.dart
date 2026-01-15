import 'package:flutter_commerce/core/network/api_end_points.dart';
import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:flutter_commerce/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_commerce/features/product/data/models/product_dto.dart';

/// Implementation of ProductRemoteDataSource using Dio
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioHelper dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductDto>> getProducts() async {
    final response = await dio.get(ApiEndpoints.products);

    if (response.data == null || response.data is! List) {
      throw Exception('Products data is null or invalid');
    }

    final data = response.data as List;
    return data.map((json) => ProductDto.fromJson(json)).toList();
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await dio.get(ApiEndpoints.categories);

    if (response.data == null || response.data is! List) {
      throw Exception('Categories data is null or invalid');
    }

    final data = response.data as List;
    return data.map((item) => item.toString()).toList();
  }

  @override
  Future<ProductDto> getProductById(int productId) async {
    final response = await dio.get('${ApiEndpoints.products}/$productId');

    if (response.data == null) {
      throw Exception('Product data is null');
    }

    return ProductDto.fromJson(response.data);
  }

  @override
  Future<List<ProductDto>> getProductsByCategory(String category) async {
    final response = await dio.get(
      '${ApiEndpoints.products}/category/$category',
    );

    if (response.data == null || response.data is! List) {
      throw Exception('Products data is null or invalid');
    }

    final data = response.data as List;
    return data.map((json) => ProductDto.fromJson(json)).toList();
  }
}
