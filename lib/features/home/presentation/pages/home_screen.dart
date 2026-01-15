import 'package:flutter/material.dart';
import 'package:flutter_commerce/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_commerce/features/home/presentation/widgets/home_carousel_slider.dart';
import 'package:flutter_commerce/features/home/presentation/widgets/home_category_section.dart';
import 'package:flutter_commerce/features/home/presentation/widgets/home_search_bar.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // controller: ,
      children: [
        //* Search Bar
        const HomeSearchBar(),

        //* Hero Banner
        const HomeCarouselSlider(),

        //* Category Section
        const HomeCategorySection(),
      ],
    );
  }
}
