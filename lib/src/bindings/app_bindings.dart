import 'package:get/get.dart';
import 'package:e_commerce_flutter/src/controller/categories_controller.dart';
import 'package:e_commerce_flutter/src/controller/products_controller.dart';
import 'package:e_commerce_flutter/src/controller/api.dart';
import 'package:e_commerce_flutter/src/controller/favorite_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Register API service
    Get.put(Api(), permanent: true);

    // Register controllers
    Get.put(CategoriesController(), permanent: true);
    Get.put(ProductsController(), permanent: true);
    Get.put(FavoriteController(), permanent: true);
  }
}
