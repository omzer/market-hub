import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce_flutter/src/controller/main_controller.dart';
import 'package:e_commerce_flutter/src/view/widget/product/products_grid.dart';
import 'package:e_commerce_flutter/src/view/widget/common/loading_indicator.dart';
import 'package:e_commerce_flutter/src/view/widget/common/empty_state.dart'; // Assuming you have an EmptyState widget

class FavoriteScreen extends GetView<MainController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المفضلة')),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshFavorites(),
        child: Obx(() {
          if (controller.isLoadingFavorites.value &&
              controller.favoriteProductsFromServer.isEmpty) {
            return const LoadingIndicator();
          }
          if (controller.favoriteProductsFromServer.isEmpty) {
            return Stack(children: [
              ListView(),
              const EmptyState(
                message: 'قائمة المفضلة فارغة حالياً',
                icon: Icons.favorite_border,
              )
            ]);
          }
          return ProductsGrid(
            products: controller.favoriteProductsFromServer,
          );
        }),
      ),
    );
  }
}
