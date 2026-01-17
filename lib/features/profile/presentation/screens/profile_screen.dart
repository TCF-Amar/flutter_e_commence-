import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';

import 'package:flutter_commerce/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_commerce/features/profile/presentation/widgets/logout_button.dart';
import 'package:flutter_commerce/features/profile/presentation/widgets/profile_detail.dart';
import 'package:flutter_commerce/features/profile/presentation/widgets/setting_button.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const AppText("Me", fontSize: 24, fontWeight: FontWeight.bold),
            ProfileDetail(authController: authController),
            const SettingButton(),
            LogoutButton(authController: authController),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
