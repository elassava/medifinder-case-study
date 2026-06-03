import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/theme/app_colors.dart';
import 'package:medifinder_case_study/ui/widgets/polished_surface.dart';
import 'package:medifinder_case_study/ui/widgets/provider_card_hero.dart';

/// Loading placeholder matching compact grid provider cards.
class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key, this.compact = true});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final baseColor = AppColors.shimmerBase(scheme);
    final highlightColor = AppColors.shimmerHighlight(scheme);
    final blockColor = AppColors.shimmerBlock(scheme);
    final headerHeight = compact
        ? ProviderCardHero.compactHeaderHeight
        : ProviderCardHero.defaultHeaderHeight;
    final avatarOverlap = (compact
            ? ProviderCardHero.compactAvatarSize
            : ProviderCardHero.defaultAvatarSize) *
        0.35;
    final inset = compact ? 7.0 : 16.0;

    return PolishedSurface.elevated(
      context: context,
      clipBehavior: Clip.none,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              height: headerHeight,
              color: blockColor,
            ),
          ),
          SizedBox(height: avatarOverlap + (compact ? 3 : 8)),
          Padding(
            padding: EdgeInsets.fromLTRB(inset, 0, inset, inset),
            child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: compact ? 14 : 18,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: blockColor,
                      borderRadius: context.styles.skeletonLineRadius,
                    ),
                  ),
                  SizedBox(height: compact ? 8 : 10),
                  Container(
                    height: compact ? 20 : 24,
                    width: compact ? 90 : 140,
                    decoration: BoxDecoration(
                      color: blockColor,
                      borderRadius: context.styles.chipRadius,
                    ),
                  ),
                  SizedBox(height: compact ? 8 : 12),
                  Container(
                    height: compact ? 12 : 14,
                    width: compact ? 70 : 120,
                    decoration: BoxDecoration(
                      color: blockColor,
                      borderRadius: context.styles.skeletonLineRadius,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
