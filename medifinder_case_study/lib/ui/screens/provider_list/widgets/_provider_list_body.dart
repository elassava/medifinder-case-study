import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '_shimmer_card.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';
import 'package:medifinder_case_study/blocs/provider_list/provider_list_bloc.dart';
import 'package:medifinder_case_study/ui/widgets/provider_card.dart';
import 'package:medifinder_case_study/ui/widgets/state_widgets.dart';

/// The main content body of the provider list screen.
/// Handles loading, error, empty, and success states.
class ProviderListBody extends StatefulWidget {
  const ProviderListBody({
    super.key,
    required this.activeTab,
    required this.tabIndex,
    required this.tabController,
  });

  final ProviderType activeTab;
  final int tabIndex;
  final TabController tabController;

  @override
  State<ProviderListBody> createState() => _ProviderListBodyState();
}

class _ProviderListBodyState extends State<ProviderListBody>
    with AutomaticKeepAliveClientMixin {
  static const _gridCrossAxisCount = 2;
  static const _gridSpacing = 14.0;
  static const _gridAspectRatio = 0.95;
  static const _horizontalPadding = 16.0;

  final _scrollController = ScrollController();
  int _lastActiveIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _lastActiveIndex = widget.tabController.index;
    widget.tabController.addListener(_onTabAnimation);
    _openTabIfNeeded();
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_onTabAnimation);
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _openTabIfNeeded() {
    context.read<ProviderListBloc>().add(
          ProviderListTabOpened(widget.activeTab),
        );
  }

  void _onTabAnimation() {
    if (widget.tabController.indexIsChanging) return;

    if (widget.tabController.index == widget.tabIndex &&
        _lastActiveIndex != widget.tabIndex) {
      _openTabIfNeeded();
    }
    _lastActiveIndex = widget.tabController.index;
  }

  bool _shouldRebuild(ProviderListState previous, ProviderListState current) {
    final type = widget.activeTab;

    if (previous.providersForType(type) != current.providersForType(type)) {
      return true;
    }
    if (previous.isTabLoading(type) != current.isTabLoading(type)) {
      return true;
    }
    if (previous.tabErrorForType(type) != current.tabErrorForType(type)) {
      return true;
    }
    if (previous.totalCountForType(type) != current.totalCountForType(type)) {
      return true;
    }
    if (previous.isRefreshing != current.isRefreshing &&
        current.providersForType(type).isEmpty) {
      return true;
    }
    if (previous.isLoadingMore != current.isLoadingMore &&
        (previous.loadingMoreType == type ||
            current.loadingMoreType == type)) {
      return true;
    }
    if (type == ProviderType.doctor &&
        previous.status != current.status &&
        current.providersForType(type).isEmpty) {
      return true;
    }
    return false;
  }

  void _onScroll() {
    if (!_isBottom) return;

    final bloc = context.read<ProviderListBloc>();
    final state = bloc.state;
    if (state.isLoadingMore ||
        state.hasReachedMaxForType(widget.activeTab) ||
        state.providersForType(widget.activeTab).isEmpty) {
      return;
    }

    bloc.add(ProviderListLoadMore(widget.activeTab));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  SliverGridDelegate get _gridDelegate =>
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _gridCrossAxisCount,
        mainAxisSpacing: _gridSpacing,
        crossAxisSpacing: _gridSpacing,
        childAspectRatio: _gridAspectRatio,
      );

  Widget _buildShimmerGrid() {
    return GridView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.all(_horizontalPadding),
      gridDelegate: _gridDelegate,
      itemCount: 6,
      itemBuilder: (_, _) => const ShimmerCard(compact: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ProviderListBloc, ProviderListState>(
      buildWhen: _shouldRebuild,
      builder: (context, state) {
        final providers = state.providersForType(widget.activeTab);
        final totalCount = state.totalCountForType(widget.activeTab);
        final isInitialLoading =
            state.status == ProviderListStatus.loading &&
                state.providersForType(ProviderType.doctor).isEmpty;
        final isTabLoading = state.isTabLoading(widget.activeTab);

        if (isInitialLoading && widget.activeTab == ProviderType.doctor) {
          return _buildShimmerGrid();
        }

        if (state.status == ProviderListStatus.failure &&
            providers.isEmpty &&
            widget.activeTab == ProviderType.doctor) {
          return ErrorView(
            message: state.errorMessage ?? context.l10n.errorMessage,
            onRetry: () => context
                .read<ProviderListBloc>()
                .add(const ProviderListFetched()),
          );
        }

        if (isTabLoading) {
          return _buildShimmerGrid();
        }

        final tabError = state.tabErrorForType(widget.activeTab);
        if (tabError != null && providers.isEmpty) {
          return ErrorView(
            message: tabError,
            onRetry: () => context
                .read<ProviderListBloc>()
                .add(ProviderListTabOpened(widget.activeTab)),
          );
        }

        if (providers.isEmpty) {
          return const EmptyView();
        }

        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<ProviderListBloc>()
                .add(ProviderListRefreshed(widget.activeTab));
            await context.read<ProviderListBloc>().stream.firstWhere(
                  (s) => !s.isRefreshing,
                );
          },
          child: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  _horizontalPadding,
                  0,
                  _horizontalPadding,
                  8,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    context.l10n.resultsCount(totalCount),
                    style: context.styles.cardMeta,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: _horizontalPadding,
                ),
                sliver: SliverGrid(
                  gridDelegate: _gridDelegate,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final provider = providers[index];
                      return ProviderCard(
                        key: ValueKey(provider.id),
                        provider: provider,
                        compact: true,
                        onTap: () =>
                            context.push('/provider/${provider.id}'),
                      );
                    },
                    childCount: providers.length,
                  ),
                ),
              ),
              if (state.isLoadingMore &&
                  state.loadingMoreType == widget.activeTab)
                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
                ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
            ],
          ),
        );
      },
    );
  }
}
