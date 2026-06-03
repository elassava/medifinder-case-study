import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/ui/widgets/polished_surface.dart';

/// Segmented tab bar with a sliding pill indicator and smooth label transitions.
class AnimatedSegmentedTabBar extends StatelessWidget {
  const AnimatedSegmentedTabBar({
    super.key,
    required this.controller,
    required this.tabs,
  });

  final TabController controller;
  final List<String> tabs;

  static const _duration = Duration(milliseconds: 320);
  static const _curve = Curves.easeOutCubic;

  void _onTabTap(int index) {
    if (controller.index == index) return;
    controller.animateTo(index, duration: _duration, curve: _curve);
  }

  @override
  Widget build(BuildContext context) {
    final styles = context.styles;
    final primary = context.colorScheme.primary;
    final unselected =
        context.colorScheme.onSurface.withValues(alpha: 0.45);

    return PolishedSurface.elevated(
      context: context,
      borderRadius: styles.tabRadius,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 42,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final tabWidth = constraints.maxWidth / tabs.length;
            const inset = 4.0;

            return AnimatedBuilder(
              animation: controller.animation!,
              builder: (context, _) {
                final position = controller.animation!.value;
                final pillLeft = tabWidth * position + inset;
                final pillWidth = tabWidth - inset * 2;

                return Stack(
                  children: [
                    Positioned(
                      left: pillLeft,
                      top: inset,
                      bottom: inset,
                      width: pillWidth,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: primary.withValues(alpha: 0.12),
                          borderRadius: styles.chipRadius,
                          boxShadow: [
                            BoxShadow(
                              color: primary.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(tabs.length, (index) {
                        final distance =
                            (position - index).abs().clamp(0.0, 1.0);
                        final selection = 1.0 - distance;
                        final scale = 1.0 + (selection * 0.02);

                        return Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => _onTabTap(index),
                            child: Center(
                              child: Transform.scale(
                                scale: scale,
                                child: Text(
                                  tabs[index],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle.lerp(
                                    styles.tabLabelInactive.copyWith(
                                      color: unselected,
                                    ),
                                    styles.tabLabelActive.copyWith(
                                      color: primary,
                                    ),
                                    Curves.easeOut.transform(selection),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/// Subtle scale + fade while swiping between tabs.
class TabTransitionWrapper extends StatelessWidget {
  const TabTransitionWrapper({
    super.key,
    required this.controller,
    required this.tabIndex,
    required this.child,
  });

  final TabController controller;
  final int tabIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animation!,
      builder: (context, child) {
        final distance = (controller.animation!.value - tabIndex).abs();
        final visibility = (1 - distance).clamp(0.0, 1.0);
        final scale = 0.96 + (0.04 * Curves.easeOut.transform(visibility));
        final slide = (controller.animation!.value - tabIndex) * 12;

        return Transform.translate(
          offset: Offset(slide, 0),
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.topCenter,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
