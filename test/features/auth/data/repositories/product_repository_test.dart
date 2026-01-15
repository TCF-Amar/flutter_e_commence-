import 'package:dio/dio.dart';
import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/network/api_end_points.dart';
import 'package:flutter_commerce/core/network/dio_helper.dart';

import 'package:flutter_commerce/features/product/models/product_model.dart';
import 'package:flutter_commerce/features/product/repositories/product_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements DioHelper {}

void main() {
  late MockDio mockDio;
  late ProductRepository repository;

  setUpAll(() async {
    await dotenv.load(fileName: ".env.development");
    registerFallbackValue(Options());
  });

  setUp(() {
    mockDio = MockDio();
    repository = ProductRepository(mockDio);
  });

  group('ProductRepository - getProducts', () {
    test(
      'should return list of products when API call is successful',
      () async {
        final mockProductData = [
          {
            'id': 1,
            'title': 'Test Product 1',
            'price': 99.99,
            'description': 'Test Description 1',
            'category': 'electronics',
            'image': 'https://example.com/image1.jpg',
            'rating': {'rate': 4.5, 'count': 100},
          },
          {
            'id': 2,
            'title': 'Test Product 2',
            'price': 149.99,
            'description': 'Test Description 2',
            'category': 'clothing',
            'image': 'https://example.com/image2.jpg',
            'rating': {'rate': 4.0, 'count': 50},
          },
        ];

        when(
          () => mockDio.get<List<dynamic>>(
            ApiEndpoints.products,
            queryParameters: null,
          ),
        ).thenAnswer(
          (_) async => Response(
            data: mockProductData,
            requestOptions: RequestOptions(path: ApiEndpoints.products),
          ),
        );

        // Act
        final result = await repository.getProducts();

        // Assert
        expect(result.isRight, true);
        result.fold((l) => fail('Expected success'), (products) {
          expect(products, isA<List<ProductModel>>());
          expect(products.isNotEmpty, true);
          expect(products.length, 2);

          final firstProduct = products[0];
          expect(firstProduct.id, 1);
          expect(firstProduct.title, 'Test Product 1');
          expect(firstProduct.price, 99.99);
          expect(firstProduct.description, 'Test Description 1');
          expect(firstProduct.category, 'electronics');
          expect(firstProduct.image, 'https://example.com/image1.jpg');
          expect(firstProduct.rating.rate, 4.5);
          expect(firstProduct.rating.count, 100);
        });
      },
    );

    test('should return empty list when API returns empty array', () async {
      // Arrange
      when(
        () => mockDio.get<List<dynamic>>(
          ApiEndpoints.products,
          queryParameters: null,
        ),
      ).thenAnswer(
        (_) async => Response(
          data: [],
          requestOptions: RequestOptions(path: ApiEndpoints.products),
        ),
      );

      // Act
      final result = await repository.getProducts();

      // Assert
      expect(result.isRight, true);
      result.fold((l) => fail('Expected success'), (products) {
        expect(products.isEmpty, true);
        expect(products, isA<List<ProductModel>>());
        expect(products.length, 0);
      });
    });

    test('should return Failure when API call fails with 401', () async {
      // Arrange
      when(
        () => mockDio.get<List<dynamic>>(
          ApiEndpoints.products,
          queryParameters: null,
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ApiEndpoints.products),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: ApiEndpoints.products),
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      // Act
      final result = await repository.getProducts();

      // Assert
      expect(result.isLeft, true);
      result.fold((failure) {
        expect(failure, isA<Failure>());
      }, (r) => fail('Expected failure'));
    });

    test('should return Failure when API call fails with 404', () async {
      // Arrange
      when(
        () => mockDio.get<List<dynamic>>(
          ApiEndpoints.products,
          queryParameters: null,
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ApiEndpoints.products),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: ApiEndpoints.products),
          ),
        ),
      );

      // Act
      final result = await repository.getProducts();

      // Assert
      expect(result.isLeft, true);
      result.fold(
        (failure) => expect(failure, isA<Failure>()),
        (r) => fail('Expected failure'),
      );
    });

    test('should return Failure when API call fails with 500', () async {
      // Arrange
      when(
        () => mockDio.get<List<dynamic>>(
          ApiEndpoints.products,
          queryParameters: null,
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ApiEndpoints.products),
          response: Response(
            statusCode: 500,
            data: 'Internal Server Error',
            requestOptions: RequestOptions(path: ApiEndpoints.products),
          ),
        ),
      );

      // Act
      final result = await repository.getProducts();

      // Assert
      expect(result.isLeft, true);
      result.fold(
        (failure) => expect(failure, isA<Failure>()),
        (r) => fail('Expected failure'),
      );
    });

    test('should return Failure when network error occurs', () async {
      // Arrange
      when(
        () => mockDio.get<List<dynamic>>(
          ApiEndpoints.products,
          queryParameters: null,
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ApiEndpoints.products),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      // Act
      final result = await repository.getProducts();

      // Assert
      expect(result.isLeft, true);
      result.fold(
        (failure) => expect(failure, isA<Failure>()),
        (r) => fail('Expected failure'),
      );
    });

    test('should handle malformed JSON gracefully', () async {
      // Arrange
      final malformedData = [
        {
          'id': 1,
          'title': 'Test Product',
          // Missing required fields like price, description, etc.
        },
      ];

      when(
        () => mockDio.get<List<dynamic>>(
          ApiEndpoints.products,
          queryParameters: null,
        ),
      ).thenAnswer(
        (_) async => Response(
          data: malformedData,
          requestOptions: RequestOptions(path: ApiEndpoints.products),
        ),
      );

      // Act & Assert
      expect(() => repository.getProducts(), throwsA(isA<TypeError>()));
    });

    test('should return Failure when connection timeout occurs', () async {
      // Arrange
      when(
        () => mockDio.get<List<dynamic>>(
          ApiEndpoints.products,
          queryParameters: null,
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ApiEndpoints.products),
          type: DioExceptionType.connectionTimeout,
          message: 'Connection timeout',
        ),
      );

      // Act
      final result = await repository.getProducts();

      // Assert
      expect(result.isLeft, true);
      result.fold((failure) {
        expect(failure, isA<Failure>());
      }, (r) => fail('Expected failure'));
    });

    test('should return Failure when receive timeout occurs', () async {
      // Arrange
      when(
        () => mockDio.get<List<dynamic>>(
          ApiEndpoints.products,
          queryParameters: null,
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ApiEndpoints.products),
          type: DioExceptionType.receiveTimeout,
          message: 'Receive timeout',
        ),
      );

      // Act
      final result = await repository.getProducts();

      // Assert
      expect(result.isLeft, true);
      result.fold(
        (failure) => expect(failure, isA<Failure>()),
        (r) => fail('Expected failure'),
      );
    });

    test('should parse products with all fields correctly', () async {
      // Arrange
      final completeProductData = [
        {
          'id': 1,
          'title': 'Fjallraven - Foldsack No. 1 Backpack',
          'price': 109.95,
          'description': 'Your perfect pack for everyday use',
          'category': 'men\'s clothing',
          'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
          'rating': {'rate': 3.9, 'count': 120},
        },
      ];

      when(
        () => mockDio.get<List<dynamic>>(
          ApiEndpoints.products,
          queryParameters: null,
        ),
      ).thenAnswer(
        (_) async => Response(
          data: completeProductData,
          requestOptions: RequestOptions(path: ApiEndpoints.products),
        ),
      );

      // Act
      final result = await repository.getProducts();

      // Assert
      expect(result.isRight, true);
      result.fold((l) => fail('Expected success'), (products) {
        expect(products.length, 1);
        final product = products[0];
        expect(product.id, 1);
        expect(product.title, 'Fjallraven - Foldsack No. 1 Backpack');
        expect(product.price, 109.95);
        expect(product.description, 'Your perfect pack for everyday use');
        expect(product.category, 'men\'s clothing');
        expect(
          product.image,
          'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
        );
        expect(product.rating.rate, 3.9);
        expect(product.rating.count, 120);
      });
    });
  });
}
