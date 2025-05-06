import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';
import 'package:e_commerce_flutter/src/view/widget/product/product_card.dart';
import 'package:e_commerce_flutter/src/view/widget/common/loading_indicator.dart';
import 'package:e_commerce_flutter/src/view/widget/common/empty_state.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> products;
  final bool isLoading;

  const ProductsGrid({
    super.key,
    required this.products,
    this.isLoading = false,
  });

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
          cacheExtent: 500,
          itemCount: products.length,
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio:
                orientation == Orientation.landscape ? 0.75 : 0.65,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: (orientation == Orientation.portrait &&
                    constraints.maxHeight > 500)
                ? _getStaggeredHeight(crossAxisCount, constraints.maxHeight)
                : null,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              key: ValueKey('product-card-${product.id}'),
              product: product,
            );
          },
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
        );
      },
    );
  }

  int _calculateColumnCount(double width, Orientation orientation) {
    if (orientation == Orientation.landscape) {
      if (width <= 600) return 2; // Small landscape phones
      if (width <= 960) return 3; // Landscape phones/small tablets
      if (width <= 1200) return 4; // Landscape tablets
      if (width <= 1800) return 5; // Small desktops
      return 6; // Large desktops
    } else {
      if (width <= 360) return 1; // Small phones
      if (width <= 600) return 2; // Normal phones
      if (width <= 900) return 3; // Tablets
      if (width <= 1200) return 4; // Small desktops
      return 5; // Large desktops
    }
  }

  double _getStaggeredHeight(int columnCount, double availableHeight) {
    final baseHeight = availableHeight * 0.4;

    if (columnCount == 1) return baseHeight;

    final List<double> heightFactors = [0.95, 1.0, 1.05];
    return baseHeight * heightFactors[columnCount % heightFactors.length];
  }
}
