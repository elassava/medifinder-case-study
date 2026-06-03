import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';
import 'package:medifinder_case_study/core/utils/launch_utils.dart';
import 'package:medifinder_case_study/core/theme/app_colors.dart';

import '_section_card.dart';

/// Contact details and actions.
class DetailContact extends StatelessWidget {
  const DetailContact({super.key, required this.provider});

  final ProviderModel provider;

  bool get _hasContact =>
      provider.phone != null ||
      provider.email != null ||
      provider.address != null;

  @override
  Widget build(BuildContext context) {
    if (!_hasContact) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SectionCard(
        title: context.l10n.contactInfo,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (provider.phone != null)
              _ContactRow(
                icon: Icons.phone_outlined,
                label: context.l10n.phone,
                value: provider.phone!,
              ),
            if (provider.email != null) ...[
              if (provider.phone != null) const _Rule(),
              _ContactRow(
                icon: Icons.mail_outline_rounded,
                label: context.l10n.email,
                value: provider.email!,
              ),
            ],
            if (provider.address != null) ...[
              if (provider.phone != null || provider.email != null)
                const _Rule(),
              _ContactRow(
                icon: Icons.location_on_outlined,
                label: context.l10n.address,
                value: provider.address!,
              ),
            ],
            const SizedBox(height: 16),
            _ActionRow(provider: provider),
          ],
        ),
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: AppColors.cardBorder);
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.textTertiary(context.colorScheme)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: context.styles.fieldLabel),
                const SizedBox(height: 2),
                Text(value, style: context.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({required this.provider});

  final ProviderModel provider;

  @override
  Widget build(BuildContext context) {
    final actions = <Widget>[];

    if (provider.phone != null) {
      actions.add(
        _ContactActionButton(
          icon: Icons.phone_rounded,
          label: context.l10n.callNow,
          onPressed: () => launchPhoneCall(provider.phone!),
        ),
      );
    }

    if (provider.email != null) {
      actions.add(
        _ContactActionButton(
          icon: Icons.mail_outline_rounded,
          label: context.l10n.sendEmail,
          onPressed: () => launchEmail(provider.email!),
        ),
      );
    }

    if (actions.isEmpty) return const SizedBox.shrink();

    return Row(
      children: [
        for (var i = 0; i < actions.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          actions[i],
        ],
      ],
    );
  }
}

class _ContactActionButton extends StatelessWidget {
  const _ContactActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        style: FilledButton.styleFrom(
          backgroundColor: context.colorScheme.primary,
          foregroundColor: context.colorScheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: context.styles.buttonRadius,
          ),
          textStyle: context.textTheme.labelLarge,
        ),
      ),
    );
  }
}
