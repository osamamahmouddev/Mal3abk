// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_reports_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueReportsState {

 ReportPreset get preset; DateTime get customFrom; DateTime get customTo; String? get pitchId; VenueReportModel? get report; bool get loading; bool get exporting; String? get error;
/// Create a copy of VenueReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueReportsStateCopyWith<VenueReportsState> get copyWith => _$VenueReportsStateCopyWithImpl<VenueReportsState>(this as VenueReportsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueReportsState&&(identical(other.preset, preset) || other.preset == preset)&&(identical(other.customFrom, customFrom) || other.customFrom == customFrom)&&(identical(other.customTo, customTo) || other.customTo == customTo)&&(identical(other.pitchId, pitchId) || other.pitchId == pitchId)&&(identical(other.report, report) || other.report == report)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.exporting, exporting) || other.exporting == exporting)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,preset,customFrom,customTo,pitchId,report,loading,exporting,error);

@override
String toString() {
  return 'VenueReportsState(preset: $preset, customFrom: $customFrom, customTo: $customTo, pitchId: $pitchId, report: $report, loading: $loading, exporting: $exporting, error: $error)';
}


}

/// @nodoc
abstract mixin class $VenueReportsStateCopyWith<$Res>  {
  factory $VenueReportsStateCopyWith(VenueReportsState value, $Res Function(VenueReportsState) _then) = _$VenueReportsStateCopyWithImpl;
@useResult
$Res call({
 ReportPreset preset, DateTime customFrom, DateTime customTo, String? pitchId, VenueReportModel? report, bool loading, bool exporting, String? error
});




}
/// @nodoc
class _$VenueReportsStateCopyWithImpl<$Res>
    implements $VenueReportsStateCopyWith<$Res> {
  _$VenueReportsStateCopyWithImpl(this._self, this._then);

  final VenueReportsState _self;
  final $Res Function(VenueReportsState) _then;

/// Create a copy of VenueReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? preset = null,Object? customFrom = null,Object? customTo = null,Object? pitchId = freezed,Object? report = freezed,Object? loading = null,Object? exporting = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
preset: null == preset ? _self.preset : preset // ignore: cast_nullable_to_non_nullable
as ReportPreset,customFrom: null == customFrom ? _self.customFrom : customFrom // ignore: cast_nullable_to_non_nullable
as DateTime,customTo: null == customTo ? _self.customTo : customTo // ignore: cast_nullable_to_non_nullable
as DateTime,pitchId: freezed == pitchId ? _self.pitchId : pitchId // ignore: cast_nullable_to_non_nullable
as String?,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as VenueReportModel?,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,exporting: null == exporting ? _self.exporting : exporting // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueReportsState].
extension VenueReportsStatePatterns on VenueReportsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueReportsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueReportsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueReportsState value)  $default,){
final _that = this;
switch (_that) {
case _VenueReportsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueReportsState value)?  $default,){
final _that = this;
switch (_that) {
case _VenueReportsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReportPreset preset,  DateTime customFrom,  DateTime customTo,  String? pitchId,  VenueReportModel? report,  bool loading,  bool exporting,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueReportsState() when $default != null:
return $default(_that.preset,_that.customFrom,_that.customTo,_that.pitchId,_that.report,_that.loading,_that.exporting,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReportPreset preset,  DateTime customFrom,  DateTime customTo,  String? pitchId,  VenueReportModel? report,  bool loading,  bool exporting,  String? error)  $default,) {final _that = this;
switch (_that) {
case _VenueReportsState():
return $default(_that.preset,_that.customFrom,_that.customTo,_that.pitchId,_that.report,_that.loading,_that.exporting,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReportPreset preset,  DateTime customFrom,  DateTime customTo,  String? pitchId,  VenueReportModel? report,  bool loading,  bool exporting,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _VenueReportsState() when $default != null:
return $default(_that.preset,_that.customFrom,_that.customTo,_that.pitchId,_that.report,_that.loading,_that.exporting,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _VenueReportsState implements VenueReportsState {
  const _VenueReportsState({this.preset = ReportPreset.week, required this.customFrom, required this.customTo, this.pitchId, this.report, this.loading = true, this.exporting = false, this.error});
  

@override@JsonKey() final  ReportPreset preset;
@override final  DateTime customFrom;
@override final  DateTime customTo;
@override final  String? pitchId;
@override final  VenueReportModel? report;
@override@JsonKey() final  bool loading;
@override@JsonKey() final  bool exporting;
@override final  String? error;

/// Create a copy of VenueReportsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueReportsStateCopyWith<_VenueReportsState> get copyWith => __$VenueReportsStateCopyWithImpl<_VenueReportsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueReportsState&&(identical(other.preset, preset) || other.preset == preset)&&(identical(other.customFrom, customFrom) || other.customFrom == customFrom)&&(identical(other.customTo, customTo) || other.customTo == customTo)&&(identical(other.pitchId, pitchId) || other.pitchId == pitchId)&&(identical(other.report, report) || other.report == report)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.exporting, exporting) || other.exporting == exporting)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,preset,customFrom,customTo,pitchId,report,loading,exporting,error);

@override
String toString() {
  return 'VenueReportsState(preset: $preset, customFrom: $customFrom, customTo: $customTo, pitchId: $pitchId, report: $report, loading: $loading, exporting: $exporting, error: $error)';
}


}

/// @nodoc
abstract mixin class _$VenueReportsStateCopyWith<$Res> implements $VenueReportsStateCopyWith<$Res> {
  factory _$VenueReportsStateCopyWith(_VenueReportsState value, $Res Function(_VenueReportsState) _then) = __$VenueReportsStateCopyWithImpl;
@override @useResult
$Res call({
 ReportPreset preset, DateTime customFrom, DateTime customTo, String? pitchId, VenueReportModel? report, bool loading, bool exporting, String? error
});




}
/// @nodoc
class __$VenueReportsStateCopyWithImpl<$Res>
    implements _$VenueReportsStateCopyWith<$Res> {
  __$VenueReportsStateCopyWithImpl(this._self, this._then);

  final _VenueReportsState _self;
  final $Res Function(_VenueReportsState) _then;

/// Create a copy of VenueReportsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? preset = null,Object? customFrom = null,Object? customTo = null,Object? pitchId = freezed,Object? report = freezed,Object? loading = null,Object? exporting = null,Object? error = freezed,}) {
  return _then(_VenueReportsState(
preset: null == preset ? _self.preset : preset // ignore: cast_nullable_to_non_nullable
as ReportPreset,customFrom: null == customFrom ? _self.customFrom : customFrom // ignore: cast_nullable_to_non_nullable
as DateTime,customTo: null == customTo ? _self.customTo : customTo // ignore: cast_nullable_to_non_nullable
as DateTime,pitchId: freezed == pitchId ? _self.pitchId : pitchId // ignore: cast_nullable_to_non_nullable
as String?,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as VenueReportModel?,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,exporting: null == exporting ? _self.exporting : exporting // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
