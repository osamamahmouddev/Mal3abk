// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_schedule_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueScheduleState {

/// Null: the venue's own hours; otherwise that pitch's.
 String? get pitchId; Map<int, DayHours> get week; SpecialSchedulesModel get special; bool get loading; bool get saving; String? get error;
/// Create a copy of VenueScheduleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueScheduleStateCopyWith<VenueScheduleState> get copyWith => _$VenueScheduleStateCopyWithImpl<VenueScheduleState>(this as VenueScheduleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueScheduleState&&(identical(other.pitchId, pitchId) || other.pitchId == pitchId)&&const DeepCollectionEquality().equals(other.week, week)&&(identical(other.special, special) || other.special == special)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,pitchId,const DeepCollectionEquality().hash(week),special,loading,saving,error);

@override
String toString() {
  return 'VenueScheduleState(pitchId: $pitchId, week: $week, special: $special, loading: $loading, saving: $saving, error: $error)';
}


}

/// @nodoc
abstract mixin class $VenueScheduleStateCopyWith<$Res>  {
  factory $VenueScheduleStateCopyWith(VenueScheduleState value, $Res Function(VenueScheduleState) _then) = _$VenueScheduleStateCopyWithImpl;
@useResult
$Res call({
 String? pitchId, Map<int, DayHours> week, SpecialSchedulesModel special, bool loading, bool saving, String? error
});




}
/// @nodoc
class _$VenueScheduleStateCopyWithImpl<$Res>
    implements $VenueScheduleStateCopyWith<$Res> {
  _$VenueScheduleStateCopyWithImpl(this._self, this._then);

  final VenueScheduleState _self;
  final $Res Function(VenueScheduleState) _then;

/// Create a copy of VenueScheduleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pitchId = freezed,Object? week = null,Object? special = null,Object? loading = null,Object? saving = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
pitchId: freezed == pitchId ? _self.pitchId : pitchId // ignore: cast_nullable_to_non_nullable
as String?,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as Map<int, DayHours>,special: null == special ? _self.special : special // ignore: cast_nullable_to_non_nullable
as SpecialSchedulesModel,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueScheduleState].
extension VenueScheduleStatePatterns on VenueScheduleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueScheduleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueScheduleState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueScheduleState value)  $default,){
final _that = this;
switch (_that) {
case _VenueScheduleState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueScheduleState value)?  $default,){
final _that = this;
switch (_that) {
case _VenueScheduleState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? pitchId,  Map<int, DayHours> week,  SpecialSchedulesModel special,  bool loading,  bool saving,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueScheduleState() when $default != null:
return $default(_that.pitchId,_that.week,_that.special,_that.loading,_that.saving,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? pitchId,  Map<int, DayHours> week,  SpecialSchedulesModel special,  bool loading,  bool saving,  String? error)  $default,) {final _that = this;
switch (_that) {
case _VenueScheduleState():
return $default(_that.pitchId,_that.week,_that.special,_that.loading,_that.saving,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? pitchId,  Map<int, DayHours> week,  SpecialSchedulesModel special,  bool loading,  bool saving,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _VenueScheduleState() when $default != null:
return $default(_that.pitchId,_that.week,_that.special,_that.loading,_that.saving,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _VenueScheduleState implements VenueScheduleState {
  const _VenueScheduleState({this.pitchId, required final  Map<int, DayHours> week, this.special = const SpecialSchedulesModel(), this.loading = true, this.saving = false, this.error}): _week = week;
  

/// Null: the venue's own hours; otherwise that pitch's.
@override final  String? pitchId;
 final  Map<int, DayHours> _week;
@override Map<int, DayHours> get week {
  if (_week is EqualUnmodifiableMapView) return _week;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_week);
}

@override@JsonKey() final  SpecialSchedulesModel special;
@override@JsonKey() final  bool loading;
@override@JsonKey() final  bool saving;
@override final  String? error;

/// Create a copy of VenueScheduleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueScheduleStateCopyWith<_VenueScheduleState> get copyWith => __$VenueScheduleStateCopyWithImpl<_VenueScheduleState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueScheduleState&&(identical(other.pitchId, pitchId) || other.pitchId == pitchId)&&const DeepCollectionEquality().equals(other._week, _week)&&(identical(other.special, special) || other.special == special)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,pitchId,const DeepCollectionEquality().hash(_week),special,loading,saving,error);

@override
String toString() {
  return 'VenueScheduleState(pitchId: $pitchId, week: $week, special: $special, loading: $loading, saving: $saving, error: $error)';
}


}

/// @nodoc
abstract mixin class _$VenueScheduleStateCopyWith<$Res> implements $VenueScheduleStateCopyWith<$Res> {
  factory _$VenueScheduleStateCopyWith(_VenueScheduleState value, $Res Function(_VenueScheduleState) _then) = __$VenueScheduleStateCopyWithImpl;
@override @useResult
$Res call({
 String? pitchId, Map<int, DayHours> week, SpecialSchedulesModel special, bool loading, bool saving, String? error
});




}
/// @nodoc
class __$VenueScheduleStateCopyWithImpl<$Res>
    implements _$VenueScheduleStateCopyWith<$Res> {
  __$VenueScheduleStateCopyWithImpl(this._self, this._then);

  final _VenueScheduleState _self;
  final $Res Function(_VenueScheduleState) _then;

/// Create a copy of VenueScheduleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pitchId = freezed,Object? week = null,Object? special = null,Object? loading = null,Object? saving = null,Object? error = freezed,}) {
  return _then(_VenueScheduleState(
pitchId: freezed == pitchId ? _self.pitchId : pitchId // ignore: cast_nullable_to_non_nullable
as String?,week: null == week ? _self._week : week // ignore: cast_nullable_to_non_nullable
as Map<int, DayHours>,special: null == special ? _self.special : special // ignore: cast_nullable_to_non_nullable
as SpecialSchedulesModel,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
