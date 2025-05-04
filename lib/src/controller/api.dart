import 'package:get/get.dart';
import 'package:e_commerce_flutter/src/model/category.dart';

class Api extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl =
        'https://e-commerce-ps-a6a992273b00.herokuapp.com/api/';

    // Add request configurations if needed
    httpClient.addRequestModifier<dynamic>((request) {
      // Add headers or authentication tokens if needed
      // request.headers['Authorization'] = 'Bearer YOUR_TOKEN';
      return request;
    });

    // Add response configurations if needed
    httpClient.addResponseModifier<dynamic>((request, response) {
      return response;
    });

    super.onInit();
  }

  Future<List<Category>> getCategories() async {
    final response = await get('categories/');
    if (response.status.hasError) return [];

    return response.body
        .map<Category>((json) => Category.fromJson(json))
        .toList();
  }
}
