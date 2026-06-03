import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/theme/app_colors.dart';

/// Shared surface system — rounded Material shadows (not BoxShadow).
abstract final class PolishedSurface {
  /// Card elevation — Material draws a shadow that follows [borderRadius].
  static double elevation(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? 1.5 : 2;

  /// Soft shadow tint for elevated surfaces.
  static Color shadowColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Colors.black.withValues(alpha: 0.10)
          : Colors.black.withValues(alpha: 0.35);

  static Color fillColor(BuildContext context, {Color? color}) {
    if (color != null) return color;
    return Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : AppColors.darkCard;
  }

  /// Flat fill decoration — no shadow. Prefer [elevated] for lifted cards.
  static BoxDecoration decoration(
    BuildContext context, {
    BorderRadius? borderRadius,
    Color? color,
    Border? border,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final radius = borderRadius ?? context.styles.cardRadius;

    return BoxDecoration(
      color: fillColor(context, color: color),
      borderRadius: radius,
      border: border ??
          (isLight
              ? Border.all(color: AppColors.cardBorder.withValues(alpha: 0.6))
              : Border.all(color: AppColors.darkDivider)),
    );
  }

  /// Wraps [child] in a [Material] so the shadow follows rounded corners.
  static Widget elevated({
    required BuildContext context,
    required Widget child,
    BorderRadius? borderRadius,
    Color? color,
    double? elevation,
    Clip clipBehavior = Clip.none,
    VoidCallback? onTap,
    EdgeInsetsGeometry? padding,
  }) {
    final radius = borderRadius ?? context.styles.cardRadius;
    final surfaceColor = fillColor(context, color: color);
    final surfaceElevation = elevation ?? PolishedSurface.elevation(context);
    final surfaceShadow = shadowColor(context);

    Widget content = child;
    if (padding != null) {
      content = Padding(padding: padding, child: content);
    }

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: radius,
        splashFactory: InkRipple.splashFactory,
        child: content,
      );
    }

    return Material(
      color: surfaceColor,
      elevation: surfaceElevation,
      shadowColor: surfaceShadow,
      borderRadius: radius,
      clipBehavior: clipBehavior,
      child: content,
    );
  }
}

/// White polished card with rounded Material shadow.
class PolishedCard extends StatelessWidget {
  const PolishedCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.onTap,
    this.borderRadius,
    this.clipBehavior = Clip.none,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? context.styles.cardRadius;

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: PolishedSurface.elevated(
        context: context,
        borderRadius: radius,
        clipBehavior: clipBehavior,
        onTap: onTap,
        padding: padding,
        child: child,
      ),
    );
  }
}
