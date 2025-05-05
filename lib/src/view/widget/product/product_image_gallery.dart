import 'package:flutter/material.dart';

class ProductImageGallery extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: backgroundColor,
      child: images.isNotEmpty
          ? PageView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.network(
                  images[index],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildErrorWidget();
                  },
                );
              },
            )
          : _buildErrorWidget(),
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
