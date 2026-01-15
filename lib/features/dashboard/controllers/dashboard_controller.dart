import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final currentTab = 0.obs;
  final pageController = PageController();
  final cartCount = 10.obs; // 🔥 cart items

  void changeTab(int index) {
    currentTab.value = index;
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    currentTab.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
