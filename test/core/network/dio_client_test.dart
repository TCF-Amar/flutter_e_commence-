// import 'package:dio/dio.dart';
// import 'package:flutter_commerce/core/environment/environment.dart';
// import 'package:flutter_commerce/core/network/dio_client.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockDio extends Mock implements Dio {}

// class MockInterceptors extends Mock implements Interceptors {}

// void main() {
//   late MockDio mockDio;
//   late DioClient dioClient;
//   late BaseOptions baseOptions;

//   setUpAll(() async {
//     await dotenv.load(fileName: '.env.development');
//   });

//   setUp(() {
//     mockDio = MockDio();
//     when(() => mockDio.interceptors).thenReturn(MockInterceptors());
//     baseOptions = BaseOptions(baseUrl: Environment.baseUrl);
//     when(() => mockDio.options).thenReturn(baseOptions);
//   });

//   test('should use injected Dio instance', () {
//     expect(dioClient.dio, mockDio);
//   });

//   test('should have correct baseUrl', () {
//     // dioClient = DioClient.create(dio: mockDio);

//     expect(dioClient.dio.options.baseUrl, Environment.baseUrl);
//   });

//   test('should throw exception when dio is null', () {
//     expect(dioClient.dio, isA<Dio>());
//   });
// }
