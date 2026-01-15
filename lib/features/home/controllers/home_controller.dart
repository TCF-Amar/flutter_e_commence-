import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/routes/app_routes.dart';
import 'package:flutter_commerce/features/product/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  // Lazy getter to avoid initialization order issues
  ProductController get productController => Get.find<ProductController>();

  final isSearchVisible = true.obs;
  Timer? _idelTimer;

  double _lastOffset = 0;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    _idelTimer?.cancel();
    final currentOffset = scrollController.offset;

    // Scroll down → hide
    if (currentOffset > _lastOffset && isSearchVisible.value) {
      isSearchVisible.value = false;
    }

    // Scroll up → show
    if (currentOffset < _lastOffset && !isSearchVisible.value) {
      isSearchVisible.value = true;
    }

    _lastOffset = currentOffset;

    _idelTimer = Timer(const Duration(seconds: 1), () {
      isSearchVisible.value = true;
    });
  }

  void openSearch(BuildContext context) {
    if (context.mounted) {
      context.push(AppRoutes.search.path);
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    _idelTimer?.cancel();
    super.onClose();
  }
}
