import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/constants/colors/app_color_scheme.dart';
import 'package:flutter_commerce/core/constants/colors/app_colors.dart';
import 'package:flutter_commerce/core/constants/colors/app_size.dart';
import 'package:flutter_commerce/core/widgets/app_scaffold.dart';
import 'package:flutter_commerce/features/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter_commerce/features/product/presentation/pages/collection_screen.dart';
import 'package:flutter_commerce/features/home/pages/home_screen.dart';
import 'package:flutter_commerce/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter_commerce/features/whistle/presentation/pages/saves_screen.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).extension<AppColorScheme>()!;
    final appSize = Theme.of(context).extension<AppSizes>()!;
    final tabs = [
      HomeScreen(),
      CollectionScreen(),
      Text("card"),
      SavesScreen(),
      ProfileScreen(),
    ];

    final navigationBarHeight = MediaQuery.of(context).size.height * 0.07;

    return AppScaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        children: tabs,
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: navigationBarHeight,
          backgroundColor: colorScheme.surface,
          elevation: 2,
          shadowColor: colorScheme.shadow,
          indicatorColor: Colors.transparent,

          selectedIndex: controller.currentTab.value,
          onDestinationSelected: controller.changeTab,
          surfaceTintColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          animationDuration: const Duration(milliseconds: 300),
          destinations: [
            NavigationDestination(
              icon: controller.currentTab.value == 0
                  ? Icon(
                      Icons.home_rounded,
                      size: appSize.lg,
                      color: AppColors.primary,
                    )
                  : Icon(Icons.home_outlined, size: appSize.lg),
              label: 'Home',
            ),
            NavigationDestination(
              icon: controller.currentTab.value == 1
                  ? Icon(
                      Icons.grid_view_rounded,
                      size: appSize.lg,
                      color: AppColors.primary,
                    )
                  : Icon(Icons.grid_view_outlined, size: appSize.lg),
              label: 'Collection',
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: controller.cartCount > 0,
                label: Text(
                  controller.cartCount.toString(),
                  style: const TextStyle(fontSize: 10),
                ),
                child: controller.currentTab.value == 2
                    ? Icon(
                        Icons.shopping_bag_rounded,
                        size: appSize.lg,
                        color: AppColors.primary,
                      )
                    : Icon(Icons.shopping_bag_outlined, size: appSize.lg),
              ),
              label: 'Cart',
            ),

            NavigationDestination(
              icon: controller.currentTab.value == 3
                  ? Icon(
                      Icons.favorite_rounded,
                      size: appSize.lg,
                      color: AppColors.primary,
                    )
                  : Icon(Icons.favorite_border_outlined, size: appSize.lg),
              label: 'Saved',
            ),
            NavigationDestination(
              icon: controller.currentTab.value == 4
                  ? Icon(
                      Icons.person_rounded,
                      size: appSize.lg,
                      color: AppColors.primary,
                    )
                  : Icon(Icons.person_outlined, size: appSize.lg),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
