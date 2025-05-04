import 'package:get/get.dart';
import 'package:e_commerce_flutter/src/controller/category_controller.dart';
import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/controller/api.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Register API service
    Get.put(Api(), permanent: true);

    // Register controllers
    Get.put(CategoryController(), permanent: true);
    Get.put(ProductController(), permanent: true);
  }
}
