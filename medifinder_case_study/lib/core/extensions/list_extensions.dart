/// Extension on nullable [List] for common null/empty checks.
extension NullableListX<T> on List<T>? {
  /// Returns true if the list is not null and not empty.
  bool get available => this != null && this!.isNotEmpty;
}
