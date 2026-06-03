import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/ui/widgets/language_toggle.dart';

/// App bar with logo and brand wordmark.
class ProviderListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProviderListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final wordmark = context.styles.brandWordmark;

    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/logo/medifinder-logo.png',
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          RichText(
            text: TextSpan(
              style: wordmark,
              children: [
                TextSpan(
                  text: 'medi',
                  style: wordmark.copyWith(color: context.colorScheme.primary),
                ),
                const TextSpan(text: 'finder'),
              ],
            ),
          ),
        ],
      ),
      actions: const [
        LanguageToggle(),
        SizedBox(width: 12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
