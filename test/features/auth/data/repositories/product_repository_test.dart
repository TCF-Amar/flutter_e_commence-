import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_commerce/features/product/data/models/category_dto.dart';
import 'package:flutter_commerce/features/product/data/models/product_dto.dart';
import 'package:flutter_commerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRemoteDataSource extends Mock
    implements ProductRemoteDataSource {}

void main() {
  late MockProductRemoteDataSource mockDataSource;
  late ProductRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockProductRemoteDataSource();
    repository = ProductRepositoryImpl(mockDataSource);
  });

  group('ProductRepository - getProducts', () {
    test(
      'should return list of products when API call is successful',
      () async {
        final mockProductData = [
          ProductDto(
            id: 1,
            title: 'Test Product 1',
            slug: 'test-product-1',
            price: 99.99,
            description: 'Test Description 1',
            category: CategoryDto(
              id: 1,
              name: 'Electronics',
              slug: 'electronics',
              image: 'https://example.com/category.jpg',
            ),
            images: const ['https://example.com/image1.jpg'],
          ),
          ProductDto(
            id: 2,
            title: 'Test Product 2',
            slug: 'test-product-2',
            price: 149.99,
            description: 'Test Description 2',
            category: CategoryDto(
              id: 2,
              name: 'Clothing',
              slug: 'clothing',
              image: 'https://example.com/category2.jpg',
            ),
            images: const ['https://example.com/image2.jpg'],
          ),
        ];

        when(
          () => mockDataSource.getProducts(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => Right(mockProductData));

        // Act
        final result = await repository.getProducts(offset: 0, limit: 10);

        // Assert
        expect(result.isRight, true);
        result.fold((l) => fail('Expected success'), (products) {
          expect(products, isA<List<ProductDto>>());
          expect(products.isNotEmpty, true);
          expect(products.length, 2);

          final firstProduct = products[0];
          expect(firstProduct.id, 1);
          expect(firstProduct.title, 'Test Product 1');
          expect(firstProduct.slug, 'test-product-1');
          expect(firstProduct.price, 99.99);
          expect(firstProduct.description, 'Test Description 1');
          expect(firstProduct.category.name, 'Electronics');
          expect(firstProduct.images[0], 'https://example.com/image1.jpg');
        });
      },
    );

    test('should return empty list when API returns empty array', () async {
      // Arrange
      when(
        () => mockDataSource.getProducts(
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => Right([]));

      // Act
      final result = await repository.getProducts(offset: 0, limit: 10);

      // Assert
      expect(result.isRight, true);
      result.fold((l) => fail('Expected success'), (products) {
        expect(products.isEmpty, true);
        expect(products, isA<List<ProductDto>>());
        expect(products.length, 0);
      });
    });

    
  });

  group('ProductRepository - getProductById', () {
    test('should return product when API call is successful', () async {
      // Arrange
      final mockProduct = ProductDto(
        id: 1,
        title: 'Test Product',
        slug: 'test-product',
        price: 99.99,
        description: 'Test Description',
        category:  CategoryDto(
          id: 1,
          name: 'Electronics',
          slug: 'electronics',
          image: 'https://example.com/category.jpg',
        ),
        images: const ['https://example.com/image1.jpg'],
      );

      when(
        () => mockDataSource.getProductById(any()),
      ).thenAnswer((_) async => Right(mockProduct));

      // Act
      final result = await repository.getProductById(1);

      // Assert
      expect(result.isRight, true);
      result.fold((l) => fail('Expected success'), (product) {
        expect(product, isA<ProductDto>());
        expect(product.id, 1);
        expect(product.title, 'Test Product');
        expect(product.slug, 'test-product');
      });
    });

    test('should return Failure when product not found', () async {
      // Arrange
      final failure = UnknownFailure("Product not found");

      when(
        () => mockDataSource.getProductById(any()),
      ).thenAnswer((_) async => Left(failure));

      // Act
      final result = await repository.getProductById(999);

      // Assert
      expect(result.isLeft, true);
      result.fold(
        (failure) => expect(failure, isA<Failure>()),
        (r) => fail('Expected failure'),
      );
    });
  });

  group('ProductRepository - getProductsByCategory', () {
    test('should return products for given category', () async {
      // Arrange
      final mockProducts = [
        ProductDto(
          id: 1,
          title: 'Electronics Product',
          slug: 'electronics-product',
          price: 99.99,
          description: 'Test Description',
          category:  CategoryDto(
            id: 1,
            name: 'Electronics',
            slug: 'electronics',
            image: 'https://example.com/category.jpg',
          ),
          images: const ['https://example.com/image1.jpg'],
        ),
      ];

      when(
        () => mockDataSource.getProductsByCategory(any()),
      ).thenAnswer((_) async => Right(mockProducts));

      // Act
      final result = await repository.getProductsByCategory('electronics');

      // Assert
      expect(result.isRight, true);
      result.fold((l) => fail('Expected success'), (products) {
        expect(products.length, 1);
        expect(products[0].category.name, 'Electronics');
      });
    });
  });

  group('ProductRepository - getCategories', () {
    test('should return list of categories', () async {
      // Arrange
      final mockCategories = [
         CategoryDto(
          id: 1,
          name: 'Electronics',
          slug: 'electronics',
          image: 'https://example.com/category1.jpg',
        ),
         CategoryDto(
          id: 2,
          name: 'Clothing',
          slug: 'clothing',
          image: 'https://example.com/category2.jpg',
        ),
      ];

      when(
        () => mockDataSource.getCategories(),
      ).thenAnswer((_) async => Right(mockCategories));

      // Act
      final result = await repository.getCategories();

      // Assert
      expect(result.isRight, true);
      result.fold((l) => fail('Expected success'), (categories) {
        expect(categories.length, 2);
        expect(categories[0].name, 'Electronics');
        expect(categories[1].name, 'Clothing');
      });
    });
  });
}
