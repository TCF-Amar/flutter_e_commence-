import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:flutter_commerce/features/auth/data/models/login_request_dto.dart';
import 'package:flutter_commerce/features/auth/data/models/login_response_dto.dart';
import 'package:flutter_commerce/features/auth/data/models/user_model.dart';
import 'package:flutter_commerce/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_commerce/features/auth/domain/entities/login_credentials.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthRemoteDataSourceImpl {}

void main() {
  late MockAuthRemoteDataSource mockDataSource;
  late AuthRepositoryImpl repository;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(const LoginRequestDto(email: '', password: ''));
  });

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
  });

  group('AuthRepository - login', () {
    test('should return LoginResponse when login is successful', () async {
      // Arrange
      const credentials = LoginCredentials(
        email: 'john@mail.com',
        password: 'changeme',
      );

      final mockResponse = LoginResponseDto(
        accessToken: 'test_access_token',
        refreshToken: 'test_refresh_token',
      );

      when(
        () => mockDataSource.login(any()),
      ).thenAnswer((_) async => Right(mockResponse));

      // Act
      final result = await repository.login(credentials);

      // Assert
      expect(result.isRight, true);
      result.fold((l) => fail('Expected success'), (response) {
        expect(response.accessToken, 'test_access_token');
        expect(response.refreshToken, 'test_refresh_token');
      });

      verify(() => mockDataSource.login(any())).called(1);
    });

    test('should return Failure when login fails', () async {
      // Arrange
      const credentials = LoginCredentials(
        email: 'wrong@mail.com',
        password: 'wrongpassword',
      );

      final failure = UnknownFailure('Invalid credentials');

      when(
        () => mockDataSource.login(any()),
      ).thenAnswer((_) async => Left(failure));

      // Act
      final result = await repository.login(credentials);

      // Assert
      expect(result.isLeft, true);
      result.fold((failure) {
        expect(failure, isA<Failure>());
      }, (r) => fail('Expected failure'));
    });
  });

  group('AuthRepository - getLoginUser', () {
    test('should return User when fetching user is successful', () async {
      // Arrange
      const accessToken = 'valid_access_token';

      final mockUser = UserModel(
        id: 1,
        email: 'john@mail.com',
        password: 'changeme',
        name: 'John Doe',
        role: 'customer',
        avatar: 'https://example.com/avatar.jpg',
      );

      when(
        () => mockDataSource.getLoginuser(any()),
      ).thenAnswer((_) async => mockUser);

      // Act
      final result = await repository.getLoginUser(accessToken);

      // Assert
      expect(result.isRight, true);
      result.fold((l) => fail('Expected success'), (user) {
        expect(user.id, 1);
        expect(user.email, 'john@mail.com');
        expect(user.name, 'John Doe');
      });

      verify(() => mockDataSource.getLoginuser(accessToken)).called(1);
    });

    test('should return Failure when fetching user fails', () async {
      // Arrange
      const accessToken = 'invalid_token';

      when(
        () => mockDataSource.getLoginuser(any()),
      ).thenThrow(Exception('Unauthorized'));

      // Act
      final result = await repository.getLoginUser(accessToken);

      // Assert
      expect(result.isLeft, true);
      result.fold(
        (failure) => expect(failure, isA<Failure>()),
        (r) => fail('Expected failure'),
      );
    });
  });
}
