// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_setup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueSetupState {

/// 1 place, 2 pitches, 3 hours, 4 review.
 int get step;/// Null until the first save creates it.
 VenueModel? get venue; VenueApprovalModel? get approval; List<GovernorateModel> get governorates; List<LocalizedItemModel> get facilities; List<LocalizedItemModel> get surfaces; List<VenuePitchModel> get pitches; Map<int, DayHours> get week;/// Photos uploaded before the venue exists, and while adding a pitch.
 List<String> get pendingVenuePhotos; List<String> get draftPitchPhotos; bool get saving; bool get uploading; String? get error;
/// Create a copy of VenueSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueSetupStateCopyWith<VenueSetupState> get copyWith => _$VenueSetupStateCopyWithImpl<VenueSetupState>(this as VenueSetupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueSetupState&&(identical(other.step, step) || other.step == step)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.approval, approval) || other.approval == approval)&&const DeepCollectionEquality().equals(other.governorates, governorates)&&const DeepCollectionEquality().equals(other.facilities, facilities)&&const DeepCollectionEquality().equals(other.surfaces, surfaces)&&const DeepCollectionEquality().equals(other.pitches, pitches)&&const DeepCollectionEquality().equals(other.week, week)&&const DeepCollectionEquality().equals(other.pendingVenuePhotos, pendingVenuePhotos)&&const DeepCollectionEquality().equals(other.draftPitchPhotos, draftPitchPhotos)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.uploading, uploading) || other.uploading == uploading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,step,venue,approval,const DeepCollectionEquality().hash(governorates),const DeepCollectionEquality().hash(facilities),const DeepCollectionEquality().hash(surfaces),const DeepCollectionEquality().hash(pitches),const DeepCollectionEquality().hash(week),const DeepCollectionEquality().hash(pendingVenuePhotos),const DeepCollectionEquality().hash(draftPitchPhotos),saving,uploading,error);

@override
String toString() {
  return 'VenueSetupState(step: $step, venue: $venue, approval: $approval, governorates: $governorates, facilities: $facilities, surfaces: $surfaces, pitches: $pitches, week: $week, pendingVenuePhotos: $pendingVenuePhotos, draftPitchPhotos: $draftPitchPhotos, saving: $saving, uploading: $uploading, error: $error)';
}


}

