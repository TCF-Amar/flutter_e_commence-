import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_commerce/data/repositories/auth_repository.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late AuthRepository repository;

  setUpAll(() async {
    await dotenv.load(fileName: ".env.development");
    mockDio = MockDio();
    repository = AuthRepository();
  });

  // setUp(() {
  //   mockDio = MockDio();
  //   repository = AuthRepository();
  // });

  test("Login with valid credentials", () async {
    // final token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsInVzZXIiOiJqb2huZCIsImlhdCI6MTc2ODIwMjA0MH0.o-jG6R4RWI_BHBzkBajJZ6rm2mSjrg6g-C8e2DQYBmE";
    when(
      () => mockDio.request(
        any(),
        data: any(named: 'data'),
        queryParameters: any(named: 'queryParameters'),
        options: any(named: 'options'),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: {'token': "token"},
        requestOptions: RequestOptions(path: '/auth/login'),
      ),
    );

    final result = await repository.login("johnd", "m38rmF\$");

    expect(result.isRight, true);

    result.fold((_) => fail("Expected success"), (r) {
      debugPrint('✅ LOGIN SUCCESS');
      debugPrint('TOKEN: ${r.token}');
    });
  });

  test("Login with invalid credentials", () async {
    when(
      () => mockDio.request(
        any(),
        data: any(named: 'data'),
        queryParameters: any(named: 'queryParameters'),
        options: any(named: 'options'),
      ),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/auth/login'),
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: '/auth/login'),
        ),
      ),
    );

    final result = await repository.login("test", "wrong_password");

    expect(result.isLeft, true);

    result.fold(
      (l) => expect(l, isA<Failure>()),
      (_) => fail("Expected failure"),
    );
  });

 
}
