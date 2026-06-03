part of 'provider_filter_bloc.dart';

/// Events for [ProviderFilterBloc].
sealed class ProviderFilterEvent extends Equatable {
  const ProviderFilterEvent();

  @override
  List<Object?> get props => [];
}

/// Initialize the filter with current filter and available options.
final class FilterInitialized extends ProviderFilterEvent {
  const FilterInitialized(this.currentFilter);
  final FilterModel currentFilter;

  @override
  List<Object?> get props => [currentFilter];
}

/// Country selection changed.
final class FilterCountryChanged extends ProviderFilterEvent {
  const FilterCountryChanged(this.country);
  final String? country;

  @override
  List<Object?> get props => [country];
}

/// City selection changed.
final class FilterCityChanged extends ProviderFilterEvent {
  const FilterCityChanged(this.city);
  final String? city;

  @override
  List<Object?> get props => [city];
}

/// Category/specialty selection changed.
final class FilterCategoryChanged extends ProviderFilterEvent {
  const FilterCategoryChanged(this.category);
  final String? category;

  @override
  List<Object?> get props => [category];
}

/// Reset all filters.
final class FilterReset extends ProviderFilterEvent {
  const FilterReset();
}
