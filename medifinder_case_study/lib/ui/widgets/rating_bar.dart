import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/theme/app_colors.dart';

/// Star rating display.
class RatingBar extends StatelessWidget {
  const RatingBar({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.size = 16,
    this.showCount = true,
  });

  final double rating;
  final int reviewCount;
  final double size;
  final bool showCount;

  @override
  Widget build(BuildContext context) {
    final styles = context.styles;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (index) {
          final starValue = index + 1;
          IconData icon;
          if (rating >= starValue) {
            icon = Icons.star_rounded;
          } else if (rating >= starValue - 0.5) {
            icon = Icons.star_half_rounded;
          } else {
            icon = Icons.star_outline_rounded;
          }
          return Icon(
            icon,
            size: size,
            color: rating >= starValue - 0.5
                ? AppColors.starFilled
                : AppColors.starEmpty,
          );
        }),
        const SizedBox(width: 4),
        Text(rating.toStringAsFixed(1), style: styles.ratingValue),
        if (showCount) ...[
          const SizedBox(width: 4),
          Text('($reviewCount)', style: styles.ratingCount),
        ],
      ],
    );
  }
}
