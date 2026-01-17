import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_bottom_confirm_alert.dart';
import 'package:flutter_commerce/features/auth/presentation/controllers/auth_controller.dart';

class LogoutButton extends StatelessWidget {
  final AuthController authController;
  const LogoutButton({super.key, required this.authController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final res = await showBottomConfirmAlert(
          context: context,
          title: "Logout",
          message: "Are you sure you want to logout?",
          confirmText: "Logout",
          cancelText: "Cancel",
          confirmBackgroundColor: context.colorScheme.error,
        );

        if (res) {
          authController.logout();
        }
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
            Text(
              "Logout",
              style: TextStyle(color: context.textColors.error, fontSize: 18),
            ),
            const Spacer(),
            Icon(Icons.logout, color: context.textColors.error),
          ],
        ),
      ),
    );
  }
}
