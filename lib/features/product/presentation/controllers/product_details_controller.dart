import 'package:flutter_commerce/core/widgets/app_snackbar.dart';
import 'package:flutter_commerce/features/product/domain/entities/product.dart';
import 'package:flutter_commerce/features/product/domain/usecases/product_usecase.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final ProductUsecase productUsecase;

  ProductDetailsController(this.productUsecase);
  final Rxn<Product> _product = Rxn<Product>();
  Product? get product => _product.value;

  final RxList<Product> _similarProducts = RxList<Product>();
  List<Product> get similarProducts => _similarProducts;

  final RxBool isLoading = false.obs;
  final RxBool isSimilarLoading = false.obs;
  final RxInt quantity = 1.obs;

  void getProductById(int id) async {
    isLoading.value = true;
    final result = await productUsecase.getProductById(id);
    result.fold(
      (failure) {
        isLoading.value = false;
        // AppSnackbar.error(message: failure.message);
      },
      (product) {
        isLoading.value = false;
        _product.value = product;
        // Fetch similar products after main product is loaded
        getSimilarProducts(product.slug);
      },
    );
  }

  void getSimilarProducts(String slug) async {
    isSimilarLoading.value = true;
    final result = await productUsecase.getSimilarProducts(slug);
    result.fold(
      (failure) {
        isSimilarLoading.value = false;
        // AppSnackbar.error(message: failure.message);
      },
      (products) {
        isSimilarLoading.value = false;
        _similarProducts.value = products;
      },
    );
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void addToCart() {
    AppSnackbar.success(message: 'Added ${quantity.value} item(s) to cart');
  }

  void buyNow() {
    AppSnackbar.success(message: 'Buy Now clicked');
  }
}
