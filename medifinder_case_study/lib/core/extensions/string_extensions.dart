/// Extension on [String?] for common null/empty checks.
extension NullableStringX on String? {
  /// Returns true if the string is not null and not empty.
  bool get available => this != null && this!.isNotEmpty;
}

/// Extension on [String] for common transformations.
extension StringX on String {
  /// Capitalizes the first letter of the string.
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
