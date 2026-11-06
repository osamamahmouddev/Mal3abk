// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_toggle_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoriteToggleState {

 Map<String, bool> get overrides; String? get failure;
/// Create a copy of FavoriteToggleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteToggleStateCopyWith<FavoriteToggleState> get copyWith => _$FavoriteToggleStateCopyWithImpl<FavoriteToggleState>(this as FavoriteToggleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteToggleState&&const DeepCollectionEquality().equals(other.overrides, overrides)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(overrides),failure);

@override
String toString() {
  return 'FavoriteToggleState(overrides: $overrides, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $FavoriteToggleStateCopyWith<$Res>  {
  factory $FavoriteToggleStateCopyWith(FavoriteToggleState value, $Res Function(FavoriteToggleState) _then) = _$FavoriteToggleStateCopyWithImpl;
@useResult
$Res call({
 Map<String, bool> overrides, String? failure
});




}
/// @nodoc
class _$FavoriteToggleStateCopyWithImpl<$Res>
    implements $FavoriteToggleStateCopyWith<$Res> {
  _$FavoriteToggleStateCopyWithImpl(this._self, this._then);

  final FavoriteToggleState _self;
  final $Res Function(FavoriteToggleState) _then;

/// Create a copy of FavoriteToggleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? overrides = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
overrides: null == overrides ? _self.overrides : overrides // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteToggleState].
extension FavoriteToggleStatePatterns on FavoriteToggleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteToggleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteToggleState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteToggleState value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteToggleState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteToggleState value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteToggleState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, bool> overrides,  String? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteToggleState() when $default != null:
return $default(_that.overrides,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, bool> overrides,  String? failure)  $default,) {final _that = this;
switch (_that) {
case _FavoriteToggleState():
return $default(_that.overrides,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, bool> overrides,  String? failure)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteToggleState() when $default != null:
return $default(_that.overrides,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _FavoriteToggleState implements FavoriteToggleState {
  const _FavoriteToggleState({final  Map<String, bool> overrides = const <String, bool>{}, this.failure}): _overrides = overrides;
  

 final  Map<String, bool> _overrides;
@override@JsonKey() Map<String, bool> get overrides {
  if (_overrides is EqualUnmodifiableMapView) return _overrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_overrides);
}

@override final  String? failure;

/// Create a copy of FavoriteToggleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteToggleStateCopyWith<_FavoriteToggleState> get copyWith => __$FavoriteToggleStateCopyWithImpl<_FavoriteToggleState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteToggleState&&const DeepCollectionEquality().equals(other._overrides, _overrides)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_overrides),failure);

@override
String toString() {
  return 'FavoriteToggleState(overrides: $overrides, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FavoriteToggleStateCopyWith<$Res> implements $FavoriteToggleStateCopyWith<$Res> {
  factory _$FavoriteToggleStateCopyWith(_FavoriteToggleState value, $Res Function(_FavoriteToggleState) _then) = __$FavoriteToggleStateCopyWithImpl;
@override @useResult
$Res call({
 Map<String, bool> overrides, String? failure
});




}
/// @nodoc
class __$FavoriteToggleStateCopyWithImpl<$Res>
    implements _$FavoriteToggleStateCopyWith<$Res> {
  __$FavoriteToggleStateCopyWithImpl(this._self, this._then);

  final _FavoriteToggleState _self;
  final $Res Function(_FavoriteToggleState) _then;

/// Create a copy of FavoriteToggleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? overrides = null,Object? failure = freezed,}) {
  return _then(_FavoriteToggleState(
overrides: null == overrides ? _self._overrides : overrides // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
