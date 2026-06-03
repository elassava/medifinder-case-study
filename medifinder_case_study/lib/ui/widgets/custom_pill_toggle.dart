import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';

/// A modern, beautiful, animated pill-shaped toggle switch.
class CustomPillToggle extends StatelessWidget {
  const CustomPillToggle({
    super.key,
    required this.value,
    required this.onChanged,
    required this.iconLeft,
    required this.iconRight,
    required this.textLeft,
    required this.textRight,
  });

  /// True for left selected, false for right selected.
  final bool value;
  final VoidCallback onChanged;

  final IconData? iconLeft;
  final IconData? iconRight;
  final String? textLeft;
  final String? textRight;

  @override
  Widget build(BuildContext context) {
    const double width = 80;
    const double height = 32;
    const double padding = 2;
    const double indicatorWidth = (width - padding * 2) / 2;

    return GestureDetector(
      onTap: onChanged,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.colorScheme.onSurface.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Sliding indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.fastOutSlowIn,
              left: value ? padding : (width / 2),
              top: padding,
              bottom: padding,
              width: indicatorWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: context.theme.brightness == Brightness.light
                      ? Colors.white
                      : context.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular((height - padding * 2) / 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
            // Icons or Texts
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: context.textTheme.labelLarge!.copyWith(
                        color: value
                            ? context.colorScheme.onSurface
                            : context.colorScheme.onSurface
                                .withValues(alpha: 0.5),
                      ),
                      child: _buildChild(iconLeft, textLeft),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: context.textTheme.labelLarge!.copyWith(
                        color: !value
                            ? context.colorScheme.onSurface
                            : context.colorScheme.onSurface
                                .withValues(alpha: 0.5),
                      ),
                      child: _buildChild(iconRight, textRight),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChild(IconData? icon, String? text) {
    if (icon != null) {
      return Icon(icon, size: 18, color: null);
    }
    if (text != null) {
      return Text(text);
    }
    return const SizedBox.shrink();
  }
}
