import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductImageGallery extends StatefulWidget {
  final List<String> images;
  final double height;
  final Color backgroundColor;

  const ProductImageGallery({
    Key? key,
    required this.images,
    this.height = 300,
    this.backgroundColor = const Color(0xFFF5F5F5),
  }) : super(key: key);

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: widget.images.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: CarouselSlider.builder(
                    itemCount: widget.images.length,
                    options: CarouselOptions(
                      height: widget.height - 40,
                      viewportFraction: 1.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: widget.images.length > 1,
                      autoPlay: widget.images.length > 1,
                      autoPlayInterval: const Duration(seconds: 4),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return _buildImageItem(widget.images[index]);
                    },
                  ),
                ),
                if (widget.images.length > 1)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: AnimatedSmoothIndicator(
                      activeIndex: _currentIndex,
                      count: widget.images.length,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Colors.black,
                        dotColor: Colors.grey,
                        spacing: 8,
                      ),
                      onDotClicked: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
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
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
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
