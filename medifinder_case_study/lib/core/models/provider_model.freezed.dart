// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProviderModel {

 String get id; String get name; ProviderType get type; String get specialty; String get country; String get city; double get rating; int get reviewCount; String? get imageUrl; String? get phone; String? get email; String? get bio; String? get address; bool get isVerified; int get yearsOfExperience; List<String> get languages; List<String> get services;
/// Create a copy of ProviderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderModelCopyWith<ProviderModel> get copyWith => _$ProviderModelCopyWithImpl<ProviderModel>(this as ProviderModel, _$identity);

  /// Serializes this ProviderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.address, address) || other.address == address)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.yearsOfExperience, yearsOfExperience) || other.yearsOfExperience == yearsOfExperience)&&const DeepCollectionEquality().equals(other.languages, languages)&&const DeepCollectionEquality().equals(other.services, services));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,specialty,country,city,rating,reviewCount,imageUrl,phone,email,bio,address,isVerified,yearsOfExperience,const DeepCollectionEquality().hash(languages),const DeepCollectionEquality().hash(services));

@override
String toString() {
  return 'ProviderModel(id: $id, name: $name, type: $type, specialty: $specialty, country: $country, city: $city, rating: $rating, reviewCount: $reviewCount, imageUrl: $imageUrl, phone: $phone, email: $email, bio: $bio, address: $address, isVerified: $isVerified, yearsOfExperience: $yearsOfExperience, languages: $languages, services: $services)';
}


}

