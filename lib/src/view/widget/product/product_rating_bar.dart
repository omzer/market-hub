import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_commerce_flutter/core/app_colors.dart';

class ProductRatingBar extends StatelessWidget {
  final double rating;
  final double itemSize;
  final bool showText;
  final TextStyle? textStyle;
  final Color? starColor;

  const ProductRatingBar({
    Key? key,
    required this.rating,
    this.itemSize = 18,
    this.showText = true,
    this.textStyle,
    this.starColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color ratingStarColor = starColor ?? AppColors.accentOrange;

    return Row(
      children: [
        RatingBar.builder(
          initialRating: rating,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: itemSize,
          ignoreGestures: true,
          itemBuilder: (_, __) => FaIcon(
            FontAwesomeIcons.solidStar,
            color: ratingStarColor,
          ),
          onRatingUpdate: (_) {},
        ),
        if (showText) ...[
          const SizedBox(width: 8),
          Text(
            "($rating/5)",
            style: textStyle ??
                TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.neutralBrown,
                  fontSize: 14,
                ),
          ),
        ],
      ],
    );
  }
}
