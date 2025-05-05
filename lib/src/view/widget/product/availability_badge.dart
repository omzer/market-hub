import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/core/app_colors.dart';

class AvailabilityBadge extends StatelessWidget {
  final bool isAvailable;
  final double borderRadius;

  const AvailabilityBadge({
    Key? key,
    required this.isAvailable,
    this.borderRadius = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableColor = AppColors.primaryGreen;
    final unavailableColor = Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isAvailable
            ? availableColor.withOpacity(0.1)
            : unavailableColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAvailable ? Icons.check_circle : Icons.cancel,
            color: isAvailable ? availableColor : unavailableColor,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            isAvailable ? "متوفر في المخزن" : "غير متوفر في المخزن",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isAvailable ? availableColor : unavailableColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
