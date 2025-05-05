import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';

class AdaptedProductGridView extends StatelessWidget {
  final List<Product> products;
  final bool isLoading;
  final Function(Product)? onProductTap;
  final Function(Product)? onFavoriteTap;
  final Function(Product)? onAddToCartTap;

  const AdaptedProductGridView({
    Key? key,
    required this.products,
    this.isLoading = false,
    this.onProductTap,
    this.onFavoriteTap,
    this.onAddToCartTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.deepOrange,
        ),
      );
    }

    if (products.isEmpty) {
      return const Center(
        child: Text('No products found'),
      );
    }

    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onTap: onProductTap != null ? () => onProductTap!(product) : null,
          onFavoriteTap:
              onFavoriteTap != null ? () => onFavoriteTap!(product) : null,
          onAddToCartTap:
              onAddToCartTap != null ? () => onAddToCartTap!(product) : null,
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onAddToCartTap;

  const ProductCard({
    Key? key,
    required this.product,
    this.onTap,
    this.onFavoriteTap,
    this.onAddToCartTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              // Image and overlay buttons
              Stack(
                children: [
                  // Product image
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      color: Colors.grey[100],
                      child: product.imagesList.isNotEmpty
                          ? Image.network(
                              product.imagesList.first,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(Icons.image_not_supported,
                                      size: 40, color: Colors.grey),
                                );
                              },
                            )
                          : const Center(
                              child: Icon(Icons.image_not_supported,
                                  size: 40, color: Colors.grey),
                            ),
                    ),
                  ),

                  // Favorite button
                  Positioned(
                    top: 8,
                    left: 8,
                    child: InkWell(
                      onTap: onFavoriteTap,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  // Discount badge
                  if (product.discountPercentage > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "OFF ${product.discountPercentage}%",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  // Add to cart button
                  if (onAddToCartTap != null)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: InkWell(
                        onTap: onAddToCartTap,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              // Product details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product name
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      // Price information
                      Row(
                        children: [
                          Text(
                            "\$${product.discountPercentage > 0 ? product.discountPrice : product.price}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                          const SizedBox(width: 4),
                          if (product.discountPercentage > 0)
                            Text(
                              "\$${product.price}",
                              style: const TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
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
        ),
      ),
    );
  }
}
