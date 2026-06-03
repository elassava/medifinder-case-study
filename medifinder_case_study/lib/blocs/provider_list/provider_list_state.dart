part of 'provider_list_bloc.dart';

/// Status of the provider list data fetching.
enum ProviderListStatus { initial, loading, success, failure }

/// State for [ProviderListBloc] with per-tab lazy loading.
class ProviderListState extends Equatable {
  const ProviderListState({
    this.status = ProviderListStatus.initial,
    this.filter = const FilterModel(),
    this.tabProviders = const {},
    this.tabTotalCounts = const {},
    this.tabHasReachedMax = const {},
    this.tabOffsets = const {},
    this.tabLoading = const {},
    this.tabErrors = const {},
    this.errorMessage,
    this.isLoadingMore = false,
    this.loadingMoreType,
    this.isRefreshing = false,
  });

  final ProviderListStatus status;
  final FilterModel filter;
  final Map<ProviderType, List<ProviderModel>> tabProviders;
  final Map<ProviderType, int> tabTotalCounts;
  final Map<ProviderType, bool> tabHasReachedMax;
  final Map<ProviderType, int> tabOffsets;
  final Map<ProviderType, bool> tabLoading;
  final Map<ProviderType, String?> tabErrors;
  final String? errorMessage;
  final bool isLoadingMore;
  final ProviderType? loadingMoreType;
  final bool isRefreshing;

  factory ProviderListState.initial() => ProviderListState(
        tabProviders: emptyTabProviders(),
        tabOffsets: emptyTabOffsets(),
        tabHasReachedMax: emptyTabHasReachedMax(),
        tabTotalCounts: {
          for (final type in ProviderType.values) type: 0,
        },
      );

  static Map<ProviderType, List<ProviderModel>> emptyTabProviders() => {
        for (final type in ProviderType.values) type: const [],
      };

  static Map<ProviderType, int> emptyTabOffsets() => {
        for (final type in ProviderType.values) type: 0,
      };

  static Map<ProviderType, bool> emptyTabHasReachedMax() => {
        for (final type in ProviderType.values) type: false,
      };

  static Map<ProviderType, String?> emptyTabErrors() => {
        for (final type in ProviderType.values) type: null,
      };

  List<ProviderModel> providersForType(ProviderType type) =>
      tabProviders[type] ?? const [];

  int totalCountForType(ProviderType type) => tabTotalCounts[type] ?? 0;

  bool hasReachedMaxForType(ProviderType type) =>
      tabHasReachedMax[type] ?? false;

  bool isTabLoading(ProviderType type) =>
      tabLoading[type] == true ||
      ((status == ProviderListStatus.loading || isRefreshing) &&
          providersForType(type).isEmpty);

  String? tabErrorForType(ProviderType type) => tabErrors[type];

  /// Backwards-compatible helpers used in older UI/tests.
  List<ProviderModel> get providers =>
      providersForType(ProviderType.doctor);

  List<ProviderModel> get filteredProviders => [
        ...providersForType(ProviderType.doctor),
        ...providersForType(ProviderType.clinic),
        ...providersForType(ProviderType.hospital),
      ];

  List<ProviderModel> providersByType(ProviderType type) =>
      providersForType(type);

  ProviderListState copyWith({
    ProviderListStatus? status,
    FilterModel? filter,
    Map<ProviderType, List<ProviderModel>>? tabProviders,
    Map<ProviderType, int>? tabTotalCounts,
    Map<ProviderType, bool>? tabHasReachedMax,
    Map<ProviderType, int>? tabOffsets,
    Map<ProviderType, bool>? tabLoading,
    Map<ProviderType, String?>? tabErrors,
    String? errorMessage,
    bool? isLoadingMore,
    ProviderType? loadingMoreType,
    bool? isRefreshing,
  }) =>
      ProviderListState(
        status: status ?? this.status,
        filter: filter ?? this.filter,
        tabProviders: tabProviders ?? this.tabProviders,
        tabTotalCounts: tabTotalCounts ?? this.tabTotalCounts,
        tabHasReachedMax: tabHasReachedMax ?? this.tabHasReachedMax,
        tabOffsets: tabOffsets ?? this.tabOffsets,
        tabLoading: tabLoading ?? this.tabLoading,
        tabErrors: tabErrors ?? this.tabErrors,
        errorMessage: errorMessage,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        loadingMoreType: loadingMoreType,
        isRefreshing: isRefreshing ?? this.isRefreshing,
      );

  @override
  List<Object?> get props => [
        status,
        filter,
        isLoadingMore,
        loadingMoreType,
        isRefreshing,
        errorMessage,
        for (final type in ProviderType.values) tabProviders[type],
        for (final type in ProviderType.values) tabTotalCounts[type],
        for (final type in ProviderType.values) tabHasReachedMax[type],
        for (final type in ProviderType.values) tabOffsets[type],
        for (final type in ProviderType.values) tabLoading[type],
        for (final type in ProviderType.values) tabErrors[type],
      ];
}
