import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';
import 'package:medifinder_case_study/core/theme/app_colors.dart';

import '_section_card.dart';

/// Languages and services.
class DetailInfoList extends StatelessWidget {
  const DetailInfoList({super.key, required this.provider});

  final ProviderModel provider;

  @override
  Widget build(BuildContext context) {
    if (provider.languages.isEmpty && provider.services.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (provider.languages.isNotEmpty)
            SectionCard(
              title: context.l10n.languages,
              child: _ChipWrap(items: provider.languages),
            ),
          if (provider.languages.isNotEmpty && provider.services.isNotEmpty)
            const SizedBox(height: 12),
          if (provider.services.isNotEmpty)
            SectionCard(
              title: context.l10n.services,
              child: _ChipWrap(items: provider.services),
            ),
        ],
      ),
    );
  }
}

class _ChipWrap extends StatelessWidget {
  const _ChipWrap({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.neutralSurface(context.colorScheme),
            borderRadius: context.styles.chipRadius,
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Text(
            item.localizeTag(context),
            style: context.styles.chipLabel,
          ),
        );
      }).toList(),
    );
  }
}
