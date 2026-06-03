import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider_model.freezed.dart';
part 'provider_model.g.dart';

/// Type of healthcare provider.
enum ProviderType {
  @JsonValue('doctor')
  doctor,
  @JsonValue('clinic')
  clinic,
  @JsonValue('hospital')
  hospital,
}

/// Bool extension getters for [ProviderType].
extension ProviderTypeX on ProviderType {
  bool get isDoctor => this == ProviderType.doctor;
  bool get isClinic => this == ProviderType.clinic;
  bool get isHospital => this == ProviderType.hospital;

  /// Returns a human-readable label for display.
  /// Use localized strings in the UI layer instead when possible.
  String get label => switch (this) {
        ProviderType.doctor => 'Doctor',
        ProviderType.clinic => 'Clinic',
        ProviderType.hospital => 'Hospital',
      };
}

/// Represents a healthcare provider (doctor, clinic, or hospital).
@freezed
abstract class ProviderModel with _$ProviderModel {
  const factory ProviderModel({
    required String id,
    required String name,
    required ProviderType type,
    required String specialty,
    required String country,
    required String city,
    required double rating,
    required int reviewCount,
    String? imageUrl,
    String? phone,
    String? email,
    String? bio,
    String? address,
    @Default(false) bool isVerified,
    @Default(0) int yearsOfExperience,
    @Default([]) List<String> languages,
    @Default([]) List<String> services,
  }) = _ProviderModel;

  factory ProviderModel.fromJson(Map<String, dynamic> json) =>
      _$ProviderModelFromJson(json);
}
