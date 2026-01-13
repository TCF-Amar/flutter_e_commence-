# Flutter Commerce - Test Directory Structure

## Overview

This test directory mirrors the `lib` folder structure to maintain consistency and organization.

## Directory Structure

```
test/
├── app/                          # App-level tests
├── core/                         # Core functionality tests
│   ├── constants/               # Constants tests
│   ├── database/                # Database tests
│   ├── DI/                      # Dependency injection tests
│   ├── environment/             # Environment configuration tests
│   ├── error/                   # Error handling tests
│   ├── network/                 # Network layer tests
│   ├── routes/                  # Routing tests
│   ├── theme/                   # Theme tests
│   ├── utils/                   # Utility tests
│   └── widgets/                 # Reusable widget tests
├── data/                        # Data layer tests
│   ├── models/                  # Model tests
│   ├── repositories/            # Repository tests
│   └── services/                # Service tests
└── modules/                     # Feature module tests
    ├── auth/                    # Authentication module
    │   ├── login/              # Login feature tests
    │   └── register/           # Registration feature tests
    ├── cart/                    # Shopping cart module
    │   └── widgets/            # Cart widget tests
    ├── category/                # Category module
    │   └── widgets/            # Category widget tests
    ├── checkout/                # Checkout module
    │   └── widgets/            # Checkout widget tests
    ├── home/                    # Home module
    │   └── widgets/            # Home widget tests
    ├── product/                 # Product module
    │   └── widgets/            # Product widget tests
    └── profile/                 # Profile module
        └── widgets/            # Profile widget tests
```

## Test Organization Guidelines

### Naming Convention

- Test files should match their source files with `_test.dart` suffix
- Example: `auth_repository.dart` → `auth_repository_test.dart`

### Test Types by Directory

#### Unit Tests

- `data/models/` - Model serialization/deserialization
- `data/repositories/` - Repository logic with mocked dependencies
- `core/utils/` - Utility functions
- `core/error/` - Error handling and mapping

#### Widget Tests

- `modules/*/widgets/` - Individual widget tests
- `core/widgets/` - Reusable widget tests

#### Integration Tests

- `modules/*/` - Feature flow tests
- `core/network/` - API integration tests

## Example Test Structure

```dart
// test/data/repositories/auth_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('AuthRepository', () {
    late AuthRepository repository;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      repository = AuthRepository(mockDio);
    });

    test('should login successfully', () async {
      // Arrange
      when(() => mockDio.post(...)).thenAnswer(...);

      // Act
      final result = await repository.login('user', 'pass');

      // Assert
      expect(result.isRight, true);
    });
  });
}
```

## Running Tests

```bash
# Run all tests
flutter test

# Run specific directory
flutter test test/data/repositories/

# Run specific file
flutter test test/data/repositories/auth_repository_test.dart

# Run with coverage
flutter test --coverage
```

## Best Practices

1. **Mirror Structure**: Keep test directory structure identical to lib
2. **One Test File Per Source**: Each source file should have one test file
3. **Group Related Tests**: Use `group()` to organize related test cases
4. **Mock External Dependencies**: Use mocktail for mocking
5. **Test Naming**: Use descriptive names that explain what is being tested
6. **Arrange-Act-Assert**: Follow AAA pattern in all tests
