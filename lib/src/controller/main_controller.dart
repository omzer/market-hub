import 'package:get/get.dart';
import 'package:e_commerce_flutter/src/model/category.dart';
import 'package:e_commerce_flutter/src/controller/api.dart';

class MainController extends GetxController {
  final Api _api = Get.put(Api());

  RxBool isLoading = false.obs;
  RxList<Category> categories = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;

    final result = await _api.getCategories();
    categories.assignAll(result);

    isLoading.value = false;
  }
}