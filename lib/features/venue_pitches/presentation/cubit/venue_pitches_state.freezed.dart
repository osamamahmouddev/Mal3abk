// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_pitches_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenuePitchesState {

 List<VenuePitchModel> get pitches; List<LocalizedItemModel> get surfaces; bool get loading; String? get error;/// The pitch (or `new`, or a venue id) an action is running for.
 String? get busyId; bool get uploading;
/// Create a copy of VenuePitchesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenuePitchesStateCopyWith<VenuePitchesState> get copyWith => _$VenuePitchesStateCopyWithImpl<VenuePitchesState>(this as VenuePitchesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenuePitchesState&&const DeepCollectionEquality().equals(other.pitches, pitches)&&const DeepCollectionEquality().equals(other.surfaces, surfaces)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.error, error) || other.error == error)&&(identical(other.busyId, busyId) || other.busyId == busyId)&&(identical(other.uploading, uploading) || other.uploading == uploading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(pitches),const DeepCollectionEquality().hash(surfaces),loading,error,busyId,uploading);

@override
String toString() {
  return 'VenuePitchesState(pitches: $pitches, surfaces: $surfaces, loading: $loading, error: $error, busyId: $busyId, uploading: $uploading)';
}


}

/// @nodoc
abstract mixin class $VenuePitchesStateCopyWith<$Res>  {
  factory $VenuePitchesStateCopyWith(VenuePitchesState value, $Res Function(VenuePitchesState) _then) = _$VenuePitchesStateCopyWithImpl;
@useResult
$Res call({
 List<VenuePitchModel> pitches, List<LocalizedItemModel> surfaces, bool loading, String? error, String? busyId, bool uploading
});




}
/// @nodoc
class _$VenuePitchesStateCopyWithImpl<$Res>
    implements $VenuePitchesStateCopyWith<$Res> {
  _$VenuePitchesStateCopyWithImpl(this._self, this._then);

  final VenuePitchesState _self;
  final $Res Function(VenuePitchesState) _then;

/// Create a copy of VenuePitchesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pitches = null,Object? surfaces = null,Object? loading = null,Object? error = freezed,Object? busyId = freezed,Object? uploading = null,}) {
  return _then(_self.copyWith(
pitches: null == pitches ? _self.pitches : pitches // ignore: cast_nullable_to_non_nullable
as List<VenuePitchModel>,surfaces: null == surfaces ? _self.surfaces : surfaces // ignore: cast_nullable_to_non_nullable
as List<LocalizedItemModel>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,busyId: freezed == busyId ? _self.busyId : busyId // ignore: cast_nullable_to_non_nullable
as String?,uploading: null == uploading ? _self.uploading : uploading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VenuePitchesState].
extension VenuePitchesStatePatterns on VenuePitchesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenuePitchesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenuePitchesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenuePitchesState value)  $default,){
final _that = this;
switch (_that) {
case _VenuePitchesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenuePitchesState value)?  $default,){
final _that = this;
switch (_that) {
case _VenuePitchesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VenuePitchModel> pitches,  List<LocalizedItemModel> surfaces,  bool loading,  String? error,  String? busyId,  bool uploading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenuePitchesState() when $default != null:
return $default(_that.pitches,_that.surfaces,_that.loading,_that.error,_that.busyId,_that.uploading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VenuePitchModel> pitches,  List<LocalizedItemModel> surfaces,  bool loading,  String? error,  String? busyId,  bool uploading)  $default,) {final _that = this;
switch (_that) {
case _VenuePitchesState():
return $default(_that.pitches,_that.surfaces,_that.loading,_that.error,_that.busyId,_that.uploading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VenuePitchModel> pitches,  List<LocalizedItemModel> surfaces,  bool loading,  String? error,  String? busyId,  bool uploading)?  $default,) {final _that = this;
switch (_that) {
case _VenuePitchesState() when $default != null:
return $default(_that.pitches,_that.surfaces,_that.loading,_that.error,_that.busyId,_that.uploading);case _:
  return null;

}
}

}

/// @nodoc


class _VenuePitchesState implements VenuePitchesState {
  const _VenuePitchesState({final  List<VenuePitchModel> pitches = const [], final  List<LocalizedItemModel> surfaces = const [], this.loading = true, this.error, this.busyId, this.uploading = false}): _pitches = pitches,_surfaces = surfaces;
  

 final  List<VenuePitchModel> _pitches;
@override@JsonKey() List<VenuePitchModel> get pitches {
  if (_pitches is EqualUnmodifiableListView) return _pitches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pitches);
}

 final  List<LocalizedItemModel> _surfaces;
@override@JsonKey() List<LocalizedItemModel> get surfaces {
  if (_surfaces is EqualUnmodifiableListView) return _surfaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_surfaces);
}

@override@JsonKey() final  bool loading;
@override final  String? error;
/// The pitch (or `new`, or a venue id) an action is running for.
@override final  String? busyId;
@override@JsonKey() final  bool uploading;

/// Create a copy of VenuePitchesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenuePitchesStateCopyWith<_VenuePitchesState> get copyWith => __$VenuePitchesStateCopyWithImpl<_VenuePitchesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenuePitchesState&&const DeepCollectionEquality().equals(other._pitches, _pitches)&&const DeepCollectionEquality().equals(other._surfaces, _surfaces)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.error, error) || other.error == error)&&(identical(other.busyId, busyId) || other.busyId == busyId)&&(identical(other.uploading, uploading) || other.uploading == uploading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_pitches),const DeepCollectionEquality().hash(_surfaces),loading,error,busyId,uploading);

@override
String toString() {
  return 'VenuePitchesState(pitches: $pitches, surfaces: $surfaces, loading: $loading, error: $error, busyId: $busyId, uploading: $uploading)';
}


}

/// @nodoc
abstract mixin class _$VenuePitchesStateCopyWith<$Res> implements $VenuePitchesStateCopyWith<$Res> {
  factory _$VenuePitchesStateCopyWith(_VenuePitchesState value, $Res Function(_VenuePitchesState) _then) = __$VenuePitchesStateCopyWithImpl;
@override @useResult
$Res call({
 List<VenuePitchModel> pitches, List<LocalizedItemModel> surfaces, bool loading, String? error, String? busyId, bool uploading
});




}
/// @nodoc
class __$VenuePitchesStateCopyWithImpl<$Res>
    implements _$VenuePitchesStateCopyWith<$Res> {
  __$VenuePitchesStateCopyWithImpl(this._self, this._then);

  final _VenuePitchesState _self;
  final $Res Function(_VenuePitchesState) _then;

/// Create a copy of VenuePitchesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pitches = null,Object? surfaces = null,Object? loading = null,Object? error = freezed,Object? busyId = freezed,Object? uploading = null,}) {
  return _then(_VenuePitchesState(
pitches: null == pitches ? _self._pitches : pitches // ignore: cast_nullable_to_non_nullable
as List<VenuePitchModel>,surfaces: null == surfaces ? _self._surfaces : surfaces // ignore: cast_nullable_to_non_nullable
as List<LocalizedItemModel>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,busyId: freezed == busyId ? _self.busyId : busyId // ignore: cast_nullable_to_non_nullable
as String?,uploading: null == uploading ? _self.uploading : uploading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
