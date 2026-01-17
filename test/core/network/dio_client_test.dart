import 'package:dio/dio.dart';
import 'package:flutter_commerce/core/environment/environment.dart';
import 'package:flutter_commerce/core/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DioClient dioClient;

  setUpAll(() async {
    await dotenv.load(fileName: '.env.development');
  });

  setUp(() {
    dioClient = DioClient();
  });

  group('DioClient', () {
    test('should return singleton instance', () {
      final instance1 = DioClient();
      final instance2 = DioClient();

      expect(instance1, same(instance2));
    });

    test('should have Dio instance configured', () {
      expect(dioClient.dio, isA<Dio>());
    });

    test('should have correct baseUrl from environment', () {
      expect(dioClient.dio.options.baseUrl, Environment.baseUrl);
    });

    test('should have correct timeout configurations', () {
      expect(dioClient.dio.options.connectTimeout, const Duration(seconds: 30));
      expect(dioClient.dio.options.receiveTimeout, const Duration(seconds: 30));
      expect(dioClient.dio.options.sendTimeout, const Duration(seconds: 30));
    });

    test('should have JSON response type', () {
      expect(dioClient.dio.options.responseType, ResponseType.json);
    });

    test('should have correct headers', () {
      expect(dioClient.dio.options.headers['Accept'], 'application/json');
      expect(dioClient.dio.options.headers['Content-Type'], 'application/json');
    });

    test('should have interceptors configured', () {
      expect(dioClient.dio.interceptors.isNotEmpty, true);
    });

    test('reset should clear and re-add interceptors', () {
      final initialInterceptorCount = dioClient.dio.interceptors.length;

      dioClient.reset();

      expect(dioClient.dio.interceptors.length, initialInterceptorCount);
    });
  });
}
