import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/constants/colors/app_color_scheme.dart';

/// Extension to easily access AppColorScheme from BuildContext
extension ThemeExtensions on BuildContext {
  /// Access the app's color scheme
  AppColorScheme get colorScheme {
    return Theme.of(this).extension<AppColorScheme>()!;
  }
}
