import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';
import 'package:e_commerce_flutter/src/view/widget/product/product_card.dart';
import 'package:e_commerce_flutter/src/view/widget/common/loading_indicator.dart';
import 'package:e_commerce_flutter/src/view/widget/common/empty_state.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> products;
  final bool isLoading;
  final Function(Product)? onProductTap;
  final Function(Product)? onFavoriteTap;
  final Function(Product)? onAddToCartTap;

  const ProductsGrid({
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
      return const LoadingIndicator();
    }

    if (products.isEmpty) {
      return const EmptyState(
        message: 'No products found',
        icon: Icons.inventory_2_outlined,
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
