import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/core/app_colors.dart';

class FeaturedProductBadge extends StatelessWidget {
  final double borderRadius;
  final Color? badgeColor;
  final Color? borderColor;
  final Color? textColor;
  final String text;
  final IconData icon;

  const FeaturedProductBadge({
    Key? key,
    this.borderRadius = 12,
    this.badgeColor,
    this.borderColor,
    this.textColor,
    this.text = "Featured Product",
    this.icon = Icons.star,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color actualBadgeColor =
        badgeColor ?? AppColors.accentOrange.withOpacity(0.1);
    final Color actualBorderColor = borderColor ?? AppColors.accentOrange;
    final Color actualTextColor = textColor ?? AppColors.accentOrangeDark;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: actualBadgeColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: actualBorderColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: actualTextColor,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: actualTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
