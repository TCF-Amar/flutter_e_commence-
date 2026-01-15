import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/routes/app_routes.dart';
import 'package:flutter_commerce/core/storage/app_storage.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> fadeAnimation;
  late final Animation<double> scaleAnimation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    animationController.forward();
  }



  Future<void> navigateNext(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    final storage = Get.find<AppStorage>();
    final isLoggedIn = storage.isLoggedIn.value;
    final hasToken = storage.token.value.isNotEmpty;

    debugPrint('🚀 Splash navigating...');
    debugPrint('   isLoggedIn: $isLoggedIn');
    debugPrint('   hasToken: $hasToken');

    if (!context.mounted) {
      debugPrint('   ❌ Context not mounted, aborting navigation');
      return;
    }

    if (isLoggedIn && hasToken) {
      debugPrint('   ✅ Navigating to Dashboard');
      context.go(AppRoutes.dashboard.path);
    } else {
      debugPrint('   ✅ Navigating to Login');
      context.go(AppRoutes.login.path);
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
