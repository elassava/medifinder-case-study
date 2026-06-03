import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/theme/app_colors.dart';

/// Compact rating badge — star + score, used on list cards.
class RatingPill extends StatelessWidget {
  const RatingPill({
    super.key,
    required this.rating,
    this.showCount = false,
    this.reviewCount = 0,
  });

  final double rating;
  final bool showCount;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.starFilled.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_rounded,
            size: 14,
            color: AppColors.starFilled,
          ),
          const SizedBox(width: 3),
          Text(
            rating.toStringAsFixed(1),
            style: context.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface,
            ),
          ),
          if (showCount) ...[
            Text(
              ' · $reviewCount',
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.45),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
