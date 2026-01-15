import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        title: const AppText('Cart', fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.cartShopping,
              size: 64,
              color: context.colorScheme.icon,
            ),
            const SizedBox(height: 16),
            AppText(
              'Your Cart is Empty',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: context.colorScheme.textPrimary,
            ),
            const SizedBox(height: 8),
            AppText(
              'Add items to your cart',
              fontSize: 14,
              color: context.colorScheme.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
