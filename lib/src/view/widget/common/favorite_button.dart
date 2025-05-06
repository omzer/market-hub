import 'package:e_commerce_flutter/services/prefs_box.dart';
import 'package:e_commerce_flutter/src/controller/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

class FavoriteButton extends GetView<FavoriteController> {
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
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Center(
            child: LikeButton(
          size: size,
          isLiked: isFavorite,
          likeBuilder: (bool isLiked) {
            return Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : Colors.red,
              size: size,
            );
          },
          onTap: (bool isLiked) async {
            await PrefsBox.toggleFavoriteProductId(productId);
            return !isLiked;
          },
          likeCount: null,
          countBuilder: (int? count, bool isLiked, String text) {
            return null;
          },
          animationDuration: const Duration(milliseconds: 1000),
          bubblesColor: const BubblesColor(
            dotPrimaryColor: Colors.red,
            dotSecondaryColor: Colors.red,
          ),
          circleColor: const CircleColor(
            start: Colors.red,
            end: Colors.red,
          ),
        )),
      );
    });
  }
}
