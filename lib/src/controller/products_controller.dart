import 'package:get/get.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';
import 'package:e_commerce_flutter/src/controller/api.dart';

class ProductsController extends GetxController {
  final Api _api = Get.put(Api());

  RxBool isLoading = false.obs;
  RxList<Product> products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    final result = await _api.getProducts();
    products.assignAll(result);

    isLoading.value = false;
  }
}