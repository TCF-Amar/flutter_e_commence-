# flutter_commerce

A new Flutter project.
lib/
│
├── main.dart
│
├── app/
│   ├── app.dart
│   ├── app_binding.dart
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   ├── api_endpoints.dart
│   │   ├── payment_methods.dart
│   │   └── app_fonts.dart
│   │
│   ├── theme/
│   │   └── app_theme.dart
│   │
│   ├── network/
│   │   ├── dio_client.dart
│   │   ├── api_exception.dart
│   │   └── api_response.dart
│   │
│   ├── database/
│   │   ├── app_database.dart
│   │   ├── address_dao.dart
│   │   └── order_dao.dart
│   │
│   ├── routes/
│   │   ├── app_routes.dart
│   │   ├── app_router.dart   // GoRouter
│   │   └── route_guards.dart
│   │
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── helpers.dart
│   │   └── extensions.dart
│   │
│   └── widgets/
│       ├── app_button.dart
│       ├── app_textfield.dart
│       ├── product_card.dart
│       └── loading_view.dart
│
├── data/
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── product_model.dart
│   │   ├── category_model.dart
│   │   ├── cart_model.dart
│   │   ├── address_model.dart
│   │   └── order_model.dart
│   │
│   ├── repositories/
│   │   ├── auth_repository.dart
│   │   ├── product_repository.dart
│   │   ├── cart_repository.dart
│   │   ├── category_repository.dart
│   │   └── order_repository.dart
│   │
│   └── services/
│       ├── auth_service.dart
│       ├── product_service.dart
│       └── cart_service.dart
│
├── modules/
│   ├── auth/
│   │   ├── login/
│   │   │   ├── login_view.dart
│   │   │   ├── login_controller.dart
│   │   │   └── login_injector.dart
│   │   │   └── widgets/
│   │   │       ├── login_form.dart
│   │   │       ├── email_field.dart
│   │   │       ├── password_field.dart
│   │   │       └── login_button.dart
│   │
│   ├── home/
│   │   ├── home_view.dart
│   │   ├── home_controller.dart
│   │   └── home_injector.dart
│   │   └── widgets/
│   │       ├── home_app_bar.dart
│   │       ├── banner_slider.dart
│   │       ├── category_section.dart
│   │       ├── trending_section.dart
│   │       ├── sale_section.dart
│   │       └── product_horizontal_list.dart
│   │
│   ├── category/
│   │   ├── category_view.dart
│   │   ├── category_controller.dart
│   │   └── category_injector.dart
│   │   └── widgets/
│   │       ├── category_app_bar.dart
│   │       ├── filter_bar.dart
│   │       ├── product_grid.dart
│   │       └── sort_button.dart
│   │
│   ├── product/
│   │   ├── product_detail_view.dart
│   │   ├── product_controller.dart
│   │   └── product_injector.dart
│   │   └── widgets/
│   │       ├── product_image_slider.dart
│   │       ├── product_title_price.dart
│   │       ├── rating_view.dart
│   │       ├── product_description.dart
│   │       └── add_to_cart_button.dart
│   │
│   ├── cart/
│   │   ├── cart_view.dart
│   │   ├── cart_controller.dart
│   │   └── cart_injector.dart
│   │   └── widgets/
│   │       ├── cart_item_tile.dart
│   │       ├── quantity_stepper.dart
│   │       ├── cart_summary.dart
│   │       └── checkout_button.dart
│   │
│   ├── checkout/
│   │   ├── checkout_view.dart
│   │   ├── checkout_controller.dart
│   │   └── checkout_injector.dart
│   │   └── widgets/
│   │       ├── address_section.dart
│   │       ├── payment_section.dart
│   │       ├── order_summary.dart
│   │       └── place_order_button.dart
│   │
│   └── profile/
│       ├── profile_view.dart
│       ├── profile_controller.dart
│       └── profile_injector.dart
│       └── widgets/
│           ├── profile_header.dart
│           ├── profile_menu_tile.dart
│           ├── order_list_tile.dart
│           └── address_list_tile.dart
│
└── assets/
    ├── images/
    ├── icons/
    └── fonts/



# Flutter Commerce - Test Suite

## Overview

This directory contains comprehensive tests for the Flutter Commerce application.

## Test Structure

```
test/
├── core/
│   ├── error/
│   │   └── dio_failure_mapper_test.dart
│   └── utils/
│       └── either_test.dart
├── data/
│   ├── models/
│   │   └── login_response_test.dart
│   └── repositories/
│       └── auth_repository_test.dart
├── modules/
│   └── auth/
│       └── login/
│           └── login_controller_test.dart
├── helpers/
│   └── test_helpers.dart
└── README.md
```

## Running Tests

### Run all tests

```bash
flutter test
```

### Run specific test file

```bash
flutter test test/core/utils/either_test.dart
```

### Run tests with coverage

```bash
flutter test --coverage
```

### Generate coverage report

```bash
# Install lcov first (if not already installed)
# On Windows: choco install lcov
# On Mac: brew install lcov
# On Linux: sudo apt-get install lcov

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open the report
# Windows: start coverage/html/index.html
# Mac: open coverage/html/index.html
# Linux: xdg-open coverage/html/index.html
```

## Test Categories

### Unit Tests

- **Either**: Tests for the Either monad utility
- **DioFailureMapper**: Tests for error mapping from Dio exceptions
- **LoginResponse**: Tests for model serialization
- **AuthRepository**: Tests for authentication repository (requires mocking)
- **LoginController**: Tests for login controller logic

### Widget Tests

- Coming soon...

### Integration Tests

- Coming soon...

## Generating Mocks

This project uses `mockito` for mocking dependencies. To generate mocks:

```bash
flutter pub run build_runner build
```

Or watch for changes:

```bash
flutter pub run build_runner watch
```

## Test Best Practices

1. **Arrange-Act-Assert**: Follow the AAA pattern in all tests
2. **Descriptive Names**: Use clear, descriptive test names
3. **One Assertion**: Each test should verify one thing
4. **Mock External Dependencies**: Use mockito for external dependencies
5. **Clean Up**: Always dispose of resources in tearDown

## Dependencies for Testing

Add these to your `pubspec.yaml` under `dev_dependencies`:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  build_runner: ^2.4.8
```

## Known Issues

1. **AuthRepository Tests**: Currently commented out because AuthRepository creates its own DioClient. For proper testing, it should accept Dio as a constructor parameter.

2. **LoginController Tests**: Some tests are commented out because LoginController creates its own AuthRepository. For proper testing, it should accept AuthRepository as a constructor parameter.

## Improving Testability

To make the code more testable, consider these refactorings:

### 1. Dependency Injection in AuthRepository

```dart
class AuthRepository {
  final Dio _dio;

  // Constructor injection instead of creating DioClient internally
  AuthRepository(this._dio);
}
```

### 2. Dependency Injection in LoginController

```dart
class LoginController extends GetxController {
  final AuthRepository authRepository;

  // Constructor injection
  LoginController(this.authRepository);
}
```

### 3. Update Bindings

```dart
class LoginDI extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository(DioClient.instance.dio));
    Get.lazyPut<LoginController>(() => LoginController(Get.find()));
  }
}
```

## Contributing

When adding new features:

1. Write tests first (TDD approach)
2. Ensure all tests pass
3. Maintain test coverage above 80%
4. Update this README if adding new test categories
