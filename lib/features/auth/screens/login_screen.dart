import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/constants/colors/app_colors.dart';
import 'package:flutter_commerce/core/widgets/app_button.dart';
import 'package:flutter_commerce/core/widgets/app_text_form_field.dart';
import 'package:flutter_commerce/features/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextFormField(
                  prefixIcon: const Icon(Icons.email_outlined),
                  controller: controller.usernameController,
                  hint: 'Username',
                  label: 'Username',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                AppTextFormField(
                  prefixIcon: const Icon(Icons.lock_outline),
                  controller: controller.passwordController,
                  suffixIcon: Icon(Icons.add),
                  hint: '******',
                  label: 'Password',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                Row(
                  children: [
                    // const Spacer(),
                    Text('Forgot password!'),
                    const Spacer(),

                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          checkColor: Colors.white,
                          fillColor: WidgetStateProperty.all(
                            AppColors.secondary,
                          ),
                          onChanged: (value) {
                            // controller.isRememberMe.value = value!;
                            value = !value!;
                          },
                        ),
                        Text('Remember me'),
                      ],
                    ),
                  ],
                ),

                Obx(
                  () => AppButton(
                    type: AppButtonType.filled,
                    onPressed: () => controller.login(context),
                    isLoading: controller.isLoading.value,
                    radius: 100,
                    child: const Text('Login'),
                  ),
                ),

                Text(
                  "Don't have an account? ",
                  style: TextStyle(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
