import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductRatingBar extends StatelessWidget {
  final double rating;
  final double itemSize;
  final bool showText;
  final TextStyle? textStyle;

  const ProductRatingBar({
    Key? key,
    required this.rating,
    this.itemSize = 18,
    this.showText = true,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: rating,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: itemSize,
          ignoreGestures: true,
          itemBuilder: (_, __) => const FaIcon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
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
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
          ),
        ],
      ],
    );
  }
}
