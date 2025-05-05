import 'package:e_commerce_flutter/src/model/category.dart';

enum ProductType { all, watch, mobile, headphone, tablet, tv }

class Product {
  final int id;
  final String name;
  final List<Category> categories;
  final String description;
  final String price;
  final String discountPrice;
  final int discountPercentage;
  final String images;
  final List<String> imagesList;
  final int averageRating;
  final bool isAvailable;
  final bool featured;

  Product({
    required this.id,
    required this.name,
    required this.categories,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.discountPercentage,
    required this.images,
    required this.imagesList,
    required this.averageRating,
    required this.isAvailable,
    required this.featured,
  });

  // Factory constructor to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      categories: (json['categories'] as List?)
              ?.map((category) => Category.fromJson(category))
              .toList() ??
          [],
      description: json['description'] ?? '',
      price: json['price'] ?? '0.00',
      discountPrice: json['discount_price'] ?? '0.00',
      discountPercentage: json['discount_percentage'] ?? 0,
      images: json['images'] ?? '',
      imagesList: (json['images_list'] as List?)
              ?.map((image) => image.toString())
              .toList() ??
          [],
      averageRating: json['average_rating'] ?? 0,
      isAvailable: json['is_available'] ?? false,
      featured: json['featured'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, isAvailable: $isAvailable}';
  }
}
