// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_staff_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueStaffState {

 VenueStaffModel get staff; bool get loading; bool get busy; String? get error;
/// Create a copy of VenueStaffState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueStaffStateCopyWith<VenueStaffState> get copyWith => _$VenueStaffStateCopyWithImpl<VenueStaffState>(this as VenueStaffState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueStaffState&&(identical(other.staff, staff) || other.staff == staff)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.busy, busy) || other.busy == busy)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,staff,loading,busy,error);

@override
String toString() {
  return 'VenueStaffState(staff: $staff, loading: $loading, busy: $busy, error: $error)';
}


}

/// @nodoc
abstract mixin class $VenueStaffStateCopyWith<$Res>  {
  factory $VenueStaffStateCopyWith(VenueStaffState value, $Res Function(VenueStaffState) _then) = _$VenueStaffStateCopyWithImpl;
@useResult
$Res call({
 VenueStaffModel staff, bool loading, bool busy, String? error
});




}
/// @nodoc
class _$VenueStaffStateCopyWithImpl<$Res>
    implements $VenueStaffStateCopyWith<$Res> {
  _$VenueStaffStateCopyWithImpl(this._self, this._then);

  final VenueStaffState _self;
  final $Res Function(VenueStaffState) _then;

/// Create a copy of VenueStaffState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? staff = null,Object? loading = null,Object? busy = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
staff: null == staff ? _self.staff : staff // ignore: cast_nullable_to_non_nullable
as VenueStaffModel,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueStaffState].
extension VenueStaffStatePatterns on VenueStaffState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueStaffState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueStaffState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueStaffState value)  $default,){
final _that = this;
switch (_that) {
case _VenueStaffState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueStaffState value)?  $default,){
final _that = this;
switch (_that) {
case _VenueStaffState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VenueStaffModel staff,  bool loading,  bool busy,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueStaffState() when $default != null:
return $default(_that.staff,_that.loading,_that.busy,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VenueStaffModel staff,  bool loading,  bool busy,  String? error)  $default,) {final _that = this;
switch (_that) {
case _VenueStaffState():
return $default(_that.staff,_that.loading,_that.busy,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VenueStaffModel staff,  bool loading,  bool busy,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _VenueStaffState() when $default != null:
return $default(_that.staff,_that.loading,_that.busy,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _VenueStaffState implements VenueStaffState {
  const _VenueStaffState({this.staff = const VenueStaffModel(), this.loading = true, this.busy = false, this.error});
  

@override@JsonKey() final  VenueStaffModel staff;
@override@JsonKey() final  bool loading;
@override@JsonKey() final  bool busy;
@override final  String? error;

/// Create a copy of VenueStaffState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueStaffStateCopyWith<_VenueStaffState> get copyWith => __$VenueStaffStateCopyWithImpl<_VenueStaffState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueStaffState&&(identical(other.staff, staff) || other.staff == staff)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.busy, busy) || other.busy == busy)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,staff,loading,busy,error);

@override
String toString() {
  return 'VenueStaffState(staff: $staff, loading: $loading, busy: $busy, error: $error)';
}


}

/// @nodoc
abstract mixin class _$VenueStaffStateCopyWith<$Res> implements $VenueStaffStateCopyWith<$Res> {
  factory _$VenueStaffStateCopyWith(_VenueStaffState value, $Res Function(_VenueStaffState) _then) = __$VenueStaffStateCopyWithImpl;
@override @useResult
$Res call({
 VenueStaffModel staff, bool loading, bool busy, String? error
});




}
/// @nodoc
class __$VenueStaffStateCopyWithImpl<$Res>
    implements _$VenueStaffStateCopyWith<$Res> {
  __$VenueStaffStateCopyWithImpl(this._self, this._then);

  final _VenueStaffState _self;
  final $Res Function(_VenueStaffState) _then;

/// Create a copy of VenueStaffState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? staff = null,Object? loading = null,Object? busy = null,Object? error = freezed,}) {
  return _then(_VenueStaffState(
staff: null == staff ? _self.staff : staff // ignore: cast_nullable_to_non_nullable
as VenueStaffModel,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
