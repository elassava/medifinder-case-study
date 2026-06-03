import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/models/filter_model.dart';
import 'package:medifinder_case_study/blocs/provider_list/provider_list_bloc.dart';
import 'package:medifinder_case_study/ui/widgets/search_field.dart';
import 'package:medifinder_case_study/ui/widgets/polished_surface.dart';

/// Section containing the search field and active filter chips.
class SearchSection extends StatelessWidget {
  const SearchSection({super.key, required this.onFilterTap});

  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProviderListBloc, ProviderListState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SearchField(
                      initialValue: state.filter.searchQuery,
                      onChanged: (query) {
                        context
                            .read<ProviderListBloc>()
                            .add(ProviderListSearched(query));
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  _FilterButton(
                    onTap: onFilterTap,
                    activeFilterCount: state.filter.activeFilterCount,
                  ),
                ],
              ),
              if (state.filter.hasActiveFilters) ...[
                const SizedBox(height: 10),
                _ActiveFilters(filter: state.filter),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    required this.onTap,
    required this.activeFilterCount,
  });

  final VoidCallback onTap;
  final int activeFilterCount;

  @override
  Widget build(BuildContext context) {
    final hasActive = activeFilterCount > 0;
    return PolishedSurface.elevated(
      context: context,
      borderRadius: context.styles.inputRadius,
      clipBehavior: Clip.antiAlias,
      onTap: onTap,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.tune_rounded,
              size: 20,
              color: hasActive
                  ? context.colorScheme.primary
                  : context.colorScheme.onSurface.withValues(alpha: 0.45),
            ),
            if (hasActive)
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ActiveFilters extends StatelessWidget {
  const _ActiveFilters({required this.filter});

  final FilterModel filter;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (filter.country != null) _Chip(label: filter.country!),
          if (filter.city != null) _Chip(label: filter.city!),
          if (filter.category != null) _Chip(label: filter.category!),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              context
                  .read<ProviderListBloc>()
                  .add(const ProviderListFiltered(FilterModel()));
            },
            child: Text(
              context.l10n.filterReset,
              style: context.styles.filterAction,
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer,
          borderRadius: context.styles.chipRadius,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label.localizeData(context),
              style: context.styles.chipLabel.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                final bloc = context.read<ProviderListBloc>();
                final current = bloc.state.filter;
                final updated = current.copyWith(
                  country: current.country == label ? null : current.country,
                  city: current.city == label ? null : current.city,
                  category: current.category == label ? null : current.category,
                );
                bloc.add(ProviderListFiltered(updated));
              },
              child: Icon(
                Icons.close_rounded,
                size: 14,
                color: context.colorScheme.primary.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
