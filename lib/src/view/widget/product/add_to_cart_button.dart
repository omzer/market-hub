import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color buttonColor;
  final String text;
  final double height;
  final double width;
  final double borderRadius;
  final bool showIcon;
  final IconData icon;

  const AddToCartButton({
    Key? key,
    required this.onPressed,
    this.buttonColor = Colors.deepOrange,
    this.text = "Add to Cart",
    this.height = 48,
    this.width = 150,
    this.borderRadius = 12,
    this.showIcon = true,
    this.icon = Icons.shopping_cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon) ...[
              Icon(icon),
              const SizedBox(width: 8),
            ],
            Text(text),
          ],
        ),
      ),
    );
  }
}
