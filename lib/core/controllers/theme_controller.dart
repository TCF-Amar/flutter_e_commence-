import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  // final _box = GetStorage();

  final Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  @override
  void onInit() {
    super.onInit();
    // final isDark = _box.read('isDark') ?? false;
    themeMode.value = ThemeMode.dark;
    Get.changeThemeMode(themeMode.value);
  }

  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    Get.changeThemeMode(themeMode.value);
  }
}
