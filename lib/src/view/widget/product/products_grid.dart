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

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate number of columns based on screen width
        final orientation = MediaQuery.of(context).orientation;
        int crossAxisCount =
            _calculateColumnCount(constraints.maxWidth, orientation);

        return GridView.builder(
          itemCount: products.length,
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            // Make sure there's enough height for product name and price in both orientations
            childAspectRatio:
                orientation == Orientation.landscape ? 0.75 : 0.65,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            // Use staggered heights in portrait mode only if we have enough space
            mainAxisExtent: (orientation == Orientation.portrait &&
                    constraints.maxHeight > 500)
                ? _getStaggeredHeight(crossAxisCount, constraints.maxHeight)
                : null,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              product: product,
              onTap: onProductTap != null ? () => onProductTap!(product) : null,
              onFavoriteTap:
                  onFavoriteTap != null ? () => onFavoriteTap!(product) : null,
              onAddToCartTap: onAddToCartTap != null
                  ? () => onAddToCartTap!(product)
                  : null,
            );
          },
        );
      },
    );
  }

  // Calculate columns based on screen width and orientation
  int _calculateColumnCount(double width, Orientation orientation) {
    // In landscape, use more columns to make better use of horizontal space
    if (orientation == Orientation.landscape) {
      if (width <= 600) return 2; // Small landscape phones
      if (width <= 960) return 3; // Landscape phones/small tablets
      if (width <= 1200) return 4; // Landscape tablets
      if (width <= 1800) return 5; // Small desktops
      return 6; // Large desktops
    } else {
      // Portrait orientation
      if (width <= 360) return 1; // Small phones
      if (width <= 600) return 2; // Normal phones
      if (width <= 900) return 3; // Tablets
      if (width <= 1200) return 4; // Small desktops
      return 5; // Large desktops
    }
  }

  // Create staggered effect by varying heights based on screen size
  double _getStaggeredHeight(int columnCount, double availableHeight) {
    // Adjust height based on available screen height to avoid overflow
    final baseHeight =
        availableHeight * 0.4; // Use 40% of available height as base

    // On small screens with 1 column, don't apply staggering
    if (columnCount == 1) return baseHeight;

    // Create slight height variations for staggered effect (±5-10%)
    final List<double> heightFactors = [0.95, 1.0, 1.05];
    return baseHeight * heightFactors[columnCount % heightFactors.length];
  }
}
