import 'package:flutter/material.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isAvailable ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAvailable ? Icons.check_circle : Icons.cancel,
            color: isAvailable ? Colors.green : Colors.red,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            isAvailable ? "In Stock" : "Out of Stock",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isAvailable ? Colors.green : Colors.red,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
