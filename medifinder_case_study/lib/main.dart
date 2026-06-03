import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medifinder_case_study/l10n/app_localizations.dart';

import 'blocs/locale/locale_bloc.dart';
import 'blocs/provider_filter/provider_filter_bloc.dart';
import 'blocs/provider_list/provider_list_bloc.dart';
import 'blocs/theme/theme_bloc.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'repos/provider_repository.dart';

void main() {
  runApp(const MediFinderApp());
}

/// Root widget for the MediFinder application.
class MediFinderApp extends StatelessWidget {
  const MediFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ProviderRepository();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: repository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeBloc()),
          BlocProvider(create: (_) => LocaleBloc()),
          BlocProvider(
            create: (_) => ProviderListBloc(repository: repository)
              ..add(const ProviderListFetched()),
          ),
          BlocProvider(
            create: (_) => ProviderFilterBloc(repository: repository),
          ),
        ],
        child: const _AppView(),
      ),
    );
  }
}

/// Inner app view that reacts to theme and locale changes.
class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, localeState) {
            return MaterialApp.router(
              title: 'MediFinder',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeState.themeMode,
              locale: localeState.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: AppRouter.router,
            );
          },
        );
      },
    );
  }
}
