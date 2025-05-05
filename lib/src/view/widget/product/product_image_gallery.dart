import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_flutter/src/controller/products_controller.dart';
import 'package:e_commerce_flutter/src/model/new_product.dart';

class ProductImageGallery extends GetView<ProductsController> {
  final Product product;
  final double height;
  final Color backgroundColor;

  ProductImageGallery({
    Key? key,
    required this.product,
    this.height = 300,
    this.backgroundColor = const Color(0xFFF5F5F5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Reset image index when this widget is built with a new product
    controller.resetImageIndex();

    final List<String> images = product.imagesList;

    return Container(
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
                      return _buildImageItem(images[index]);
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

  Widget _buildImageItem(String imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,
          errorWidget: (context, url, error) {
            return _buildErrorWidget();
          },
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
