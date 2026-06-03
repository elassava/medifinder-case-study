import 'package:flutter/material.dart';

import 'app_shapes.dart';
import 'app_typography.dart';

/// Semantic typography + shape tokens exposed through [ThemeData].
@immutable
class AppStyleExtension extends ThemeExtension<AppStyleExtension> {
  const AppStyleExtension({
    required this.cardRadius,
    required this.inputRadius,
    required this.buttonRadius,
    required this.chipRadius,
    required this.avatarRadius,
    required this.skeletonLineRadius,
    required this.tabRadius,
    required this.sheetTopRadius,
    required this.sectionLabel,
    required this.brandWordmark,
    required this.displayName,
    required this.cardTitle,
    required this.gridCardTitle,
    required this.specialtyBadgeLabel,
    required this.gridSpecialtyBadgeLabel,
    required this.cardSubtitle,
    required this.cardMeta,
    required this.gridCardMeta,
    required this.fieldLabel,
    required this.metricValue,
    required this.metricLabel,
    required this.bodyReading,
    required this.ratingValue,
    required this.ratingCount,
    required this.chipLabel,
    required this.badgeLabel,
    required this.tabLabelActive,
    required this.tabLabelInactive,
    required this.filterFieldLabel,
    required this.filterAction,
  });

  final BorderRadius cardRadius;
  final BorderRadius inputRadius;
  final BorderRadius buttonRadius;
  final BorderRadius chipRadius;
  final BorderRadius avatarRadius;
  final BorderRadius skeletonLineRadius;
  final BorderRadius tabRadius;
  final BorderRadius sheetTopRadius;

  final TextStyle sectionLabel;
  final TextStyle brandWordmark;
  final TextStyle displayName;
  final TextStyle cardTitle;
  final TextStyle gridCardTitle;
  final TextStyle specialtyBadgeLabel;
  final TextStyle gridSpecialtyBadgeLabel;
  final TextStyle cardSubtitle;
  final TextStyle cardMeta;
  final TextStyle gridCardMeta;
  final TextStyle fieldLabel;
  final TextStyle metricValue;
  final TextStyle metricLabel;
  final TextStyle bodyReading;
  final TextStyle ratingValue;
  final TextStyle ratingCount;
  final TextStyle chipLabel;
  final TextStyle badgeLabel;
  final TextStyle tabLabelActive;
  final TextStyle tabLabelInactive;
  final TextStyle filterFieldLabel;
  final TextStyle filterAction;

  factory AppStyleExtension.from(ColorScheme scheme) {
    return AppStyleExtension(
      cardRadius: AppShapes.radiusLg,
      inputRadius: AppShapes.radiusMd,
      buttonRadius: AppShapes.radiusMd,
      chipRadius: AppShapes.radiusSm,
      avatarRadius: AppShapes.radiusMd,
      skeletonLineRadius: AppShapes.radiusXxs,
      tabRadius: AppShapes.radiusLg,
      sheetTopRadius: AppShapes.verticalTopXl,
      sectionLabel: AppTypography.sectionLabel(scheme),
      brandWordmark: AppTypography.brandWordmark(scheme),
      displayName: AppTypography.displayName(scheme),
      cardTitle: AppTypography.cardTitle(scheme),
      gridCardTitle: AppTypography.gridCardTitle(scheme),
      specialtyBadgeLabel: AppTypography.specialtyBadgeLabel(scheme),
      gridSpecialtyBadgeLabel: AppTypography.gridSpecialtyBadgeLabel(scheme),
      cardSubtitle: AppTypography.cardSubtitle(scheme),
      cardMeta: AppTypography.cardMeta(scheme),
      gridCardMeta: AppTypography.gridCardMeta(scheme),
      fieldLabel: AppTypography.fieldLabel(scheme),
      metricValue: AppTypography.metricValue(scheme),
      metricLabel: AppTypography.metricLabel(scheme),
      bodyReading: AppTypography.bodyReading(scheme),
      ratingValue: AppTypography.ratingValue(scheme),
      ratingCount: AppTypography.ratingCount(scheme),
      chipLabel: AppTypography.cardMeta(scheme),
      badgeLabel: AppTypography.badgeLabel(scheme),
      tabLabelActive: AppTypography.tabLabelActive(scheme),
      tabLabelInactive: AppTypography.tabLabelInactive(scheme),
      filterFieldLabel: AppTypography.filterFieldLabel(scheme),
      filterAction: AppTypography.ratingValue(scheme).copyWith(
        color: scheme.primary,
      ),
    );
  }

