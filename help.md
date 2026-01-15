# Flutter Commerce - Theme System Guide

This guide explains how to use colors and sizes in the Flutter Commerce app for consistent theming across light and dark modes.

---

## Table of Contents

1. [Using Colors](#using-colors)
2. [Using Sizes](#using-sizes)
3. [Using Text Colors](#using-text-colors)
4. [Best Practices](#best-practices)
5. [Quick Reference](#quick-reference)

---

## Using Colors

### Method 1: Using Context Extension (Recommended ✅)

Import the theme extensions and access colors directly from context:

```dart
import 'package:flutter_commerce/core/theme/theme_extensions.dart';

// In your widget:
Container(
  color: context.colorScheme.background,
  child: Card(
    color: context.colorScheme.card,
    child: Text(
      'Hello World',
      style: TextStyle(color: context.colorScheme.textPrimary),
    ),
  ),
)
```

### Method 2: Using AppColors Directly

For static colors that don't change with theme:

```dart
import 'package:flutter_commerce/core/constants/colors/app_colors.dart';

Container(
  color: AppColors.primary,
  child: Icon(Icons.star, color: AppColors.secondary),
)
```

### Method 3: Using Theme.of(context)

Manual access to theme extensions:

```dart
final colorScheme = Theme.of(context).extension<AppColorScheme>()!;

Container(
  color: colorScheme.surface,
  child: Text('Hello', style: TextStyle(color: colorScheme.textPrimary)),
)
```

---

## Available Colors

### Brand Colors

- `context.colorScheme.primary` - Primary brand color (teal green)
- `context.colorScheme.secondary` - Secondary brand color (orange)
- `context.colorScheme.accent` - Accent color (cyan)

### Surface Colors

- `context.colorScheme.background` - Screen background
- `context.colorScheme.surface` - Elevated surface (slightly different from background)
- `context.colorScheme.card` - Card background

### UI Element Colors

- `context.colorScheme.border` - Border lines
- `context.colorScheme.divider` - Dividers and separators
- `context.colorScheme.icon` - Icon tint color
- `context.colorScheme.disabled` - Disabled state color
- `context.colorScheme.shadow` - Shadow color
- `context.colorScheme.overlay` - Overlay/scrim color
- `context.colorScheme.badge` - Badge and notification dot color

### Text Colors

- `context.colorScheme.textPrimary` - Primary text color
- `context.colorScheme.textSecondary` - Secondary/hint text color

### Semantic Colors

- `context.colorScheme.success` - Success state (green)
- `context.colorScheme.warning` - Warning state (orange)
- `context.colorScheme.error` - Error state (red)
- `context.colorScheme.info` - Info state (blue)

---

## Using Sizes

### Accessing Sizes

First, you need to add AppSizes to your theme extensions if not already done:

```dart
// In app_theme.dart, add to extensions:
extensions: [
  AppSizes(
    xs: 4.0,
    sm: 8.0,
    md: 16.0,
    lg: 24.0,
    radius: 12.0,
  ),
  // ... other extensions
]
```

### Using Sizes in Widgets

```dart
final sizes = Theme.of(context).extension<AppSizes>()!;

Container(
  padding: EdgeInsets.all(sizes.md), // 16.0
  margin: EdgeInsets.symmetric(
    horizontal: sizes.lg, // 24.0
    vertical: sizes.sm,   // 8.0
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(sizes.radius), // 12.0
  ),
  child: Icon(Icons.star, size: sizes.lg),
)
```

### Available Sizes

- `sizes.xs` - Extra Small (4.0)
- `sizes.sm` - Small (8.0)
- `sizes.md` - Medium (16.0)
- `sizes.lg` - Large (24.0)
- `sizes.radius` - Border radius (12.0)

---

## Using Text Colors

Access semantic text colors using the text color extension:

```dart
final textColors = Theme.of(context).extension<AppTextColors>()!;

Text(
  'Success!',
  style: TextStyle(color: textColors.success),
)

Text(
  'Error occurred',
  style: TextStyle(color: textColors.error),
)

Text(
  'Click here',
  style: TextStyle(
    color: textColors.link,
    decoration: TextDecoration.underline,
  ),
)
```

### Available Text Colors

- `textColors.primary` - Primary text
- `textColors.secondary` - Secondary text
- `textColors.success` - Success messages
- `textColors.warning` - Warning messages
- `textColors.error` - Error messages
- `textColors.link` - Hyperlinks

---

## Best Practices

### ✅ DO:

1. **Use context.colorScheme for theme-aware colors**

   ```dart
   // Good - adapts to light/dark theme
   color: context.colorScheme.background
   ```

2. **Use semantic colors for consistent meaning**

   ```dart
   // Good - clear intent
   color: context.colorScheme.error
   ```

3. **Use sizes for consistent spacing**

   ```dart
   // Good - maintains design system
   padding: EdgeInsets.all(sizes.md)
   ```

4. **Import theme extensions at the top**
   ```dart
   import 'package:flutter_commerce/core/theme/theme_extensions.dart';
   ```

### ❌ DON'T:

1. **Hardcode colors directly**

   ```dart
   // Bad - doesn't adapt to theme
   color: Color(0xFF185951)
   ```

2. **Use arbitrary numeric values for spacing**

   ```dart
   // Bad - breaks design consistency
   padding: EdgeInsets.all(17.3)
   ```

3. **Mix theme colors with hardcoded colors**
   ```dart
   // Bad - inconsistent approach
   Container(
     color: context.colorScheme.background,
     child: Text('Hello', style: TextStyle(color: Colors.red)),
   )
   ```

---

## Complete Examples

### Example 1: Product Card

```dart
import 'package:flutter_commerce/core/theme/theme_extensions.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final bool inStock;

  const ProductCard({
    required this.title,
    required this.price,
    required this.inStock,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = Theme.of(context).extension<AppSizes>()!;

    return Card(
      color: context.colorScheme.card,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(sizes.radius),
        side: BorderSide(color: context.colorScheme.border),
      ),
      child: Padding(
        padding: EdgeInsets.all(sizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: context.colorScheme.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: sizes.sm),
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyle(
                color: context.colorScheme.secondary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: sizes.xs),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: sizes.sm,
                vertical: sizes.xs,
              ),
              decoration: BoxDecoration(
                color: inStock ? context.colorScheme.success : context.colorScheme.error,
                borderRadius: BorderRadius.circular(sizes.xs),
              ),
              child: Text(
                inStock ? 'In Stock' : 'Out of Stock',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Example 2: Custom Button

```dart
import 'package:flutter_commerce/core/theme/theme_extensions.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const PrimaryButton({
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = Theme.of(context).extension<AppSizes>()!;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorScheme.primary,
        disabledBackgroundColor: context.colorScheme.disabled,
        padding: EdgeInsets.symmetric(
          horizontal: sizes.lg,
          vertical: sizes.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sizes.radius),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  context.colorScheme.textPrimary,
                ),
              ),
            )
          : Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}
```

### Example 3: Status Badge

```dart
import 'package:flutter_commerce/core/theme/theme_extensions.dart';

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

class StatusBadge extends StatelessWidget {
  final OrderStatus status;

  const StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final sizes = Theme.of(context).extension<AppSizes>()!;

    Color getStatusColor() {
      switch (status) {
        case OrderStatus.pending:
          return context.colorScheme.warning;
        case OrderStatus.processing:
          return context.colorScheme.info;
        case OrderStatus.shipped:
          return context.colorScheme.accent;
        case OrderStatus.delivered:
          return context.colorScheme.success;
        case OrderStatus.cancelled:
          return context.colorScheme.error;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: sizes.sm,
        vertical: sizes.xs,
      ),
      decoration: BoxDecoration(
        color: getStatusColor().withOpacity(0.1),
        border: Border.all(color: getStatusColor()),
        borderRadius: BorderRadius.circular(sizes.radius),
      ),
      child: Text(
        status.toString().split('.').last.toUpperCase(),
        style: TextStyle(
          color: getStatusColor(),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
```

---

## Quick Reference

### Common Patterns

**Divider:**

```dart
Divider(color: context.colorScheme.divider, height: 1)
```

**Icon with theme color:**

```dart
Icon(Icons.star, color: context.colorScheme.icon)
```

**Shadow:**

```dart
BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: context.colorScheme.shadow,
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ],
)
```

**Overlay/Scrim:**

```dart
Container(
  color: context.colorScheme.overlay,
  // Semi-transparent overlay
)
```

**Badge/Notification indicator:**

```dart
Container(
  width: 8,
  height: 8,
  decoration: BoxDecoration(
    color: context.colorScheme.badge,
    shape: BoxShape.circle,
  ),
)
```

---

## Summary

- ✅ Use `context.colorScheme.*` for all theme-aware colors
- ✅ Use `sizes.*` for consistent spacing and dimensions
- ✅ Use semantic colors (`success`, `error`, `warning`, `info`) for consistent meaning
- ✅ Import `theme_extensions.dart` for easy access
- ✅ Let the theme system handle light/dark mode automatically

**Happy coding! 🚀**
