import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medifinder_case_study/blocs/provider_detail/provider_detail_bloc.dart';
import 'package:medifinder_case_study/repos/provider_repository.dart';
import 'package:medifinder_case_study/ui/screens/provider_detail/provider_detail_screen.dart';
import 'package:medifinder_case_study/ui/screens/provider_list/provider_list_screen.dart';
import 'package:medifinder_case_study/ui/screens/splash/splash_screen.dart';

/// App-wide router configuration using go_router.
/// Routes:
///   /              → ProviderListScreen
///   /provider/:id  → ProviderDetailScreen
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'provider-list',
        builder: (context, state) => const ProviderListScreen(),
      ),
      GoRoute(
        path: '/provider/:id',
        name: 'provider-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BlocProvider(
            create: (context) => ProviderDetailBloc(
              repository: context.read<ProviderRepository>(),
            )..add(ProviderDetailFetched(id)),
            child: const ProviderDetailScreen(),
          );
        },
      ),
    ],
  );
}
