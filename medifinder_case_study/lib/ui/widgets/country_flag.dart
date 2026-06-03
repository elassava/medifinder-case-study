import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/theme/app_colors.dart';

/// Small circular country flag used on provider cards.
class CountryFlag extends StatelessWidget {
  const CountryFlag({
    super.key,
    required this.country,
    this.size = 22,
  });

  final String country;
  final double size;

  static String emojiFor(String country) => switch (country) {
        'Türkiye' => '🇹🇷',
        'UK' => '🇬🇧',
        'USA' => '🇺🇸',
        'Germany' => '🇩🇪',
        'France' => '🇫🇷',
        'Italy' => '🇮🇹',
        'Spain' => '🇪🇸',
        'Canada' => '🇨🇦',
        'Australia' => '🇦🇺',
        _ => '🌍',
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.neutralSurface(context.colorScheme),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        emojiFor(country),
        style: context.textTheme.labelSmall,
      ),
    );
  }
}
