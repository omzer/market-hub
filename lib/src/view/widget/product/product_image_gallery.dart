import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_flutter/src/controller/products_controller.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';
import 'package:e_commerce_flutter/src/view/widget/product/full_screen_image_viewer.dart';

class ProductImageGallery extends GetView<ProductsController> {
  final Product product;
  final double height;
  final Color backgroundColor;

  const ProductImageGallery({
    super.key,
    required this.product,
    this.height = 300,
    this.backgroundColor = const Color(0xFFF5F5F5),
  });

  @override
  Widget build(BuildContext context) {
    // Reset image index when this widget is built with a new product
    controller.resetImageIndex();

    final List<String> images = product.imagesList;

    return SizedBox(
      height: height,
      child: images.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: CarouselSlider.builder(
                    itemCount: images.length,
                    options: CarouselOptions(
                      height: height - 40,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: images.length > 1,
                      autoPlay: images.length > 1,
                      autoPlayInterval: const Duration(seconds: 4),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      onPageChanged: (index, reason) {
                        controller.currentImageIndex.value = index;
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return _buildImageItem(
                          context, images[index], index, images);
                    },
                  ),
                ),
                if (images.length > 1)
                  Obx(() => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: AnimatedSmoothIndicator(
                          activeIndex: controller.currentImageIndex.value,
                          count: images.length,
                          effect: const ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: Colors.black,
                            dotColor: Colors.grey,
                            spacing: 8,
                          ),
                          onDotClicked: (index) {
                            controller.currentImageIndex.value = index;
                          },
                        ),
                      )),
              ],
            )
          : _buildErrorWidget(),
    );
  }

  Widget _buildImageItem(BuildContext context, String imageUrl, int index,
      List<String> allImages) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImageViewer(
              imageUrls: allImages,
              initialIndex: index,
            ),
          ),
        );
      },
      child: Hero(
        tag: 'product-image-${product.id}',
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,
          placeholder: (context, url) => Container(
            color: Colors.grey[100],
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) {
            return _buildErrorWidget();
          },
          fadeInDuration: const Duration(milliseconds: 150),
          fadeOutDuration: const Duration(milliseconds: 150),
          // Use a unique key for each image to ensure proper caching
          cacheKey: 'gallery-image-${product.id}-$imageUrl',
          memCacheWidth: 600, // Larger cache for gallery images
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 60, color: Colors.grey),
      ),
    );
  }
}