/// @nodoc
abstract mixin class $ProviderModelCopyWith<$Res>  {
  factory $ProviderModelCopyWith(ProviderModel value, $Res Function(ProviderModel) _then) = _$ProviderModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, ProviderType type, String specialty, String country, String city, double rating, int reviewCount, String? imageUrl, String? phone, String? email, String? bio, String? address, bool isVerified, int yearsOfExperience, List<String> languages, List<String> services
});




}
/// @nodoc
class _$ProviderModelCopyWithImpl<$Res>
    implements $ProviderModelCopyWith<$Res> {
  _$ProviderModelCopyWithImpl(this._self, this._then);

  final ProviderModel _self;
  final $Res Function(ProviderModel) _then;

/// Create a copy of ProviderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? specialty = null,Object? country = null,Object? city = null,Object? rating = null,Object? reviewCount = null,Object? imageUrl = freezed,Object? phone = freezed,Object? email = freezed,Object? bio = freezed,Object? address = freezed,Object? isVerified = null,Object? yearsOfExperience = null,Object? languages = null,Object? services = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ProviderType,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,yearsOfExperience: null == yearsOfExperience ? _self.yearsOfExperience : yearsOfExperience // ignore: cast_nullable_to_non_nullable
as int,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderModel].
extension ProviderModelPatterns on ProviderModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderModel value)  $default,){
final _that = this;
switch (_that) {
case _ProviderModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  ProviderType type,  String specialty,  String country,  String city,  double rating,  int reviewCount,  String? imageUrl,  String? phone,  String? email,  String? bio,  String? address,  bool isVerified,  int yearsOfExperience,  List<String> languages,  List<String> services)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.specialty,_that.country,_that.city,_that.rating,_that.reviewCount,_that.imageUrl,_that.phone,_that.email,_that.bio,_that.address,_that.isVerified,_that.yearsOfExperience,_that.languages,_that.services);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  ProviderType type,  String specialty,  String country,  String city,  double rating,  int reviewCount,  String? imageUrl,  String? phone,  String? email,  String? bio,  String? address,  bool isVerified,  int yearsOfExperience,  List<String> languages,  List<String> services)  $default,) {final _that = this;
switch (_that) {
case _ProviderModel():
return $default(_that.id,_that.name,_that.type,_that.specialty,_that.country,_that.city,_that.rating,_that.reviewCount,_that.imageUrl,_that.phone,_that.email,_that.bio,_that.address,_that.isVerified,_that.yearsOfExperience,_that.languages,_that.services);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  ProviderType type,  String specialty,  String country,  String city,  double rating,  int reviewCount,  String? imageUrl,  String? phone,  String? email,  String? bio,  String? address,  bool isVerified,  int yearsOfExperience,  List<String> languages,  List<String> services)?  $default,) {final _that = this;
switch (_that) {
case _ProviderModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.specialty,_that.country,_that.city,_that.rating,_that.reviewCount,_that.imageUrl,_that.phone,_that.email,_that.bio,_that.address,_that.isVerified,_that.yearsOfExperience,_that.languages,_that.services);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProviderModel implements ProviderModel {
  const _ProviderModel({required this.id, required this.name, required this.type, required this.specialty, required this.country, required this.city, required this.rating, required this.reviewCount, this.imageUrl, this.phone, this.email, this.bio, this.address, this.isVerified = false, this.yearsOfExperience = 0, final  List<String> languages = const [], final  List<String> services = const []}): _languages = languages,_services = services;
  factory _ProviderModel.fromJson(Map<String, dynamic> json) => _$ProviderModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  ProviderType type;
@override final  String specialty;
@override final  String country;
@override final  String city;
@override final  double rating;
@override final  int reviewCount;
@override final  String? imageUrl;
@override final  String? phone;
@override final  String? email;
@override final  String? bio;
@override final  String? address;
@override@JsonKey() final  bool isVerified;
@override@JsonKey() final  int yearsOfExperience;
 final  List<String> _languages;
@override@JsonKey() List<String> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

 final  List<String> _services;
@override@JsonKey() List<String> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}


/// Create a copy of ProviderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderModelCopyWith<_ProviderModel> get copyWith => __$ProviderModelCopyWithImpl<_ProviderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.address, address) || other.address == address)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.yearsOfExperience, yearsOfExperience) || other.yearsOfExperience == yearsOfExperience)&&const DeepCollectionEquality().equals(other._languages, _languages)&&const DeepCollectionEquality().equals(other._services, _services));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,specialty,country,city,rating,reviewCount,imageUrl,phone,email,bio,address,isVerified,yearsOfExperience,const DeepCollectionEquality().hash(_languages),const DeepCollectionEquality().hash(_services));

@override
String toString() {
  return 'ProviderModel(id: $id, name: $name, type: $type, specialty: $specialty, country: $country, city: $city, rating: $rating, reviewCount: $reviewCount, imageUrl: $imageUrl, phone: $phone, email: $email, bio: $bio, address: $address, isVerified: $isVerified, yearsOfExperience: $yearsOfExperience, languages: $languages, services: $services)';
}


}

/// @nodoc
abstract mixin class _$ProviderModelCopyWith<$Res> implements $ProviderModelCopyWith<$Res> {
  factory _$ProviderModelCopyWith(_ProviderModel value, $Res Function(_ProviderModel) _then) = __$ProviderModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, ProviderType type, String specialty, String country, String city, double rating, int reviewCount, String? imageUrl, String? phone, String? email, String? bio, String? address, bool isVerified, int yearsOfExperience, List<String> languages, List<String> services
});




}
/// @nodoc
class __$ProviderModelCopyWithImpl<$Res>
    implements _$ProviderModelCopyWith<$Res> {
  __$ProviderModelCopyWithImpl(this._self, this._then);

  final _ProviderModel _self;
  final $Res Function(_ProviderModel) _then;

/// Create a copy of ProviderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? specialty = null,Object? country = null,Object? city = null,Object? rating = null,Object? reviewCount = null,Object? imageUrl = freezed,Object? phone = freezed,Object? email = freezed,Object? bio = freezed,Object? address = freezed,Object? isVerified = null,Object? yearsOfExperience = null,Object? languages = null,Object? services = null,}) {
  return _then(_ProviderModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ProviderType,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,yearsOfExperience: null == yearsOfExperience ? _self.yearsOfExperience : yearsOfExperience // ignore: cast_nullable_to_non_nullable
as int,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,services: null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
