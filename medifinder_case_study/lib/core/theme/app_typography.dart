import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Modern sans stack — Plus Jakarta Sans across the app.
abstract final class AppTypography {
  static TextTheme buildTextTheme(Brightness brightness) {
    final base = brightness == Brightness.light
        ? ThemeData.light().textTheme
        : ThemeData.dark().textTheme;

    final theme = GoogleFonts.plusJakartaSansTextTheme(base);

    return theme.copyWith(
      displaySmall: theme.displaySmall?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.15,
      ),
      headlineSmall: theme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.35,
        height: 1.2,
      ),
      titleLarge: theme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        height: 1.25,
      ),
      titleMedium: theme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        height: 1.3,
      ),
      titleSmall: theme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
        height: 1.35,
      ),
      bodyLarge: theme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w400,
        height: 1.55,
      ),
      bodyMedium: theme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        height: 1.55,
      ),
      bodySmall: theme.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
        height: 1.45,
      ),
      labelLarge: theme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.05,
      ),
      labelMedium: theme.labelMedium?.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.02,
      ),
      labelSmall: theme.labelSmall?.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
    );
  }

  static TextStyle _sans({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double height = 1.3,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static TextStyle sectionLabel(ColorScheme scheme) {
    return _sans(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.1,
      height: 1.2,
      color: scheme.onSurface.withValues(alpha: 0.42),
    );
  }

  static TextStyle brandWordmark(ColorScheme scheme) {
    return _sans(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.4,
      height: 1.1,
      color: scheme.onSurface,
    );
  }

  static TextStyle displayName(ColorScheme scheme) {
    return _sans(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
      height: 1.2,
      color: scheme.onSurface,
    );
  }

  static TextStyle cardTitle(ColorScheme scheme) {
    return _sans(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
      height: 1.25,
      color: scheme.onSurface,
    );
  }

  static TextStyle gridCardTitle(ColorScheme scheme) {
    return _sans(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.15,
      height: 1.2,
      color: scheme.onSurface,
    );
  }

  static TextStyle specialtyBadgeLabel(ColorScheme scheme) {
    return _sans(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: AppColors.specialtyBadgeText,
    );
  }

  static TextStyle gridSpecialtyBadgeLabel(ColorScheme scheme) {
    return _sans(
      fontSize: 9.5,
      fontWeight: FontWeight.w600,
      height: 1.15,
      color: AppColors.specialtyBadgeText,
    );
  }

  static TextStyle cardSubtitle(ColorScheme scheme) {
    return _sans(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 1.35,
      color: AppColors.textSecondary(scheme),
    );
  }

  static TextStyle cardMeta(ColorScheme scheme) {
    return _sans(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.3,
      color: AppColors.textTertiary(scheme),
    );
  }

  static TextStyle gridCardMeta(ColorScheme scheme) {
    return _sans(
      fontSize: 9.5,
      fontWeight: FontWeight.w500,
      height: 1.25,
      color: AppColors.textTertiary(scheme),
    );
  }

  static TextStyle fieldLabel(ColorScheme scheme) {
    return _sans(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
      height: 1.25,
      color: AppColors.textTertiary(scheme),
    );
  }

  static TextStyle metricValue(ColorScheme scheme) {
    return _sans(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.1,
      height: 1.2,
      color: scheme.onSurface,
    );
  }

  static TextStyle metricLabel(ColorScheme scheme) {
    return _sans(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.25,
      color: AppColors.textTertiary(scheme),
    );
  }

  static TextStyle bodyReading(ColorScheme scheme) {
    return _sans(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.65,
      color: scheme.onSurface.withValues(alpha: 0.82),
    );
  }

  static TextStyle ratingValue(ColorScheme scheme) {
    return _sans(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: scheme.onSurface,
    );
  }

  static TextStyle ratingCount(ColorScheme scheme) {
    return _sans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.2,
      color: AppColors.textTertiary(scheme),
    );
  }

  static TextStyle badgeLabel(ColorScheme scheme) {
    return _sans(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: scheme.onSurface,
    );
  }

  static TextStyle tabLabelActive(ColorScheme scheme) {
    return _sans(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.02,
      height: 1.2,
      color: scheme.primary,
    );
  }

  static TextStyle tabLabelInactive(ColorScheme scheme) {
    return _sans(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.02,
      height: 1.2,
      color: scheme.onSurface.withValues(alpha: 0.45),
    );
  }

  static TextStyle filterFieldLabel(ColorScheme scheme) {
    return _sans(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.02,
      height: 1.25,
      color: scheme.onSurface.withValues(alpha: 0.7),
    );
  }
}
