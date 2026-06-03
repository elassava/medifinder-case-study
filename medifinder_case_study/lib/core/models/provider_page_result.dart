import 'package:medifinder_case_study/core/models/provider_model.dart';

/// Paginated API response for provider list queries.
class ProviderPageResult {
  const ProviderPageResult({
    required this.items,
    required this.totalCount,
    required this.offset,
    required this.limit,
  });

  final List<ProviderModel> items;
  final int totalCount;
  final int offset;
  final int limit;

  bool get hasMore => offset + items.length < totalCount;

  int get nextOffset => offset + items.length;
}
