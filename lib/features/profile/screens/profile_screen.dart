import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/routes/app_routes.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppText("Profile", color: context.textColors.primary, fontSize: 24),
          GestureDetector(
            onTap: () {
              context.push(AppRoutes.settings.path);
            },
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.card,
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  AppText(
                    "Settings",
                    color: context.textColors.primary,
                    fontSize: 18,
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
