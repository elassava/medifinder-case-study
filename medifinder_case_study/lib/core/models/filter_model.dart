import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_model.freezed.dart';

/// Represents the current filter state for provider search.
@freezed
abstract class FilterModel with _$FilterModel {
  const factory FilterModel({
    String? country,
    String? city,
    String? category,
    @Default('') String searchQuery,
  }) = _FilterModel;

  /// Factory for an empty/default filter.
  static const empty = FilterModel();
}

/// Extension getters on [FilterModel] for convenience checks.
extension FilterModelX on FilterModel {
  /// Whether any filter is actively applied.
  bool get hasActiveFilters =>
      country != null || city != null || category != null;

  /// The number of active filter selections (excluding search).
  int get activeFilterCount =>
      (country != null ? 1 : 0) +
      (city != null ? 1 : 0) +
      (category != null ? 1 : 0);
}
