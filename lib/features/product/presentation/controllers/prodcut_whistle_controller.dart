import 'package:flutter_commerce/core/storage/app_storage.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';
import 'package:flutter_commerce/features/product/domain/usecases/product_usecase.dart';
import 'package:flutter_commerce/features/product/presentation/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProdcutWhistleController extends GetxController {
  final ProductUsecase productUsecase;
  ProdcutWhistleController(this.productUsecase);

  final ProductController productController = Get.find<ProductController>();
  final AppStorage appStorage = Get.find<AppStorage>();

  final RxList<Product> _wishlistProducts = RxList<Product>();
  List<Product> get wishlistProducts => _wishlistProducts;
  final RxList<String> wishlistIds = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load wishlist IDs from storage
    wishlistIds.value = appStorage.wishlist;
  }

  void toggleWishlist(String productId) {
    if (wishlistIds.contains(productId)) {
      wishlistIds.remove(productId);
    } else {
      wishlistIds.add(productId);
    }
    // Persist to storage
    appStorage.setWishlist(wishlistIds);
  }

  // Check if product is in wishlist using reactive wishlistIds
  bool isInWishlist(String productId) {
    return wishlistIds.contains(productId);
  }

  List<String> getWishlist() {
    return appStorage.wishlist;
  }

  // void getWishlistProducts() async {
  //   if (appStorage.wishlist.isEmpty) {
  //     _wishlistProducts.clear();
  //     return;
  //   }

  //   // Fetch all products and handle Either type
  //   final results = await Future.wait(
  //     appStorage.wishlist.map((id) async {
  //       return await productUsecase.getProductById(int.parse(id));
  //     }),
  //   );

  //   // Extract successful products from Either
  //   final products = <Product>[];
  //   for (var result in results) {
  //     result.fold(
  //       (failure) {
  //         // Log error but continue
  //         print('Failed to load product: ${failure.message}');
  //       },
  //       (product) {
  //         products.add(product);
  //       },
  //     );
  //   }

  //   _wishlistProducts.value = products;
  // }
}