/// @nodoc
abstract mixin class $VenueSetupStateCopyWith<$Res>  {
  factory $VenueSetupStateCopyWith(VenueSetupState value, $Res Function(VenueSetupState) _then) = _$VenueSetupStateCopyWithImpl;
@useResult
$Res call({
 int step, VenueModel? venue, VenueApprovalModel? approval, List<GovernorateModel> governorates, List<LocalizedItemModel> facilities, List<LocalizedItemModel> surfaces, List<VenuePitchModel> pitches, Map<int, DayHours> week, List<String> pendingVenuePhotos, List<String> draftPitchPhotos, bool saving, bool uploading, String? error
});




}
/// @nodoc
class _$VenueSetupStateCopyWithImpl<$Res>
    implements $VenueSetupStateCopyWith<$Res> {
  _$VenueSetupStateCopyWithImpl(this._self, this._then);

  final VenueSetupState _self;
  final $Res Function(VenueSetupState) _then;

/// Create a copy of VenueSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? venue = freezed,Object? approval = freezed,Object? governorates = null,Object? facilities = null,Object? surfaces = null,Object? pitches = null,Object? week = null,Object? pendingVenuePhotos = null,Object? draftPitchPhotos = null,Object? saving = null,Object? uploading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as VenueModel?,approval: freezed == approval ? _self.approval : approval // ignore: cast_nullable_to_non_nullable
as VenueApprovalModel?,governorates: null == governorates ? _self.governorates : governorates // ignore: cast_nullable_to_non_nullable
as List<GovernorateModel>,facilities: null == facilities ? _self.facilities : facilities // ignore: cast_nullable_to_non_nullable
as List<LocalizedItemModel>,surfaces: null == surfaces ? _self.surfaces : surfaces // ignore: cast_nullable_to_non_nullable
as List<LocalizedItemModel>,pitches: null == pitches ? _self.pitches : pitches // ignore: cast_nullable_to_non_nullable
as List<VenuePitchModel>,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as Map<int, DayHours>,pendingVenuePhotos: null == pendingVenuePhotos ? _self.pendingVenuePhotos : pendingVenuePhotos // ignore: cast_nullable_to_non_nullable
as List<String>,draftPitchPhotos: null == draftPitchPhotos ? _self.draftPitchPhotos : draftPitchPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,uploading: null == uploading ? _self.uploading : uploading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueSetupState].
extension VenueSetupStatePatterns on VenueSetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueSetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueSetupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueSetupState value)  $default,){
final _that = this;
switch (_that) {
case _VenueSetupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueSetupState value)?  $default,){
final _that = this;
switch (_that) {
case _VenueSetupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int step,  VenueModel? venue,  VenueApprovalModel? approval,  List<GovernorateModel> governorates,  List<LocalizedItemModel> facilities,  List<LocalizedItemModel> surfaces,  List<VenuePitchModel> pitches,  Map<int, DayHours> week,  List<String> pendingVenuePhotos,  List<String> draftPitchPhotos,  bool saving,  bool uploading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueSetupState() when $default != null:
return $default(_that.step,_that.venue,_that.approval,_that.governorates,_that.facilities,_that.surfaces,_that.pitches,_that.week,_that.pendingVenuePhotos,_that.draftPitchPhotos,_that.saving,_that.uploading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int step,  VenueModel? venue,  VenueApprovalModel? approval,  List<GovernorateModel> governorates,  List<LocalizedItemModel> facilities,  List<LocalizedItemModel> surfaces,  List<VenuePitchModel> pitches,  Map<int, DayHours> week,  List<String> pendingVenuePhotos,  List<String> draftPitchPhotos,  bool saving,  bool uploading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _VenueSetupState():
return $default(_that.step,_that.venue,_that.approval,_that.governorates,_that.facilities,_that.surfaces,_that.pitches,_that.week,_that.pendingVenuePhotos,_that.draftPitchPhotos,_that.saving,_that.uploading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int step,  VenueModel? venue,  VenueApprovalModel? approval,  List<GovernorateModel> governorates,  List<LocalizedItemModel> facilities,  List<LocalizedItemModel> surfaces,  List<VenuePitchModel> pitches,  Map<int, DayHours> week,  List<String> pendingVenuePhotos,  List<String> draftPitchPhotos,  bool saving,  bool uploading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _VenueSetupState() when $default != null:
return $default(_that.step,_that.venue,_that.approval,_that.governorates,_that.facilities,_that.surfaces,_that.pitches,_that.week,_that.pendingVenuePhotos,_that.draftPitchPhotos,_that.saving,_that.uploading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _VenueSetupState implements VenueSetupState {
  const _VenueSetupState({this.step = 1, this.venue, this.approval, final  List<GovernorateModel> governorates = const [], final  List<LocalizedItemModel> facilities = const [], final  List<LocalizedItemModel> surfaces = const [], final  List<VenuePitchModel> pitches = const [], required final  Map<int, DayHours> week, final  List<String> pendingVenuePhotos = const [], final  List<String> draftPitchPhotos = const [], this.saving = false, this.uploading = false, this.error}): _governorates = governorates,_facilities = facilities,_surfaces = surfaces,_pitches = pitches,_week = week,_pendingVenuePhotos = pendingVenuePhotos,_draftPitchPhotos = draftPitchPhotos;
  

/// 1 place, 2 pitches, 3 hours, 4 review.
@override@JsonKey() final  int step;
/// Null until the first save creates it.
@override final  VenueModel? venue;
@override final  VenueApprovalModel? approval;
 final  List<GovernorateModel> _governorates;
@override@JsonKey() List<GovernorateModel> get governorates {
  if (_governorates is EqualUnmodifiableListView) return _governorates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_governorates);
}

 final  List<LocalizedItemModel> _facilities;
@override@JsonKey() List<LocalizedItemModel> get facilities {
  if (_facilities is EqualUnmodifiableListView) return _facilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_facilities);
}

 final  List<LocalizedItemModel> _surfaces;
@override@JsonKey() List<LocalizedItemModel> get surfaces {
  if (_surfaces is EqualUnmodifiableListView) return _surfaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_surfaces);
}

 final  List<VenuePitchModel> _pitches;
@override@JsonKey() List<VenuePitchModel> get pitches {
  if (_pitches is EqualUnmodifiableListView) return _pitches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pitches);
}

 final  Map<int, DayHours> _week;
@override Map<int, DayHours> get week {
  if (_week is EqualUnmodifiableMapView) return _week;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_week);
}

/// Photos uploaded before the venue exists, and while adding a pitch.
 final  List<String> _pendingVenuePhotos;
/// Photos uploaded before the venue exists, and while adding a pitch.
@override@JsonKey() List<String> get pendingVenuePhotos {
  if (_pendingVenuePhotos is EqualUnmodifiableListView) return _pendingVenuePhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingVenuePhotos);
}

 final  List<String> _draftPitchPhotos;
