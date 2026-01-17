import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_commerce/core/widgets/app_back_button.dart';
import 'package:flutter_commerce/core/widgets/app_scaffold.dart';
import 'package:flutter_commerce/core/widgets/app_text.dart';
import 'package:flutter_commerce/features/settings/presentation/widgets/theme_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const AppText(
          'Settings',
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        leading: const AppBackButton(),
        backgroundColor: context.colorScheme.background,
        surfaceTintColor: context.colorScheme.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const AppText(
              "Theme Mode",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 16),
            ThemeSettings(),
          ],
        ),
      ),
    );
  }
}
