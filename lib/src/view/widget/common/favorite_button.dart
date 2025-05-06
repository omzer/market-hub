import 'package:e_commerce_flutter/services/prefs_box.dart';
import 'package:e_commerce_flutter/src/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteButton extends GetView<MainController> {
  final String productId;
  final double size;

  const FavoriteButton({
    super.key,
    required this.productId,
    this.size = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isFavorite = controller.favoriteProductIds.contains(productId);
      return InkWell(
        onTap: () => PrefsBox.toggleFavoriteProductId(productId),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            size: size,
            color: Colors.red,
          ),
        ),
      );
    });
  }
}
