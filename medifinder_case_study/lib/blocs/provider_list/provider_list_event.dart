part of 'provider_list_bloc.dart';

/// Events for [ProviderListBloc].
sealed class ProviderListEvent extends Equatable {
  const ProviderListEvent();

  @override
  List<Object?> get props => [];
}

/// Initial catalog warmup and first tab page.
final class ProviderListFetched extends ProviderListEvent {
  const ProviderListFetched();
}

/// Lazy-loads the first page when a tab becomes visible.
final class ProviderListTabOpened extends ProviderListEvent {
  const ProviderListTabOpened(this.type);

  final ProviderType type;

  @override
  List<Object?> get props => [type];
}

/// Search providers by query string.
final class ProviderListSearched extends ProviderListEvent {
  const ProviderListSearched(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

/// Apply a filter to the provider list.
final class ProviderListFiltered extends ProviderListEvent {
  const ProviderListFiltered(this.filter);

  final FilterModel filter;

  @override
  List<Object?> get props => [filter];
}

/// Pull-to-refresh for a specific tab.
final class ProviderListRefreshed extends ProviderListEvent {
  const ProviderListRefreshed(this.type);

  final ProviderType type;

  @override
  List<Object?> get props => [type];
}

/// Load next page for a specific provider type tab.
final class ProviderListLoadMore extends ProviderListEvent {
  const ProviderListLoadMore(this.type);

  final ProviderType type;

  @override
  List<Object?> get props => [type];
}
