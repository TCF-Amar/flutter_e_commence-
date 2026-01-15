import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/constants/colors/app_colors.dart';
import 'package:get/get.dart';

class GetSnack {
  static void success({String title = 'Success', required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success,
      colorText: AppColors.backgroundLight,
      icon: const Icon(Icons.check_circle, color: AppColors.backgroundLight),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  static void error({String title = 'Error', required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error,
      colorText: AppColors.backgroundLight,
      icon: const Icon(Icons.error, color: AppColors.backgroundLight),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 4),
    );
  }

  static void warning({String title = 'Warning', required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.warning,
      colorText: AppColors.backgroundLight,
      icon: const Icon(Icons.warning, color: AppColors.backgroundLight),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  static void info({String title = 'Info', required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.info,
      colorText: AppColors.backgroundLight,
      icon: const Icon(Icons.info, color: AppColors.backgroundLight),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  static void custom({
    String title = 'Info',
    required String message,
    required Color backgroundColor,
    Color textColor = AppColors.backgroundLight,
    Color iconColor = AppColors.backgroundLight,
    IconData icon = Icons.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: textColor,
      icon: Icon(icon, color: iconColor),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: duration,
    );
  }
}
