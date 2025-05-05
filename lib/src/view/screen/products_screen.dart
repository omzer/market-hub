import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce_flutter/src/controller/products_controller.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';
import 'package:e_commerce_flutter/src/view/widget/product/products_grid.dart';
import 'package:e_commerce_flutter/core/app_colors.dart';

import 'product_details_screen.dart';

class ProductsScreen extends GetView<ProductsController> {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ProductsGrid(
                  products: controller.products,
                  isLoading: controller.isLoading.value,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Products'),
      actions: [
        // Cart icon with badge
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                // Navigate to cart screen
              },
            ),
            Obx(() {
              if (controller.cartItemCount > 0) {
                return Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.accentOrange,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${controller.cartItemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: product.imagesList.isNotEmpty
                      ? Image.network(
                          product.imagesList.first,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.backgroundGrey,
                              child: const Center(
                                child:
                                    Icon(Icons.image_not_supported, size: 40),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: AppColors.backgroundGrey,
                          child: const Center(
                            child: Icon(Icons.image_not_supported, size: 40),
                          ),
                        ),
                ),
                // Discount badge
                if (product.discountPercentage > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentOrangeDark,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${product.discountPercentage}% OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Details
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.headlineMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Categories
                  if (product.categories.isNotEmpty)
                    Text(
                      product.categories.map((c) => c.name).join(', '),
                      style: theme.textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  // Price
                  Row(
                    children: [
                      Text(
                        '₪${product.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGreen,
                          fontSize: 16,
                        ),
                      ),
                      if (product.discountPercentage > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            '₪${product.discountPrice}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  // Availability
                  Row(
                    children: [
                      Icon(
                        product.isAvailable ? Icons.check_circle : Icons.cancel,
                        color: product.isAvailable
                            ? AppColors.primaryGreen
                            : Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.isAvailable ? 'In Stock' : 'Out of Stock',
                        style: TextStyle(
                          color: product.isAvailable
                              ? AppColors.primaryGreen
                              : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
