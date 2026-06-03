import 'package:flutter/material.dart';

import 'country_flag.dart';
import 'polished_surface.dart';
import 'provider_card_hero.dart';
import 'specialty_badge.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';
import 'package:medifinder_case_study/core/theme/app_colors.dart';

/// Website-style provider card — cover, avatar overlap, teal specialty badge.
class ProviderCard extends StatelessWidget {
  const ProviderCard({
    super.key,
    required this.provider,
    required this.onTap,
    this.compact = true,
  });

  final ProviderModel provider;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final styles = context.styles;
    final hero = ProviderCardHero(provider: provider, compact: compact);
    final inset = compact ? 7.0 : 16.0;

    return PolishedCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          hero,
          SizedBox(height: hero.avatarOverlap + (compact ? 3 : 8)),
          Padding(
            padding: EdgeInsets.fromLTRB(inset, 0, inset, compact ? 7 : inset),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        provider.name,
                        style: compact
                            ? styles.gridCardTitle
                            : styles.cardTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (provider.isVerified)
                      Padding(
                        padding: const EdgeInsets.only(left: 3, top: 1),
                        child: Icon(
                          Icons.verified_rounded,
                          color: AppColors.tealAccent,
                          size: compact ? 12 : 18,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: compact ? 4 : 8),
                SpecialtyBadge(
                  label: provider.specialty.localizeData(context),
                  compact: compact,
                ),
                SizedBox(height: compact ? 5 : 10),
                Row(
                  children: [
                    CountryFlag(
                      country: provider.country,
                      size: compact ? 15 : 22,
                    ),
                    SizedBox(width: compact ? 4 : 8),
                    Expanded(
                      child: Text(
                        '${provider.city.localizeData(context)}, ${provider.country.localizeData(context)}',
                        style: compact
                            ? styles.gridCardMeta
                            : styles.cardMeta,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
