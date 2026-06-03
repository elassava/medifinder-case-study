import 'package:flutter/material.dart';

/// MediFinder brand color palette.
/// Inspired by the MediFinder website design system.
/// No red accent in default palette — teal and blue only.
abstract final class AppColors {
  // ── Brand Primary ──
  static const Color primaryBlue = Color(0xFF3280FF);
  static const Color primaryBlueDark = Color(0xFF2563EB);
  static const Color primaryBlueLight = Color(0xFF60A5FA);

  // ── Accent ──
  static const Color tealAccent = Color(0xFF00BFA6);
  static const Color tealAccentDark = Color(0xFF009688);
  static const Color tealAccentLight = Color(0xFF4DD0C8);
  static const Color specialtyBadgeBg = Color(0xFFE6FAF7);
  static const Color specialtyBadgeText = Color(0xFF00897B);

  // ── Provider Type Colors ──
  static const Color doctorColor = tealAccent;
  static const Color clinicColor = primaryBlue;
  static const Color hospitalColor = Color(0xFF7C3AED);

  // ── Semantic ──
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = primaryBlue;

  // ── Light Mode Surfaces ──
  /// Clinical canvas — cool gray behind white cards.
  static const Color clinicalCanvas = Color(0xFFE9EEF3);
  static const Color cardBorder = Color(0xFFD8E0E8);
  static const Color lightBackground = Color(0xFFE9EEF3);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightDivider = Color(0xFFE2E8F0);

  // ── Dark Mode Surfaces ──
  static const Color darkBackground = Color(0xFF0F1117);
  static const Color darkSurface = Color(0xFF1A1D27);
  static const Color darkCard = Color(0xFF222633);
  static const Color darkDivider = Color(0xFF2D3348);

  // ── Text — Light Mode ──
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextTertiary = Color(0xFF94A3B8);

  // ── Text — Dark Mode ──
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextTertiary = Color(0xFF64748B);

  // ── Rating ──
  static const Color starFilled = Color(0xFFFBBF24);
  static const Color starEmpty = Color(0xFFD1D5DB);

  /// Secondary text color for current brightness.
  static Color textSecondary(ColorScheme scheme) =>
      scheme.brightness == Brightness.light
          ? lightTextSecondary
          : darkTextSecondary;

  /// Tertiary text color for current brightness.
  static Color textTertiary(ColorScheme scheme) =>
      scheme.brightness == Brightness.light
          ? lightTextTertiary
          : darkTextTertiary;

  /// Neutral chip / flag background for current brightness.
  static Color neutralSurface(ColorScheme scheme) =>
      scheme.brightness == Brightness.light
          ? const Color(0xFFF4F6F8)
          : scheme.surfaceContainerHighest;

  /// Specialty badge background for current brightness.
  static Color specialtyBadgeBackground(ColorScheme scheme) =>
      scheme.brightness == Brightness.light
          ? specialtyBadgeBg
          : tealAccent.withValues(alpha: 0.15);

  /// Shimmer placeholder colors.
  static Color shimmerBase(ColorScheme scheme) =>
      scheme.surfaceContainerHighest;

  static Color shimmerHighlight(ColorScheme scheme) =>
      scheme.surfaceContainerLow;

  static Color shimmerBlock(ColorScheme scheme) => scheme.surface;
}
