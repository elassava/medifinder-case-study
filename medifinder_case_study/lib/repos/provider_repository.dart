import '../core/models/filter_model.dart';
import '../core/models/provider_model.dart';
import '../core/models/provider_page_result.dart';
import '../data/datasources/mock_provider_data.dart';

/// Repository providing healthcare provider data.
/// Acts as the single source of truth between the data layer and BLoCs.
class ProviderRepository {
  ProviderRepository({MockProviderDataSource? dataSource})
      : _dataSource = dataSource ?? MockProviderDataSource.instance;

  static const defaultPageSize = 12;

  final MockProviderDataSource _dataSource;

  List<ProviderModel> _cachedProviders = [];
  bool _catalogLoaded = false;

  /// Ensures filter dropdown options are available without loading list pages.
  Future<void> ensureCatalogLoaded() async {
    if (_catalogLoaded) return;
    _cachedProviders = await _dataSource.fetchProviders();
    _catalogLoaded = true;
  }

  /// Fetches a single page for a provider type (lazy loading).
  Future<ProviderPageResult> getProviderPage({
    required ProviderType type,
    FilterModel? filter,
    int offset = 0,
    int limit = defaultPageSize,
  }) {
    return _dataSource.fetchProviderPage(
      type: type,
      filter: filter ?? const FilterModel(),
      offset: offset,
      limit: limit,
    );
  }

  /// Total matching counts per tab for the current filter set.
  Map<ProviderType, int> getTotalCounts({FilterModel? filter}) {
    return _dataSource.countByType(filter: filter ?? const FilterModel());
  }

  /// Fetches a single provider by [id].
  Future<ProviderModel> getProviderById(String id) =>
      _dataSource.fetchProviderById(id);

  /// Returns distinct countries from cached data.
  List<String> get availableCountries {
    if (_cachedProviders.isEmpty) {
      return _dataSource.allProviders.map((p) => p.country).toSet().toList()
        ..sort();
    }
    return _cachedProviders.map((p) => p.country).toSet().toList()..sort();
  }

  /// Returns cities for a given [country] from cached data.
  List<String> getCitiesByCountry(String country) {
    final source =
        _cachedProviders.isEmpty ? _dataSource.allProviders : _cachedProviders;
    return source
        .where((p) => p.country == country)
        .map((p) => p.city)
        .toSet()
        .toList()
      ..sort();
  }

  /// Returns all distinct specialties/categories from cached data.
  List<String> get availableCategories {
    if (_cachedProviders.isEmpty) {
      return _dataSource.allProviders.map((p) => p.specialty).toSet().toList()
        ..sort();
    }
    return _cachedProviders.map((p) => p.specialty).toSet().toList()..sort();
  }
}
