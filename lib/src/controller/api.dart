import 'package:get/get.dart';
import 'package:e_commerce_flutter/src/model/category.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';

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

  Future<List<Product>> getProducts() async {
    final response = await get('products/');
    if (response.status.hasError) return [];

    return response.body['results']
        .map<Product>((json) => Product.fromJson(json))
        .toList();
  }

  Future<List<Product>> getProductsByIds(List<String> ids) async {
    if (ids.isEmpty) {
      return [];
    }
    final idsQueryParam = ids.join(',');
    final response = await get('products/by-ids/?ids=$idsQueryParam');
    if (response.status.hasError || response.body == null) {
      return [];
    }

    return (response.body as List)
        .map<Product>((json) => Product.fromJson(json))
        .toList();
  }
}
