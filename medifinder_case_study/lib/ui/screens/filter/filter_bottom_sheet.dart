import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/_filter_dropdown.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/blocs/provider_list/provider_list_bloc.dart';
import 'package:medifinder_case_study/blocs/provider_filter/provider_filter_bloc.dart';

/// Modal bottom sheet for filtering providers by country, city, and category.
/// Clean, compact layout.
class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProviderFilterBloc, ProviderFilterState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: context.styles.sheetTopRadius,
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: MediaQuery.paddingOf(context).bottom + 24,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.colorScheme.outline.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.filterTitle,
                    style: context.textTheme.titleMedium,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerHighest,
                      borderRadius: context.styles.inputRadius,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: context.styles.inputRadius,
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Dropdowns
              FilterDropdown(
                label: context.l10n.filterCountry,
                hint: context.l10n.filterCountry,
                value: state.filter.country,
                items: state.availableCountries,
                onChanged: (val) {
                  context
                      .read<ProviderFilterBloc>()
                      .add(FilterCountryChanged(val));
                },
              ),
              const SizedBox(height: 16),
              FilterDropdown(
                label: context.l10n.filterCity,
                hint: context.l10n.filterCity,
                disabledHint: context.l10n.filterSelectCountryFirst,
                value: state.filter.city,
                items: state.availableCities,
                isDisabled: state.filter.country == null,
                onChanged: (val) {
                  context
                      .read<ProviderFilterBloc>()
                      .add(FilterCityChanged(val));
                },
              ),
              const SizedBox(height: 16),
              FilterDropdown(
                label: context.l10n.filterCategory,
                hint: context.l10n.filterCategory,
                value: state.filter.category,
                items: state.availableCategories,
                onChanged: (val) {
                  context
                      .read<ProviderFilterBloc>()
                      .add(FilterCategoryChanged(val));
                },
              ),
              const SizedBox(height: 32),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        context
                            .read<ProviderFilterBloc>()
                            .add(const FilterReset());
                      },
                      child: Text(context.l10n.filterReset),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        context.read<ProviderListBloc>().add(
                              ProviderListFiltered(state.filter),
                            );
                        Navigator.pop(context);
                      },
                      child: Text(context.l10n.filterApply),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
