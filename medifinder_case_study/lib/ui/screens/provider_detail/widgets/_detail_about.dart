import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';

import '_section_card.dart';

/// About / bio section.
class DetailAbout extends StatelessWidget {
  const DetailAbout({super.key, required this.provider});

  final ProviderModel provider;

  @override
  Widget build(BuildContext context) {
    if (provider.bio == null || provider.bio!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SectionCard(
        title: context.l10n.about,
        child: Text(
          provider.bio!,
          style: context.styles.bodyReading,
        ),
      ),
    );
  }
}
