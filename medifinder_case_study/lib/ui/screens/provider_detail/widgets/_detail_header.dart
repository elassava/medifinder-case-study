import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';
import 'package:medifinder_case_study/core/theme/app_colors.dart';
import 'package:medifinder_case_study/ui/widgets/country_flag.dart';
import 'package:medifinder_case_study/ui/widgets/polished_surface.dart';
import 'package:medifinder_case_study/ui/widgets/provider_card_hero.dart';
import 'package:medifinder_case_study/ui/widgets/rating_bar.dart';
import 'package:medifinder_case_study/ui/widgets/specialty_badge.dart';

/// Profile summary card — website-style hero + metrics.
class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key, required this.provider});

  static const _avatarOverlap = ProviderCardHero.defaultAvatarSize * 0.35;

  final ProviderModel provider;

  @override
  Widget build(BuildContext context) {
    final styles = context.styles;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: PolishedCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProviderCardHero(
              provider: provider,
              compact: false,
              showActions: true,
            ),
            const SizedBox(height: _avatarOverlap + 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          provider.name,
                          style: styles.displayName,
                        ),
                      ),
                      if (provider.isVerified)
                        const Icon(
                          Icons.verified_rounded,
                          color: AppColors.tealAccent,
                          size: 20,
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SpecialtyBadge(
                    label: provider.specialty.localizeData(context),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CountryFlag(country: provider.country),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${provider.city.localizeData(context)}, ${provider.country.localizeData(context)}',
                          style: styles.cardMeta,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  RatingBar(
                    rating: provider.rating,
                    reviewCount: provider.reviewCount,
                    size: 14,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.cardBorder),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _MetricCell(
                      value: provider.rating.toStringAsFixed(1),
                      label: context.l10n.reviews(provider.reviewCount),
                    ),
                  ),
                  if (provider.yearsOfExperience > 0) ...[
                    _verticalRule(),
                    Expanded(
                      child: _MetricCell(
                        value: '${provider.yearsOfExperience}',
                        label: context.l10n.yearsExperience(
                          provider.yearsOfExperience,
                        ),
                      ),
                    ),
                  ],
                  if (provider.isVerified) ...[
                    _verticalRule(),
                    Expanded(
                      child: _MetricCell(
                        value: '✓',
                        label: context.l10n.verified,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _verticalRule() {
    return Container(
      width: 1,
      height: 36,
      color: AppColors.cardBorder,
    );
  }
}

class _MetricCell extends StatelessWidget {
  const _MetricCell({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final styles = context.styles;
    return Column(
      children: [
        Text(value, style: styles.metricValue, textAlign: TextAlign.center),
        const SizedBox(height: 2),
        Text(
          label,
          style: styles.metricLabel,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
