import 'package:e_commerce_flutter/services/prefs_box.dart';
import 'package:get/get.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';
import 'package:e_commerce_flutter/src/controller/api.dart';

class MainController extends GetxController {
  final Api _api = Get.find<Api>();

  final RxSet<String> favoriteProductIds = RxSet<String>();
  final RxList<Product> favoriteProductsFromServer = <Product>[].obs;
  final RxBool isLoadingFavorites = false.obs;

  @override
  void onInit() {
    super.onInit();

    favoriteProductIds.addAll(PrefsBox.getFavoriteProductIds());
    PrefsBox.instance.listenKey(PrefsBox.favoriteProductIdsKey, (value) {
      favoriteProductIds.clear();
      favoriteProductIds.addAll(value.cast<String>());
    });
  }

  Future<void> refreshFavorites() async {
    if (favoriteProductIds.isEmpty) {
      favoriteProductsFromServer.clear();
      return;
    }

    isLoadingFavorites.value = true;
    try {
      final products = await _api.getProductsByIds(favoriteProductIds.toList());
      favoriteProductsFromServer.assignAll(products);
    } catch (e) {
      favoriteProductsFromServer.clear();
    } finally {
      isLoadingFavorites.value = false;
    }
  }
}
