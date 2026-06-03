import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/theme/app_colors.dart';

/// Teal pill badge matching the MediFinder website specialty tags.
class SpecialtyBadge extends StatelessWidget {
  const SpecialtyBadge({
    super.key,
    required this.label,
    this.compact = false,
  });

  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final styles = context.styles;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : 10,
        vertical: compact ? 2.5 : 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.specialtyBadgeBackground(context.colorScheme),
        borderRadius: context.styles.chipRadius,
      ),
      child: Text(
        label,
        style: compact
            ? styles.gridSpecialtyBadgeLabel
            : styles.specialtyBadgeLabel,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
