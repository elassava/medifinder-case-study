part of 'provider_filter_bloc.dart';

/// State for [ProviderFilterBloc].
class ProviderFilterState extends Equatable {
  const ProviderFilterState({
    required this.filter,
    required this.availableCountries,
    required this.availableCities,
    required this.availableCategories,
  });

  final FilterModel filter;
  final List<String> availableCountries;
  final List<String> availableCities;
  final List<String> availableCategories;

  ProviderFilterState copyWith({
    FilterModel? filter,
    List<String>? availableCountries,
    List<String>? availableCities,
    List<String>? availableCategories,
  }) =>
      ProviderFilterState(
        filter: filter ?? this.filter,
        availableCountries: availableCountries ?? this.availableCountries,
        availableCities: availableCities ?? this.availableCities,
        availableCategories: availableCategories ?? this.availableCategories,
      );

  @override
  List<Object?> get props => [
        filter,
        availableCountries,
        availableCities,
        availableCategories,
      ];
}
