// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_policies_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenuePoliciesState {

 BookingPolicyModel get policy; bool get loading; bool get saving; bool get dirty; String? get error;
/// Create a copy of VenuePoliciesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenuePoliciesStateCopyWith<VenuePoliciesState> get copyWith => _$VenuePoliciesStateCopyWithImpl<VenuePoliciesState>(this as VenuePoliciesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenuePoliciesState&&(identical(other.policy, policy) || other.policy == policy)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.dirty, dirty) || other.dirty == dirty)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,policy,loading,saving,dirty,error);

@override
String toString() {
  return 'VenuePoliciesState(policy: $policy, loading: $loading, saving: $saving, dirty: $dirty, error: $error)';
}


}

/// @nodoc
abstract mixin class $VenuePoliciesStateCopyWith<$Res>  {
  factory $VenuePoliciesStateCopyWith(VenuePoliciesState value, $Res Function(VenuePoliciesState) _then) = _$VenuePoliciesStateCopyWithImpl;
@useResult
$Res call({
 BookingPolicyModel policy, bool loading, bool saving, bool dirty, String? error
});




}
/// @nodoc
class _$VenuePoliciesStateCopyWithImpl<$Res>
    implements $VenuePoliciesStateCopyWith<$Res> {
  _$VenuePoliciesStateCopyWithImpl(this._self, this._then);

  final VenuePoliciesState _self;
  final $Res Function(VenuePoliciesState) _then;

/// Create a copy of VenuePoliciesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? policy = null,Object? loading = null,Object? saving = null,Object? dirty = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
policy: null == policy ? _self.policy : policy // ignore: cast_nullable_to_non_nullable
as BookingPolicyModel,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,dirty: null == dirty ? _self.dirty : dirty // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VenuePoliciesState].
extension VenuePoliciesStatePatterns on VenuePoliciesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenuePoliciesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenuePoliciesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenuePoliciesState value)  $default,){
final _that = this;
switch (_that) {
case _VenuePoliciesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenuePoliciesState value)?  $default,){
final _that = this;
switch (_that) {
case _VenuePoliciesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BookingPolicyModel policy,  bool loading,  bool saving,  bool dirty,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenuePoliciesState() when $default != null:
return $default(_that.policy,_that.loading,_that.saving,_that.dirty,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BookingPolicyModel policy,  bool loading,  bool saving,  bool dirty,  String? error)  $default,) {final _that = this;
switch (_that) {
case _VenuePoliciesState():
return $default(_that.policy,_that.loading,_that.saving,_that.dirty,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BookingPolicyModel policy,  bool loading,  bool saving,  bool dirty,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _VenuePoliciesState() when $default != null:
return $default(_that.policy,_that.loading,_that.saving,_that.dirty,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _VenuePoliciesState implements VenuePoliciesState {
  const _VenuePoliciesState({this.policy = const BookingPolicyModel(BookingPolicyModel.defaults), this.loading = true, this.saving = false, this.dirty = false, this.error});
  

@override@JsonKey() final  BookingPolicyModel policy;
@override@JsonKey() final  bool loading;
@override@JsonKey() final  bool saving;
@override@JsonKey() final  bool dirty;
@override final  String? error;

/// Create a copy of VenuePoliciesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenuePoliciesStateCopyWith<_VenuePoliciesState> get copyWith => __$VenuePoliciesStateCopyWithImpl<_VenuePoliciesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenuePoliciesState&&(identical(other.policy, policy) || other.policy == policy)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.dirty, dirty) || other.dirty == dirty)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,policy,loading,saving,dirty,error);

@override
String toString() {
  return 'VenuePoliciesState(policy: $policy, loading: $loading, saving: $saving, dirty: $dirty, error: $error)';
}


}

/// @nodoc
abstract mixin class _$VenuePoliciesStateCopyWith<$Res> implements $VenuePoliciesStateCopyWith<$Res> {
  factory _$VenuePoliciesStateCopyWith(_VenuePoliciesState value, $Res Function(_VenuePoliciesState) _then) = __$VenuePoliciesStateCopyWithImpl;
@override @useResult
$Res call({
 BookingPolicyModel policy, bool loading, bool saving, bool dirty, String? error
});




}
/// @nodoc
class __$VenuePoliciesStateCopyWithImpl<$Res>
    implements _$VenuePoliciesStateCopyWith<$Res> {
  __$VenuePoliciesStateCopyWithImpl(this._self, this._then);

  final _VenuePoliciesState _self;
  final $Res Function(_VenuePoliciesState) _then;

/// Create a copy of VenuePoliciesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? policy = null,Object? loading = null,Object? saving = null,Object? dirty = null,Object? error = freezed,}) {
  return _then(_VenuePoliciesState(
policy: null == policy ? _self.policy : policy // ignore: cast_nullable_to_non_nullable
as BookingPolicyModel,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,dirty: null == dirty ? _self.dirty : dirty // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
