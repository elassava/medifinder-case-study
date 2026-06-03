import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medifinder_case_study/blocs/locale/locale_bloc.dart';
import 'package:medifinder_case_study/blocs/provider_filter/provider_filter_bloc.dart';
import 'package:medifinder_case_study/blocs/provider_list/provider_list_bloc.dart';
import 'package:medifinder_case_study/blocs/theme/theme_bloc.dart';
import 'package:medifinder_case_study/core/theme/app_theme.dart';
import 'package:medifinder_case_study/ui/screens/provider_list/provider_list_screen.dart';
import 'package:medifinder_case_study/ui/screens/provider_list/widgets/_animated_tab_bar.dart';
import 'package:medifinder_case_study/ui/screens/provider_list/widgets/_app_bar.dart';
import 'package:medifinder_case_study/ui/screens/provider_list/widgets/_provider_list_body.dart';
import 'package:mocktail/mocktail.dart';
import 'package:medifinder_case_study/l10n/app_localizations.dart';

class MockProviderListBloc extends Mock implements ProviderListBloc {}
class MockProviderFilterBloc extends Mock implements ProviderFilterBloc {}
class MockThemeBloc extends Mock implements ThemeBloc {}
class MockLocaleBloc extends Mock implements LocaleBloc {}

void main() {
  late MockProviderListBloc listBloc;
  late MockProviderFilterBloc filterBloc;
  late MockThemeBloc themeBloc;
  late MockLocaleBloc localeBloc;

  setUp(() {
    listBloc = MockProviderListBloc();
    filterBloc = MockProviderFilterBloc();
    themeBloc = MockThemeBloc();
    localeBloc = MockLocaleBloc();

    when(() => themeBloc.state).thenReturn(const ThemeState());
    when(() => themeBloc.stream).thenAnswer((_) => const Stream.empty());

    when(() => localeBloc.state).thenReturn(const LocaleState(locale: Locale('en')));
    when(() => localeBloc.stream).thenAnswer((_) => const Stream.empty());

    when(() => filterBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTestableWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>.value(value: themeBloc),
        BlocProvider<LocaleBloc>.value(value: localeBloc),
        BlocProvider<ProviderListBloc>.value(value: listBloc),
        BlocProvider<ProviderFilterBloc>.value(value: filterBloc),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('en'),
        home: ProviderListScreen(),
      ),
    );
  }

  group('ProviderListScreen', () {
    testWidgets('renders App Bar, Search Section, and segmented tabs', (tester) async {
      when(() => listBloc.state).thenReturn(const ProviderListState(
        status: ProviderListStatus.success,
      ));
      when(() => listBloc.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(ProviderListAppBar), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(AnimatedSegmentedTabBar), findsOneWidget);
      expect(find.text('Doctor'), findsOneWidget);
      expect(find.text('Clinic'), findsOneWidget);
      expect(find.text('Hospital'), findsOneWidget);
      expect(find.byType(ProviderListBody), findsWidgets);
    });

    testWidgets('shows loading shimmer when status is loading and empty', (tester) async {
      when(() => listBloc.state).thenReturn(const ProviderListState(
        status: ProviderListStatus.loading,
      ));
      when(() => listBloc.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(buildTestableWidget());

      // We don't pumpAndSettle here because shimmer has an infinite animation
      await tester.pump();

      // Verify shimmer grid exists in the list body
      expect(find.byType(GridView), findsWidgets);
    });
  });
}