  @override
  AppStyleExtension copyWith({
    BorderRadius? cardRadius,
    BorderRadius? inputRadius,
    BorderRadius? buttonRadius,
    BorderRadius? chipRadius,
    BorderRadius? avatarRadius,
    BorderRadius? skeletonLineRadius,
    BorderRadius? tabRadius,
    BorderRadius? sheetTopRadius,
    TextStyle? sectionLabel,
    TextStyle? brandWordmark,
    TextStyle? displayName,
    TextStyle? cardTitle,
    TextStyle? gridCardTitle,
    TextStyle? specialtyBadgeLabel,
    TextStyle? gridSpecialtyBadgeLabel,
    TextStyle? cardSubtitle,
    TextStyle? cardMeta,
    TextStyle? gridCardMeta,
    TextStyle? fieldLabel,
    TextStyle? metricValue,
    TextStyle? metricLabel,
    TextStyle? bodyReading,
    TextStyle? ratingValue,
    TextStyle? ratingCount,
    TextStyle? chipLabel,
    TextStyle? badgeLabel,
    TextStyle? tabLabelActive,
    TextStyle? tabLabelInactive,
    TextStyle? filterFieldLabel,
    TextStyle? filterAction,
  }) {
    return AppStyleExtension(
      cardRadius: cardRadius ?? this.cardRadius,
      inputRadius: inputRadius ?? this.inputRadius,
      buttonRadius: buttonRadius ?? this.buttonRadius,
      chipRadius: chipRadius ?? this.chipRadius,
      avatarRadius: avatarRadius ?? this.avatarRadius,
      skeletonLineRadius: skeletonLineRadius ?? this.skeletonLineRadius,
      tabRadius: tabRadius ?? this.tabRadius,
      sheetTopRadius: sheetTopRadius ?? this.sheetTopRadius,
      sectionLabel: sectionLabel ?? this.sectionLabel,
      brandWordmark: brandWordmark ?? this.brandWordmark,
      displayName: displayName ?? this.displayName,
      cardTitle: cardTitle ?? this.cardTitle,
      gridCardTitle: gridCardTitle ?? this.gridCardTitle,
      specialtyBadgeLabel: specialtyBadgeLabel ?? this.specialtyBadgeLabel,
      gridSpecialtyBadgeLabel:
          gridSpecialtyBadgeLabel ?? this.gridSpecialtyBadgeLabel,
      cardSubtitle: cardSubtitle ?? this.cardSubtitle,
      cardMeta: cardMeta ?? this.cardMeta,
      gridCardMeta: gridCardMeta ?? this.gridCardMeta,
      fieldLabel: fieldLabel ?? this.fieldLabel,
      metricValue: metricValue ?? this.metricValue,
      metricLabel: metricLabel ?? this.metricLabel,
      bodyReading: bodyReading ?? this.bodyReading,
      ratingValue: ratingValue ?? this.ratingValue,
      ratingCount: ratingCount ?? this.ratingCount,
      chipLabel: chipLabel ?? this.chipLabel,
      badgeLabel: badgeLabel ?? this.badgeLabel,
      tabLabelActive: tabLabelActive ?? this.tabLabelActive,
      tabLabelInactive: tabLabelInactive ?? this.tabLabelInactive,
      filterFieldLabel: filterFieldLabel ?? this.filterFieldLabel,
      filterAction: filterAction ?? this.filterAction,
    );
  }

  @override
  AppStyleExtension lerp(ThemeExtension<AppStyleExtension>? other, double t) {
    if (other is! AppStyleExtension) return this;
    return AppStyleExtension(
      cardRadius: BorderRadius.lerp(cardRadius, other.cardRadius, t)!,
      inputRadius: BorderRadius.lerp(inputRadius, other.inputRadius, t)!,
      buttonRadius: BorderRadius.lerp(buttonRadius, other.buttonRadius, t)!,
      chipRadius: BorderRadius.lerp(chipRadius, other.chipRadius, t)!,
      avatarRadius: BorderRadius.lerp(avatarRadius, other.avatarRadius, t)!,
      skeletonLineRadius:
          BorderRadius.lerp(skeletonLineRadius, other.skeletonLineRadius, t)!,
      tabRadius: BorderRadius.lerp(tabRadius, other.tabRadius, t)!,
      sheetTopRadius: BorderRadius.lerp(sheetTopRadius, other.sheetTopRadius, t)!,
      sectionLabel: TextStyle.lerp(sectionLabel, other.sectionLabel, t)!,
      brandWordmark: TextStyle.lerp(brandWordmark, other.brandWordmark, t)!,
      displayName: TextStyle.lerp(displayName, other.displayName, t)!,
      cardTitle: TextStyle.lerp(cardTitle, other.cardTitle, t)!,
      gridCardTitle: TextStyle.lerp(gridCardTitle, other.gridCardTitle, t)!,
      specialtyBadgeLabel:
          TextStyle.lerp(specialtyBadgeLabel, other.specialtyBadgeLabel, t)!,
      gridSpecialtyBadgeLabel: TextStyle.lerp(
        gridSpecialtyBadgeLabel,
        other.gridSpecialtyBadgeLabel,
        t,
      )!,
      cardSubtitle: TextStyle.lerp(cardSubtitle, other.cardSubtitle, t)!,
      cardMeta: TextStyle.lerp(cardMeta, other.cardMeta, t)!,
      gridCardMeta: TextStyle.lerp(gridCardMeta, other.gridCardMeta, t)!,
      fieldLabel: TextStyle.lerp(fieldLabel, other.fieldLabel, t)!,
      metricValue: TextStyle.lerp(metricValue, other.metricValue, t)!,
      metricLabel: TextStyle.lerp(metricLabel, other.metricLabel, t)!,
      bodyReading: TextStyle.lerp(bodyReading, other.bodyReading, t)!,
      ratingValue: TextStyle.lerp(ratingValue, other.ratingValue, t)!,
      ratingCount: TextStyle.lerp(ratingCount, other.ratingCount, t)!,
      chipLabel: TextStyle.lerp(chipLabel, other.chipLabel, t)!,
      badgeLabel: TextStyle.lerp(badgeLabel, other.badgeLabel, t)!,
      tabLabelActive: TextStyle.lerp(tabLabelActive, other.tabLabelActive, t)!,
      tabLabelInactive:
          TextStyle.lerp(tabLabelInactive, other.tabLabelInactive, t)!,
      filterFieldLabel:
          TextStyle.lerp(filterFieldLabel, other.filterFieldLabel, t)!,
      filterAction: TextStyle.lerp(filterAction, other.filterAction, t)!,
    );
  }
}
