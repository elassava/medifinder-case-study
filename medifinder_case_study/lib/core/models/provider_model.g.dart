// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProviderModel _$ProviderModelFromJson(
  Map<String, dynamic> json,
) => _ProviderModel(
  id: json['id'] as String,
  name: json['name'] as String,
  type: $enumDecode(_$ProviderTypeEnumMap, json['type']),
  specialty: json['specialty'] as String,
  country: json['country'] as String,
  city: json['city'] as String,
  rating: (json['rating'] as num).toDouble(),
  reviewCount: (json['reviewCount'] as num).toInt(),
  imageUrl: json['imageUrl'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  bio: json['bio'] as String?,
  address: json['address'] as String?,
  isVerified: json['isVerified'] as bool? ?? false,
  yearsOfExperience: (json['yearsOfExperience'] as num?)?.toInt() ?? 0,
  languages:
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  services:
      (json['services'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$ProviderModelToJson(_ProviderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$ProviderTypeEnumMap[instance.type]!,
      'specialty': instance.specialty,
      'country': instance.country,
      'city': instance.city,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'imageUrl': instance.imageUrl,
      'phone': instance.phone,
      'email': instance.email,
      'bio': instance.bio,
      'address': instance.address,
      'isVerified': instance.isVerified,
      'yearsOfExperience': instance.yearsOfExperience,
      'languages': instance.languages,
      'services': instance.services,
    };

const _$ProviderTypeEnumMap = {
  ProviderType.doctor: 'doctor',
  ProviderType.clinic: 'clinic',
  ProviderType.hospital: 'hospital',
};
