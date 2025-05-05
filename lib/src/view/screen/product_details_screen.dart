import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';
import 'package:e_commerce_flutter/src/controller/products_controller.dart';
import 'package:e_commerce_flutter/src/view/widget/product/product_image_gallery.dart';
import 'package:e_commerce_flutter/src/view/widget/product/add_to_cart_button.dart';
import 'package:e_commerce_flutter/src/view/widget/common/price_display.dart';
import 'package:e_commerce_flutter/core/app_colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final ProductsController controller = Get.find<ProductsController>();

  ProductDetailsScreen(this.product, {super.key});

  PreferredSizeWidget _appBar(BuildContext context) {
    final availableColor = AppColors.primaryGreen;
    final unavailableColor = Colors.red;

    return AppBar(
      elevation: 0.5,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: product.isAvailable
              ? availableColor.withOpacity(0.1)
              : unavailableColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              product.isAvailable ? Icons.check_circle : Icons.cancel,
              color: product.isAvailable ? availableColor : unavailableColor,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              product.isAvailable ? "متوفر في المخزن" : "غير متوفر في المخزن",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: product.isAvailable ? availableColor : unavailableColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
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

          // Categories
          if (product.categories.isNotEmpty)
            Text(
              product.categories.map((c) => c.name).join(', '),
              style: theme.textTheme.headlineSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          const SizedBox(height: 16),

          // Price only (removed availability badge)
          PriceDisplay(
            currentPrice: product.discountPercentage > 0
                ? product.discountPrice
                : product.price,
            originalPrice:
                product.discountPercentage > 0 ? product.price : null,
            currentPriceSize: 24,
            originalPriceSize: 16,
            isAvailable: product.isAvailable,
          ),

          // Show description section only if a description exists
          if (product.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Divider(color: AppColors.borderLight, thickness: 1),
            const SizedBox(height: 8),
            Text(
              "الوصف",
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
          ],

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
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
              const SizedBox(height: 2),
              PriceDisplay(
                currentPrice: product.discountPercentage > 0
                    ? product.discountPrice
                    : product.price,
                originalPrice:
                    product.discountPercentage > 0 ? product.price : null,
                currentPriceSize: 20,
                originalPriceSize: 16,
                isAvailable: product.isAvailable,
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
      bottomNavigationBar: product.isAvailable ? _buildBottomBar() : null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image gallery with Hero animation
            Hero(
              tag: 'product-image-${product.id}',
              child: Material(
                type: MaterialType.transparency,
                child: ProductImageGallery(product: product),
              ),
            ),

            // Product details
            _buildProductDetailsSection(context),
          ],
        ),
      ),
    );
  }
}
