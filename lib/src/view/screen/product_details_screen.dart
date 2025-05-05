import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';
import 'package:e_commerce_flutter/src/controller/products_controller.dart';
import 'package:e_commerce_flutter/src/view/widget/product/product_image_gallery.dart';
import 'package:e_commerce_flutter/src/view/widget/product/product_rating_bar.dart';
import 'package:e_commerce_flutter/src/view/widget/product/availability_badge.dart';
import 'package:e_commerce_flutter/src/view/widget/product/featured_product_badge.dart';
import 'package:e_commerce_flutter/src/view/widget/product/add_to_cart_button.dart';
import 'package:e_commerce_flutter/src/view/widget/common/price_display.dart';
import 'package:e_commerce_flutter/core/app_colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final ProductsController controller = Get.find<ProductsController>();

  ProductDetailsScreen(this.product, {super.key});

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        // Favorite icon button
        IconButton(
          onPressed: () => {},
          icon: Obx(() {
            return Icon(
              controller.isFavorite(product)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            );
          }),
        ),
      ],
    );
  }

  Widget _buildProductDetailsSection(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product name
          Text(
            product.name,
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 12),

          // Categories and Rating in a row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (product.categories.isNotEmpty)
                Expanded(
                  child: Text(
                    product.categories.map((c) => c.name).join(', '),
                    style: theme.textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ProductRatingBar(rating: product.averageRating.toDouble()),
            ],
          ),
          const SizedBox(height: 16),

          // Price and availability
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PriceDisplay(
                currentPrice: product.discountPercentage > 0
                    ? product.discountPrice
                    : product.price,
                originalPrice:
                    product.discountPercentage > 0 ? product.price : null,
                currentPriceSize: 24,
                originalPriceSize: 16,
              ),
              AvailabilityBadge(isAvailable: product.isAvailable),
            ],
          ),

          const SizedBox(height: 24),

          // Divider
          Divider(color: AppColors.borderLight, thickness: 1),
          const SizedBox(height: 16),

          // Description section
          Text(
            "Description",
            style: theme.textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 24),

          // Featured badge if applicable
          if (product.featured) const FeaturedProductBadge(),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 80,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Total Price",
                style: TextStyle(
                  color: AppColors.neutralBrown,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              PriceDisplay(
                currentPrice: product.discountPercentage > 0
                    ? product.discountPrice
                    : product.price,
                originalPrice:
                    product.discountPercentage > 0 ? product.price : null,
                currentPriceSize: 20,
                originalPriceSize: 16,
              ),
            ],
          ),
          AddToCartButton(
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      bottomNavigationBar: _buildBottomBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image gallery
            ProductImageGallery(images: product.imagesList),

            // Product details
            _buildProductDetailsSection(context),
          ],
        ),
      ),
    );
  }
}
