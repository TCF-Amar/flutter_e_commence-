import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/features/auth/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

class ProfileDetail extends StatelessWidget {
  final AuthController authController;
  const ProfileDetail({super.key, required this.authController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Center(
        child: Column(
          spacing: 10,
          children: [
            CircleAvatar(
              radius: 50,
              child: Image.network(
                authController.user?.avatar ?? "",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, size: 50);
                },
              ),
            ),
            AppText(
              authController.user?.name.capitalize ?? 'Guest',
              color: context.textColors.primary,
              fontSize: 18,
            ),
            AppText(
              authController.user?.email ?? 'No email',
              color: context.textColors.primary,
              fontSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
