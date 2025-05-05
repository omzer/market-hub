import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/core/app_colors.dart';

class PriceDisplay extends StatelessWidget {
  final String currentPrice;
  final String? originalPrice;
  final double currentPriceSize;
  final double originalPriceSize;
  final Color? priceColor;
  final bool showCurrency;
  final String currencySymbol;

  const PriceDisplay({
    Key? key,
    required this.currentPrice,
    this.originalPrice,
    this.currentPriceSize = 16,
    this.originalPriceSize = 12,
    this.priceColor,
    this.showCurrency = true,
    this.currencySymbol = '\$',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color displayPriceColor = priceColor ?? AppColors.primaryGreen;

    return Row(
      children: [
        Text(
          showCurrency ? "$currencySymbol$currentPrice" : currentPrice,
          style: TextStyle(
            fontSize: currentPriceSize,
            fontWeight: FontWeight.bold,
            color: displayPriceColor,
          ),
        ),
        if (originalPrice != null && originalPrice!.isNotEmpty) ...[
          const SizedBox(width: 4),
          Text(
            showCurrency ? "$currencySymbol$originalPrice" : originalPrice!,
            style: TextStyle(
              fontSize: originalPriceSize,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }
}
