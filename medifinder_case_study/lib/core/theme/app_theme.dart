import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_shapes.dart';
import 'app_style_extension.dart';
import 'app_typography.dart';

/// MediFinder theme — white canvas, shadow-lifted cards, Plus Jakarta Sans.
abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.light(
      primary: AppColors.primaryBlue,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryBlue.withValues(alpha: 0.08),
      onPrimaryContainer: AppColors.primaryBlueDark,
      secondary: AppColors.tealAccent,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.tealAccent.withValues(alpha: 0.08),
      onSecondaryContainer: AppColors.tealAccentDark,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,
      surfaceContainerHighest: const Color(0xFFFBFCFD),
      error: AppColors.error,
      onError: Colors.white,
      outline: const Color(0xFFD8E0E8),
      outlineVariant: const Color(0xFFE9EEF3),
    );

    return _buildTheme(colorScheme, Brightness.light);
  }

  static ThemeData get dark {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.primaryBlueLight,
      onPrimary: AppColors.darkBackground,
      primaryContainer: AppColors.primaryBlue.withValues(alpha: 0.15),
      onPrimaryContainer: AppColors.primaryBlueLight,
      secondary: AppColors.tealAccentLight,
      onSecondary: AppColors.darkBackground,
      secondaryContainer: AppColors.tealAccent.withValues(alpha: 0.15),
      onSecondaryContainer: AppColors.tealAccentLight,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
      surfaceContainerHighest: const Color(0xFF1E2230),
      error: AppColors.error,
      onError: Colors.white,
      outline: const Color(0xFF2A3040),
      outlineVariant: const Color(0xFF1E2230),
    );

    return _buildTheme(colorScheme, Brightness.dark);
  }

  static ThemeData _buildTheme(ColorScheme colorScheme, Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final textTheme = AppTypography.buildTextTheme(brightness);
    final styles = AppStyleExtension.from(colorScheme);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      extensions: [styles],
      scaffoldBackgroundColor: isLight
          ? Colors.white
          : AppColors.darkBackground,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: isLight
            ? Colors.white
            : AppColors.darkBackground,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleMedium?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: isLight ? Colors.white : AppColors.darkCard,
        shadowColor: Colors.black.withValues(alpha: 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: styles.cardRadius,
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight ? Colors.white : AppColors.darkCard,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: styles.inputRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: styles.inputRadius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: styles.inputRadius,
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textTertiary(colorScheme),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        labelStyle: styles.chipLabel,
        shape: RoundedRectangleBorder(borderRadius: styles.chipRadius),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: AppShapes.verticalTopXl,
        ),
        dragHandleColor: colorScheme.outline,
        showDragHandle: false,
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.cardBorder,
        thickness: 1,
        space: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: styles.buttonRadius),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          side: BorderSide(color: AppColors.cardBorder),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: styles.buttonRadius),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: AppShapes.radiusSm),
          textStyle: textTheme.labelLarge,
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: colorScheme.primary,
        unselectedLabelColor: AppColors.textTertiary(colorScheme),
        indicatorColor: colorScheme.primary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerHeight: 0,
        labelStyle: textTheme.labelMedium,
        unselectedLabelStyle: textTheme.labelMedium,
      ),
    );
  }
}
