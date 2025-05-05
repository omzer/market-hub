import 'package:flutter/material.dart';

class FeaturedProductBadge extends StatelessWidget {
  final double borderRadius;
  final Color badgeColor;
  final Color borderColor;
  final Color textColor;
  final String text;
  final IconData icon;

  const FeaturedProductBadge({
    Key? key,
    this.borderRadius = 12,
    this.badgeColor = const Color(0xFFFFF8E1), // Light amber
    this.borderColor = Colors.amber,
    this.textColor = Colors.amber,
    this.text = "Featured Product",
    this.icon = Icons.star,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: textColor,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
