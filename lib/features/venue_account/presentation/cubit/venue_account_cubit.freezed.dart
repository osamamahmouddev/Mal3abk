// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_account_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueAccountState {

 VenueAccountProfile? get profile; bool get loading; bool get busy; String? get error;/// While enrolling two-factor sign-in: the secret and its link.
 String? get totpSecret; String? get totpUri;/// The phone change request in progress.
 String? get phoneRequestId;
/// Create a copy of VenueAccountState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueAccountStateCopyWith<VenueAccountState> get copyWith => _$VenueAccountStateCopyWithImpl<VenueAccountState>(this as VenueAccountState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueAccountState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.busy, busy) || other.busy == busy)&&(identical(other.error, error) || other.error == error)&&(identical(other.totpSecret, totpSecret) || other.totpSecret == totpSecret)&&(identical(other.totpUri, totpUri) || other.totpUri == totpUri)&&(identical(other.phoneRequestId, phoneRequestId) || other.phoneRequestId == phoneRequestId));
}


@override
int get hashCode => Object.hash(runtimeType,profile,loading,busy,error,totpSecret,totpUri,phoneRequestId);

@override
String toString() {
  return 'VenueAccountState(profile: $profile, loading: $loading, busy: $busy, error: $error, totpSecret: $totpSecret, totpUri: $totpUri, phoneRequestId: $phoneRequestId)';
}


}

/// @nodoc
abstract mixin class $VenueAccountStateCopyWith<$Res>  {
  factory $VenueAccountStateCopyWith(VenueAccountState value, $Res Function(VenueAccountState) _then) = _$VenueAccountStateCopyWithImpl;
@useResult
$Res call({
 VenueAccountProfile? profile, bool loading, bool busy, String? error, String? totpSecret, String? totpUri, String? phoneRequestId
});




}
/// @nodoc
class _$VenueAccountStateCopyWithImpl<$Res>
    implements $VenueAccountStateCopyWith<$Res> {
  _$VenueAccountStateCopyWithImpl(this._self, this._then);

  final VenueAccountState _self;
  final $Res Function(VenueAccountState) _then;

/// Create a copy of VenueAccountState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = freezed,Object? loading = null,Object? busy = null,Object? error = freezed,Object? totpSecret = freezed,Object? totpUri = freezed,Object? phoneRequestId = freezed,}) {
  return _then(_self.copyWith(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as VenueAccountProfile?,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,totpSecret: freezed == totpSecret ? _self.totpSecret : totpSecret // ignore: cast_nullable_to_non_nullable
as String?,totpUri: freezed == totpUri ? _self.totpUri : totpUri // ignore: cast_nullable_to_non_nullable
as String?,phoneRequestId: freezed == phoneRequestId ? _self.phoneRequestId : phoneRequestId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueAccountState].
extension VenueAccountStatePatterns on VenueAccountState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueAccountState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueAccountState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueAccountState value)  $default,){
final _that = this;
switch (_that) {
case _VenueAccountState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueAccountState value)?  $default,){
final _that = this;
switch (_that) {
case _VenueAccountState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VenueAccountProfile? profile,  bool loading,  bool busy,  String? error,  String? totpSecret,  String? totpUri,  String? phoneRequestId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueAccountState() when $default != null:
return $default(_that.profile,_that.loading,_that.busy,_that.error,_that.totpSecret,_that.totpUri,_that.phoneRequestId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VenueAccountProfile? profile,  bool loading,  bool busy,  String? error,  String? totpSecret,  String? totpUri,  String? phoneRequestId)  $default,) {final _that = this;
switch (_that) {
case _VenueAccountState():
return $default(_that.profile,_that.loading,_that.busy,_that.error,_that.totpSecret,_that.totpUri,_that.phoneRequestId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VenueAccountProfile? profile,  bool loading,  bool busy,  String? error,  String? totpSecret,  String? totpUri,  String? phoneRequestId)?  $default,) {final _that = this;
switch (_that) {
case _VenueAccountState() when $default != null:
return $default(_that.profile,_that.loading,_that.busy,_that.error,_that.totpSecret,_that.totpUri,_that.phoneRequestId);case _:
  return null;

}
}

}

/// @nodoc


class _VenueAccountState implements VenueAccountState {
  const _VenueAccountState({this.profile, this.loading = true, this.busy = false, this.error, this.totpSecret, this.totpUri, this.phoneRequestId});
  

@override final  VenueAccountProfile? profile;
@override@JsonKey() final  bool loading;
@override@JsonKey() final  bool busy;
@override final  String? error;
/// While enrolling two-factor sign-in: the secret and its link.
@override final  String? totpSecret;
@override final  String? totpUri;
/// The phone change request in progress.
@override final  String? phoneRequestId;

/// Create a copy of VenueAccountState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueAccountStateCopyWith<_VenueAccountState> get copyWith => __$VenueAccountStateCopyWithImpl<_VenueAccountState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueAccountState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.busy, busy) || other.busy == busy)&&(identical(other.error, error) || other.error == error)&&(identical(other.totpSecret, totpSecret) || other.totpSecret == totpSecret)&&(identical(other.totpUri, totpUri) || other.totpUri == totpUri)&&(identical(other.phoneRequestId, phoneRequestId) || other.phoneRequestId == phoneRequestId));
}


@override
int get hashCode => Object.hash(runtimeType,profile,loading,busy,error,totpSecret,totpUri,phoneRequestId);

@override
String toString() {
  return 'VenueAccountState(profile: $profile, loading: $loading, busy: $busy, error: $error, totpSecret: $totpSecret, totpUri: $totpUri, phoneRequestId: $phoneRequestId)';
}


}

/// @nodoc
abstract mixin class _$VenueAccountStateCopyWith<$Res> implements $VenueAccountStateCopyWith<$Res> {
  factory _$VenueAccountStateCopyWith(_VenueAccountState value, $Res Function(_VenueAccountState) _then) = __$VenueAccountStateCopyWithImpl;
@override @useResult
$Res call({
 VenueAccountProfile? profile, bool loading, bool busy, String? error, String? totpSecret, String? totpUri, String? phoneRequestId
});




}
/// @nodoc
class __$VenueAccountStateCopyWithImpl<$Res>
    implements _$VenueAccountStateCopyWith<$Res> {
  __$VenueAccountStateCopyWithImpl(this._self, this._then);

  final _VenueAccountState _self;
  final $Res Function(_VenueAccountState) _then;

/// Create a copy of VenueAccountState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = freezed,Object? loading = null,Object? busy = null,Object? error = freezed,Object? totpSecret = freezed,Object? totpUri = freezed,Object? phoneRequestId = freezed,}) {
  return _then(_VenueAccountState(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as VenueAccountProfile?,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,totpSecret: freezed == totpSecret ? _self.totpSecret : totpSecret // ignore: cast_nullable_to_non_nullable
as String?,totpUri: freezed == totpUri ? _self.totpUri : totpUri // ignore: cast_nullable_to_non_nullable
as String?,phoneRequestId: freezed == phoneRequestId ? _self.phoneRequestId : phoneRequestId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
