import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';
import 'package:medifinder_case_study/core/theme/app_colors.dart';

/// Compact type indicator on list cards when needed elsewhere.
class TypeBadge extends StatelessWidget {
  const TypeBadge({super.key, required this.type});

  final ProviderType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: context.styles.chipRadius,
      ),
      child: Text(
        _localizedLabel(context),
        style: context.styles.badgeLabel.copyWith(color: _foregroundColor),
      ),
    );
  }

  String _localizedLabel(BuildContext context) => switch (type) {
        ProviderType.doctor => context.l10n.providerTypeDoctor,
        ProviderType.clinic => context.l10n.providerTypeClinic,
        ProviderType.hospital => context.l10n.providerTypeHospital,
      };

  Color get _backgroundColor => switch (type) {
        ProviderType.doctor => AppColors.doctorColor.withValues(alpha: 0.1),
        ProviderType.clinic => AppColors.clinicColor.withValues(alpha: 0.1),
        ProviderType.hospital =>
          AppColors.hospitalColor.withValues(alpha: 0.1),
      };

  Color get _foregroundColor => switch (type) {
        ProviderType.doctor => AppColors.doctorColor,
        ProviderType.clinic => AppColors.clinicColor,
        ProviderType.hospital => AppColors.hospitalColor,
      };
}
