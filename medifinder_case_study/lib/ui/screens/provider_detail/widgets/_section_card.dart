import 'package:flutter/material.dart';
import 'package:medifinder_case_study/ui/widgets/section_label.dart';
import 'package:medifinder_case_study/ui/widgets/polished_surface.dart';

/// White polished section container for detail screens.
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.child,
    this.title,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final String? title;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) SectionLabel(title: title!),
        PolishedCard(padding: padding, child: child),
      ],
    );
  }
}