@override@JsonKey() List<String> get draftPitchPhotos {
  if (_draftPitchPhotos is EqualUnmodifiableListView) return _draftPitchPhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_draftPitchPhotos);
}

@override@JsonKey() final  bool saving;
@override@JsonKey() final  bool uploading;
@override final  String? error;

/// Create a copy of VenueSetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueSetupStateCopyWith<_VenueSetupState> get copyWith => __$VenueSetupStateCopyWithImpl<_VenueSetupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueSetupState&&(identical(other.step, step) || other.step == step)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.approval, approval) || other.approval == approval)&&const DeepCollectionEquality().equals(other._governorates, _governorates)&&const DeepCollectionEquality().equals(other._facilities, _facilities)&&const DeepCollectionEquality().equals(other._surfaces, _surfaces)&&const DeepCollectionEquality().equals(other._pitches, _pitches)&&const DeepCollectionEquality().equals(other._week, _week)&&const DeepCollectionEquality().equals(other._pendingVenuePhotos, _pendingVenuePhotos)&&const DeepCollectionEquality().equals(other._draftPitchPhotos, _draftPitchPhotos)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.uploading, uploading) || other.uploading == uploading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,step,venue,approval,const DeepCollectionEquality().hash(_governorates),const DeepCollectionEquality().hash(_facilities),const DeepCollectionEquality().hash(_surfaces),const DeepCollectionEquality().hash(_pitches),const DeepCollectionEquality().hash(_week),const DeepCollectionEquality().hash(_pendingVenuePhotos),const DeepCollectionEquality().hash(_draftPitchPhotos),saving,uploading,error);

@override
String toString() {
  return 'VenueSetupState(step: $step, venue: $venue, approval: $approval, governorates: $governorates, facilities: $facilities, surfaces: $surfaces, pitches: $pitches, week: $week, pendingVenuePhotos: $pendingVenuePhotos, draftPitchPhotos: $draftPitchPhotos, saving: $saving, uploading: $uploading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$VenueSetupStateCopyWith<$Res> implements $VenueSetupStateCopyWith<$Res> {
  factory _$VenueSetupStateCopyWith(_VenueSetupState value, $Res Function(_VenueSetupState) _then) = __$VenueSetupStateCopyWithImpl;
@override @useResult
$Res call({
 int step, VenueModel? venue, VenueApprovalModel? approval, List<GovernorateModel> governorates, List<LocalizedItemModel> facilities, List<LocalizedItemModel> surfaces, List<VenuePitchModel> pitches, Map<int, DayHours> week, List<String> pendingVenuePhotos, List<String> draftPitchPhotos, bool saving, bool uploading, String? error
});




}
/// @nodoc
class __$VenueSetupStateCopyWithImpl<$Res>
    implements _$VenueSetupStateCopyWith<$Res> {
  __$VenueSetupStateCopyWithImpl(this._self, this._then);

  final _VenueSetupState _self;
  final $Res Function(_VenueSetupState) _then;

/// Create a copy of VenueSetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? venue = freezed,Object? approval = freezed,Object? governorates = null,Object? facilities = null,Object? surfaces = null,Object? pitches = null,Object? week = null,Object? pendingVenuePhotos = null,Object? draftPitchPhotos = null,Object? saving = null,Object? uploading = null,Object? error = freezed,}) {
  return _then(_VenueSetupState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as VenueModel?,approval: freezed == approval ? _self.approval : approval // ignore: cast_nullable_to_non_nullable
as VenueApprovalModel?,governorates: null == governorates ? _self._governorates : governorates // ignore: cast_nullable_to_non_nullable
as List<GovernorateModel>,facilities: null == facilities ? _self._facilities : facilities // ignore: cast_nullable_to_non_nullable
as List<LocalizedItemModel>,surfaces: null == surfaces ? _self._surfaces : surfaces // ignore: cast_nullable_to_non_nullable
as List<LocalizedItemModel>,pitches: null == pitches ? _self._pitches : pitches // ignore: cast_nullable_to_non_nullable
as List<VenuePitchModel>,week: null == week ? _self._week : week // ignore: cast_nullable_to_non_nullable
as Map<int, DayHours>,pendingVenuePhotos: null == pendingVenuePhotos ? _self._pendingVenuePhotos : pendingVenuePhotos // ignore: cast_nullable_to_non_nullable
as List<String>,draftPitchPhotos: null == draftPitchPhotos ? _self._draftPitchPhotos : draftPitchPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,uploading: null == uploading ? _self.uploading : uploading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
