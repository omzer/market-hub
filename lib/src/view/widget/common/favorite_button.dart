import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce_flutter/src/controller/products_controller.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';

class FavoriteButton extends GetView<ProductsController> {
  final String productId;
  final double size;

  const FavoriteButton({
    super.key,
    required this.productId,
    this.size = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    final Product? product = controller.products.firstWhereOrNull(
      (p) => p.id == int.tryParse(productId),
    );

    if (product == null) return const SizedBox.shrink();

    return Obx(() {
      final bool isFavorite = controller.isFavorite(product);
      return InkWell(
        onTap: () => controller.toggleFavorite(product),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
            size: size,
          ),
        ),
      );
    });
  }
}
