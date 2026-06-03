import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';
import 'package:medifinder_case_study/core/theme/app_theme.dart';
import 'package:medifinder_case_study/ui/widgets/type_badge.dart';
import 'package:medifinder_case_study/l10n/app_localizations.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      theme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(body: child),
    );
  }

  group('TypeBadge Widget', () {
    testWidgets('displays Doctor label correctly', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const TypeBadge(type: ProviderType.doctor)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Doctor'), findsOneWidget);
    });

    testWidgets('displays Clinic label correctly', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const TypeBadge(type: ProviderType.clinic)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Clinic'), findsOneWidget);
    });

    testWidgets('displays Hospital label correctly', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const TypeBadge(type: ProviderType.hospital)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Hospital'), findsOneWidget);
    });
  });
}
