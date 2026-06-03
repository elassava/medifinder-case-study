import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/filter_model.dart';
import '../../core/models/provider_model.dart';
import '../../core/models/provider_page_result.dart';
import '../../repos/provider_repository.dart';

part 'provider_list_event.dart';
part 'provider_list_state.dart';

/// BLoC managing the provider list, search, filter, and per-tab pagination.
class ProviderListBloc extends Bloc<ProviderListEvent, ProviderListState> {
  ProviderListBloc({required this._repository})
      : super(ProviderListState.initial()) {
    on<ProviderListFetched>(_onFetched);
    on<ProviderListTabOpened>(_onTabOpened);
    on<ProviderListSearched>(_onSearched);
    on<ProviderListFiltered>(_onFiltered);
    on<ProviderListRefreshed>(_onRefreshed);
    on<ProviderListLoadMore>(_onLoadMore);
  }

  final ProviderRepository _repository;

  Future<void> _onFetched(
    ProviderListFetched event,
    Emitter<ProviderListState> emit,
  ) async {
    emit(state.copyWith(status: ProviderListStatus.loading, errorMessage: null));
    try {
      await _repository.ensureCatalogLoaded();
      final counts = _repository.getTotalCounts();
      final doctorPage = await _repository.getProviderPage(
        type: ProviderType.doctor,
      );

      emit(
        _mergePage(
          state: state,
          type: ProviderType.doctor,
          page: doctorPage,
          counts: counts,
          status: ProviderListStatus.success,
          replace: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProviderListStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onTabOpened(
    ProviderListTabOpened event,
    Emitter<ProviderListState> emit,
  ) async {
    if (state.providersForType(event.type).isNotEmpty) return;
    if (state.isTabLoading(event.type)) return;

    emit(
      state.copyWith(
        tabLoading: {...state.tabLoading, event.type: true},
        tabErrors: {...state.tabErrors, event.type: null},
        errorMessage: null,
      ),
    );

    try {
      final page = await _repository.getProviderPage(
        type: event.type,
        filter: state.filter,
      );
      final counts = _repository.getTotalCounts(filter: state.filter);

      emit(
        _mergePage(
          state: state,
          type: event.type,
          page: page,
          counts: counts,
          status: ProviderListStatus.success,
          replace: true,
          tabLoading: {...state.tabLoading, event.type: false},
          tabErrors: {...state.tabErrors, event.type: null},
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          tabLoading: {...state.tabLoading, event.type: false},
          tabErrors: {...state.tabErrors, event.type: e.toString()},
          status: state.providersForType(ProviderType.doctor).isEmpty
              ? ProviderListStatus.failure
              : state.status,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSearched(
    ProviderListSearched event,
    Emitter<ProviderListState> emit,
  ) async {
    final filter = state.filter.copyWith(searchQuery: event.query);
    await _reloadAllTabs(emit, filter);
  }

  Future<void> _onFiltered(
    ProviderListFiltered event,
    Emitter<ProviderListState> emit,
  ) async {
    final filter = event.filter.copyWith(
      searchQuery: state.filter.searchQuery,
    );
    await _reloadAllTabs(emit, filter);
  }

  Future<void> _reloadAllTabs(
    Emitter<ProviderListState> emit,
    FilterModel filter,
  ) async {
    emit(
      state.copyWith(
        status: ProviderListStatus.success,
        isRefreshing: true,
        filter: filter,
        tabProviders: ProviderListState.emptyTabProviders(),
        tabOffsets: ProviderListState.emptyTabOffsets(),
        tabHasReachedMax: ProviderListState.emptyTabHasReachedMax(),
        tabErrors: ProviderListState.emptyTabErrors(),
        errorMessage: null,
      ),
    );

    try {
      final pages = await Future.wait(
        ProviderType.values.map(
          (type) => _repository.getProviderPage(
            type: type,
            filter: filter,
          ),
        ),
      );

      emit(
        _stateFromAllPages(
          filter: filter,
          pages: {
            for (var i = 0; i < ProviderType.values.length; i++)
              ProviderType.values[i]: pages[i],
          },
          status: ProviderListStatus.success,
          isRefreshing: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isRefreshing: false,
          status: ProviderListStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRefreshed(
    ProviderListRefreshed event,
    Emitter<ProviderListState> emit,
  ) async {
    emit(
      state.copyWith(
        isRefreshing: true,
        errorMessage: null,
      ),
    );

    try {
      final page = await _repository.getProviderPage(
        type: event.type,
        filter: state.filter,
      );
      final counts = _repository.getTotalCounts(filter: state.filter);

      emit(
        _mergePage(
          state: state,
          type: event.type,
          page: page,
          counts: counts,
          status: ProviderListStatus.success,
          replace: true,
          isRefreshing: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isRefreshing: false,
          status: ProviderListStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadMore(
    ProviderListLoadMore event,
    Emitter<ProviderListState> emit,
  ) async {
    if (state.isLoadingMore ||
        state.hasReachedMaxForType(event.type) ||
        state.providersForType(event.type).isEmpty) {
      return;
    }

    emit(
      state.copyWith(
        isLoadingMore: true,
        loadingMoreType: event.type,
      ),
    );

    try {
      final page = await _repository.getProviderPage(
        type: event.type,
        filter: state.filter,
        offset: state.tabOffsets[event.type] ?? 0,
      );

      if (page.items.isEmpty) {
        emit(
          state.copyWith(
            isLoadingMore: false,
            loadingMoreType: null,
            tabHasReachedMax: {
              ...state.tabHasReachedMax,
              event.type: true,
            },
          ),
        );
        return;
      }

      final existing = state.providersForType(event.type);
      emit(
        state.copyWith(
          isLoadingMore: false,
          loadingMoreType: null,
          tabProviders: {
            ...state.tabProviders,
            event.type: [...existing, ...page.items],
          },
          tabOffsets: {
            ...state.tabOffsets,
            event.type: page.nextOffset,
          },
          tabHasReachedMax: {
            ...state.tabHasReachedMax,
            event.type: !page.hasMore,
          },
          tabTotalCounts: {
            ...state.tabTotalCounts,
            event.type: page.totalCount,
          },
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          loadingMoreType: null,
        ),
      );
    }
  }

  ProviderListState _mergePage({
    required ProviderListState state,
    required ProviderType type,
    required ProviderPageResult page,
    required Map<ProviderType, int> counts,
    required ProviderListStatus status,
    required bool replace,
    Map<ProviderType, bool>? tabLoading,
    Map<ProviderType, String?>? tabErrors,
    bool? isRefreshing,
  }) {
    final existing = state.providersForType(type);
    final mergedItems = replace ? page.items : [...existing, ...page.items];

    return state.copyWith(
      status: status,
      isRefreshing: isRefreshing,
      tabLoading: tabLoading,
      tabErrors: tabErrors,
      tabProviders: {...state.tabProviders, type: mergedItems},
      tabOffsets: {...state.tabOffsets, type: page.nextOffset},
      tabHasReachedMax: {...state.tabHasReachedMax, type: !page.hasMore},
      tabTotalCounts: counts,
    );
  }

  ProviderListState _stateFromAllPages({
    required FilterModel filter,
    required Map<ProviderType, ProviderPageResult> pages,
    required ProviderListStatus status,
    bool isRefreshing = false,
  }) {
    final tabProviders = <ProviderType, List<ProviderModel>>{};
    final tabOffsets = <ProviderType, int>{};
    final tabHasReachedMax = <ProviderType, bool>{};
    final tabTotalCounts = <ProviderType, int>{};

    for (final type in ProviderType.values) {
      final page = pages[type]!;
      tabProviders[type] = page.items;
      tabOffsets[type] = page.nextOffset;
      tabHasReachedMax[type] = !page.hasMore;
      tabTotalCounts[type] = page.totalCount;
    }

    return ProviderListState(
      status: status,
      filter: filter,
      tabProviders: tabProviders,
      tabOffsets: tabOffsets,
      tabHasReachedMax: tabHasReachedMax,
      tabTotalCounts: tabTotalCounts,
      tabErrors: ProviderListState.emptyTabErrors(),
      isRefreshing: isRefreshing,
    );
  }
}
