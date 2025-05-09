import 'package:get/get.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';
import 'package:e_commerce_flutter/src/controller/api.dart';

class ProductsController extends GetxController {
  final Api _api = Get.put(Api());

  RxBool isLoading = false.obs;
  RxList<Product> products = <Product>[].obs;
  RxList<Product> cartProducts = <Product>[].obs;
  RxInt currentImageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  // Reset the current image index when viewing a new product
  void resetImageIndex() {
    currentImageIndex.value = 0;
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    final result = await _api.getProducts();
    products.assignAll(result);

    isLoading.value = false;
  }

  void addToCart(Product product) {
    if (!isInCart(product)) {
      cartProducts.add(product);
      Get.snackbar(
        'Added to Cart',
        '${product.name} has been added to your cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  bool isInCart(Product product) {
    return cartProducts.any((p) => p.id == product.id);
  }

  int get cartItemCount => cartProducts.length;

  double get cartTotal {
    double total = 0;
    for (var product in cartProducts) {
      total += double.tryParse(product.price) ?? 0;
    }
    return total;
  }
}
