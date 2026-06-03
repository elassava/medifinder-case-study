import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medifinder_case_study/blocs/theme/theme_bloc.dart';
import 'package:medifinder_case_study/ui/widgets/custom_pill_toggle.dart';

/// An animated button to toggle between light and dark mode.
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.isDark;
        return CustomPillToggle(
          value: !isDark, // true for light (left), false for dark (right)
          iconLeft: Icons.light_mode_rounded,
          iconRight: Icons.dark_mode_rounded,
          textLeft: null,
          textRight: null,
          onChanged: () => context.read<ThemeBloc>().add(const ThemeToggled()),
        );
      },
    );
  }
}
