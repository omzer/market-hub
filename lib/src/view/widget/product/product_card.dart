import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_flutter/src/view/screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';
import 'package:get/get.dart';
import '../common/favorite_button.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => ProductDetailsScreen(product),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 250),
        preventDuplicates: true,
        opaque: false,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImageSection(),
              _buildProductDetails(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImageSection() {
    return Stack(
      children: [
        _buildProductImage(),
        Positioned(
          top: 8,
          left: 8,
          child: FavoriteButton(productId: product.id.toString()),
        ),
        if (product.discountPercentage > 0) _buildDiscountBadge(),
      ],
    );
  }

  Widget _buildProductImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        color: Colors.grey[100],
        child: product.imagesList.isNotEmpty
            ? Hero(
                tag: 'product-image-${product.id}',
                child: Material(
                  type: MaterialType.transparency,
                  child: CachedNetworkImage(
                    key: ValueKey('cached-image-${product.id}'),
                    fit: BoxFit.cover,
                    imageUrl: product.imagesList.first,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[100],
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.grey[400]!),
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.image_not_supported,
                          size: 40, color: Colors.grey),
                    ),
                    fadeInDuration: const Duration(milliseconds: 150),
                    fadeOutDuration: const Duration(milliseconds: 150),
                    memCacheWidth:
                        400, // Use a reasonable width to cache in memory
                    // Keep image in cache to avoid reload when scrolling
                    cacheKey: 'product-image-${product.id}',
                  ),
                ),
              )
            : const Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
      ),
    );
  }

  Widget _buildDiscountBadge() {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "خصم ${product.discountPercentage}%",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildProductName(),
            _buildPriceInformation(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductName() {
    return Text(
      product.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildPriceInformation() {
    final Color priceColor =
        product.isAvailable ? Colors.deepOrange : Colors.grey;
    return Row(
      children: [
        Text(
          "₪${product.discountPercentage > 0 ? product.discountPrice : product.price}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: priceColor,
          ),
        ),
        const SizedBox(width: 4),
        if (product.discountPercentage > 0)
          Text(
            "₪${product.price}",
            style: const TextStyle(
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
      ],
    );
  }
}
