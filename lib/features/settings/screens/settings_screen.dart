import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/controllers/theme_controller.dart';
import 'package:flutter_commerce/core/widgets/app_scaffold.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final List<String> themes = ["System", 'Light', 'Dark'];

    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const AppText(
              'Settings',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 30),
            const AppText(
              "Theme Mode",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 16),
            Obx(
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
            ),
          ],
        ),
      ),
    );
  }
}
