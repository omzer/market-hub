import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/core/app_color.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_commerce_flutter/src/controller/products_controller.dart';

class AdaptedProductDetailScreen extends StatelessWidget {
  final Product product;
  final ProductsController controller = Get.find<ProductsController>();

  AdaptedProductDetailScreen(this.product, {super.key});

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      actions: [
        // Favorite icon button
        IconButton(
          onPressed: () => controller.toggleFavorite(product),
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

  Widget _productImagesPageView(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.grey[100],
      child: product.imagesList.isNotEmpty
          ? PageView.builder(
              itemCount: product.imagesList.length,
              itemBuilder: (context, index) {
                return Image.network(
                  product.imagesList[index],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.image_not_supported, size: 60),
                      ),
                    );
                  },
                );
              },
            )
          : Container(
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.image_not_supported, size: 60),
              ),
            ),
    );
  }

  Widget _ratingBar(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: product.averageRating.toDouble(),
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 18,
          ignoreGestures: true,
          itemBuilder: (_, __) => const FaIcon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
          ),
          onRatingUpdate: (_) {},
        ),
        const SizedBox(width: 8),
        Text(
          "(${product.averageRating}/5)",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
            fontSize: 14,
          ),
        )
      ],
    );
  }

  Widget _categoryChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: product.categories.map((category) {
        return Chip(
          label: Text(
            category.name,
            style: const TextStyle(fontSize: 12),
          ),
          backgroundColor: Colors.grey[100],
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        height: 80,
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
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      product.discountPercentage > 0
                          ? "\$${product.discountPrice}"
                          : "\$${product.price}",
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (product.discountPercentage > 0)
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 150,
              height: 48,
              child: ElevatedButton(
                onPressed: product.isAvailable
                    ? () {
                        controller.addToCart(product);
                        Get.snackbar(
                          'Added to Cart',
                          '${product.name} has been added to your cart',
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(16),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.shopping_cart),
                    SizedBox(width: 8),
                    Text("Add to Cart"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image gallery
            _productImagesPageView(context),

            // Product details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
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
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      _ratingBar(context),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Price and availability
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            product.discountPercentage > 0
                                ? "\$${product.discountPrice}"
                                : "\$${product.price}",
                            style: const TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (product.discountPercentage > 0)
                            Text(
                              "\$${product.price}",
                              style: TextStyle(
                                color: Colors.grey[600],
                                decoration: TextDecoration.lineThrough,
                                fontSize: 16,
                              ),
                            ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: product.isAvailable
                              ? Colors.green[50]
                              : Colors.red[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              product.isAvailable
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: product.isAvailable
                                  ? Colors.green
                                  : Colors.red,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              product.isAvailable ? "In Stock" : "Out of Stock",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: product.isAvailable
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Divider
                  Divider(color: Colors.grey[200], thickness: 1),
                  const SizedBox(height: 16),

                  // Description section
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.grey[800],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Featured badge if applicable
                  if (product.featured)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.amber,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Featured Product",
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
