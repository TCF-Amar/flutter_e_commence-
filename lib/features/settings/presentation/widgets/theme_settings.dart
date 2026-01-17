import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/controllers/theme_controller.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:get/get.dart';

class ThemeSettings extends StatelessWidget {
  ThemeSettings({super.key});
  final ThemeController themeController = Get.put(ThemeController());
  final List<String> themes = ["System", 'Light', 'Dark'];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ToggleButtons(
        direction: Axis.horizontal,
        borderRadius: BorderRadius.circular(8),
        constraints: const BoxConstraints(minHeight: 40, minWidth: 100),
        onPressed: (int index) {
          ThemeMode selectedMode;
          switch (index) {
            case 0:
              selectedMode = ThemeMode.system;
              break;
            case 1:
              selectedMode = ThemeMode.light;
              break;
            case 2:
              selectedMode = ThemeMode.dark;
              break;
            default:
              selectedMode = ThemeMode.system;
          }
          themeController.setThemeMode(selectedMode);
        },
        isSelected: [
          themeController.themeMode.value == ThemeMode.system,
          themeController.themeMode.value == ThemeMode.light,
          themeController.themeMode.value == ThemeMode.dark,
        ],
        children: themes
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppText(e),
              ),
            )
            .toList(),
      ),
    );
  }
}
