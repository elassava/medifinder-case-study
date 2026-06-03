import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medifinder_case_study/core/models/filter_model.dart';
import 'package:medifinder_case_study/repos/provider_repository.dart';

part 'provider_filter_event.dart';
part 'provider_filter_state.dart';

/// BLoC managing filter state for the filter bottom sheet.
class ProviderFilterBloc
    extends Bloc<ProviderFilterEvent, ProviderFilterState> {
  ProviderFilterBloc({required this._repository})
      : super(ProviderFilterState(
          filter: const FilterModel(),
          availableCountries: _repository.availableCountries,
          availableCities: const [],
          availableCategories: _repository.availableCategories,
        )) {
    on<FilterCountryChanged>(_onCountryChanged);
    on<FilterCityChanged>(_onCityChanged);
    on<FilterCategoryChanged>(_onCategoryChanged);
    on<FilterReset>(_onReset);
    on<FilterInitialized>(_onInitialized);
  }

  final ProviderRepository _repository;

  /// Initializes filter options from the repository.
  void _onInitialized(
    FilterInitialized event,
    Emitter<ProviderFilterState> emit,
  ) {
    emit(state.copyWith(
      filter: event.currentFilter,
      availableCountries: _repository.availableCountries,
      availableCategories: _repository.availableCategories,
      availableCities: event.currentFilter.country != null
          ? _repository.getCitiesByCountry(event.currentFilter.country!)
          : [],
    ));
  }

  /// Updates available cities when country changes.
  void _onCountryChanged(
    FilterCountryChanged event,
    Emitter<ProviderFilterState> emit,
  ) {
    final cities = event.country != null
        ? _repository.getCitiesByCountry(event.country!)
        : <String>[];

    emit(state.copyWith(
      filter: state.filter.copyWith(country: event.country, city: null),
      availableCities: cities,
    ));
  }

  void _onCityChanged(
    FilterCityChanged event,
    Emitter<ProviderFilterState> emit,
  ) {
    emit(state.copyWith(
      filter: state.filter.copyWith(city: event.city),
    ));
  }

  void _onCategoryChanged(
    FilterCategoryChanged event,
    Emitter<ProviderFilterState> emit,
  ) {
    emit(state.copyWith(
      filter: state.filter.copyWith(category: event.category),
    ));
  }

  void _onReset(
    FilterReset event,
    Emitter<ProviderFilterState> emit,
  ) {
    emit(state.copyWith(
      filter: const FilterModel(),
      availableCities: const [],
    ));
  }
}
