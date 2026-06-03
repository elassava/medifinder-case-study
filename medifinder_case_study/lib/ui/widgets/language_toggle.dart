import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medifinder_case_study/blocs/locale/locale_bloc.dart';
import 'package:medifinder_case_study/ui/widgets/custom_pill_toggle.dart';

/// A button to toggle between Turkish and English.
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        final isTr = state.isTurkish;
        return CustomPillToggle(
          value: isTr,
          iconLeft: null,
          iconRight: null,
          textLeft: 'TR',
          textRight: 'EN',
          onChanged: () {
            context.read<LocaleBloc>().add(
                  LocaleChanged(Locale(isTr ? 'en' : 'tr')),
                );
          },
        );
      },
    );
  }
}
