import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/storage/app_storage.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final AppStorage storage = Get.find<AppStorage>();
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    themeMode.value = storage.themeMode.value;
    Get.changeThemeMode(themeMode.value);
  }

  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.system
        ? ThemeMode.light
        : ThemeMode.dark;
    Get.changeThemeMode(themeMode.value);
    storage.setThemeMode(themeMode.value);
  }

  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    storage.setThemeMode(mode);
  }
}
