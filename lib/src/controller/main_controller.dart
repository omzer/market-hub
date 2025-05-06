import 'package:e_commerce_flutter/services/prefs_box.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final RxSet<String> favoriteProductIds = RxSet<String>();

  @override
  void onInit() {
    super.onInit();
    PrefsBox.instance.listenKey(PrefsBox.favoriteProductIdsKey, (value) {
      favoriteProductIds.addAll(value.cast<String>());
    });
  }
}
