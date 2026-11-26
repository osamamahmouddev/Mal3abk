// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_calendar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueCalendarState {

 VenueCalendarView get view;/// The Cairo calendar date in focus (time part is midnight).
 DateTime get date;/// The pitch the week view shows.
 String? get weekPitchId; List<CalendarSlotModel> get slots; List<OperatingScheduleModel> get schedules; bool get isLoading; String? get error;/// Picking many hours at once: free hours to book, or the venue's own
/// bookings and blocked periods to free.
 bool get picking; Map<String, CalendarHour> get pickedHours;/// Picked taken slots: id → whether it is a blocked period.
 Map<String, bool> get pickedTaken; bool get busy;
/// Create a copy of VenueCalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueCalendarStateCopyWith<VenueCalendarState> get copyWith => _$VenueCalendarStateCopyWithImpl<VenueCalendarState>(this as VenueCalendarState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueCalendarState&&(identical(other.view, view) || other.view == view)&&(identical(other.date, date) || other.date == date)&&(identical(other.weekPitchId, weekPitchId) || other.weekPitchId == weekPitchId)&&const DeepCollectionEquality().equals(other.slots, slots)&&const DeepCollectionEquality().equals(other.schedules, schedules)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.picking, picking) || other.picking == picking)&&const DeepCollectionEquality().equals(other.pickedHours, pickedHours)&&const DeepCollectionEquality().equals(other.pickedTaken, pickedTaken)&&(identical(other.busy, busy) || other.busy == busy));
}


@override
int get hashCode => Object.hash(runtimeType,view,date,weekPitchId,const DeepCollectionEquality().hash(slots),const DeepCollectionEquality().hash(schedules),isLoading,error,picking,const DeepCollectionEquality().hash(pickedHours),const DeepCollectionEquality().hash(pickedTaken),busy);

@override
String toString() {
  return 'VenueCalendarState(view: $view, date: $date, weekPitchId: $weekPitchId, slots: $slots, schedules: $schedules, isLoading: $isLoading, error: $error, picking: $picking, pickedHours: $pickedHours, pickedTaken: $pickedTaken, busy: $busy)';
}


}

/// @nodoc
abstract mixin class $VenueCalendarStateCopyWith<$Res>  {
  factory $VenueCalendarStateCopyWith(VenueCalendarState value, $Res Function(VenueCalendarState) _then) = _$VenueCalendarStateCopyWithImpl;
@useResult
$Res call({
 VenueCalendarView view, DateTime date, String? weekPitchId, List<CalendarSlotModel> slots, List<OperatingScheduleModel> schedules, bool isLoading, String? error, bool picking, Map<String, CalendarHour> pickedHours, Map<String, bool> pickedTaken, bool busy
});




}
/// @nodoc
class _$VenueCalendarStateCopyWithImpl<$Res>
    implements $VenueCalendarStateCopyWith<$Res> {
  _$VenueCalendarStateCopyWithImpl(this._self, this._then);

  final VenueCalendarState _self;
  final $Res Function(VenueCalendarState) _then;

/// Create a copy of VenueCalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? view = null,Object? date = null,Object? weekPitchId = freezed,Object? slots = null,Object? schedules = null,Object? isLoading = null,Object? error = freezed,Object? picking = null,Object? pickedHours = null,Object? pickedTaken = null,Object? busy = null,}) {
  return _then(_self.copyWith(
view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as VenueCalendarView,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weekPitchId: freezed == weekPitchId ? _self.weekPitchId : weekPitchId // ignore: cast_nullable_to_non_nullable
as String?,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<CalendarSlotModel>,schedules: null == schedules ? _self.schedules : schedules // ignore: cast_nullable_to_non_nullable
as List<OperatingScheduleModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,picking: null == picking ? _self.picking : picking // ignore: cast_nullable_to_non_nullable
as bool,pickedHours: null == pickedHours ? _self.pickedHours : pickedHours // ignore: cast_nullable_to_non_nullable
as Map<String, CalendarHour>,pickedTaken: null == pickedTaken ? _self.pickedTaken : pickedTaken // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueCalendarState].
extension VenueCalendarStatePatterns on VenueCalendarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueCalendarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueCalendarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueCalendarState value)  $default,){
final _that = this;
switch (_that) {
case _VenueCalendarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueCalendarState value)?  $default,){
final _that = this;
switch (_that) {
case _VenueCalendarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VenueCalendarView view,  DateTime date,  String? weekPitchId,  List<CalendarSlotModel> slots,  List<OperatingScheduleModel> schedules,  bool isLoading,  String? error,  bool picking,  Map<String, CalendarHour> pickedHours,  Map<String, bool> pickedTaken,  bool busy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueCalendarState() when $default != null:
return $default(_that.view,_that.date,_that.weekPitchId,_that.slots,_that.schedules,_that.isLoading,_that.error,_that.picking,_that.pickedHours,_that.pickedTaken,_that.busy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VenueCalendarView view,  DateTime date,  String? weekPitchId,  List<CalendarSlotModel> slots,  List<OperatingScheduleModel> schedules,  bool isLoading,  String? error,  bool picking,  Map<String, CalendarHour> pickedHours,  Map<String, bool> pickedTaken,  bool busy)  $default,) {final _that = this;
switch (_that) {
case _VenueCalendarState():
return $default(_that.view,_that.date,_that.weekPitchId,_that.slots,_that.schedules,_that.isLoading,_that.error,_that.picking,_that.pickedHours,_that.pickedTaken,_that.busy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VenueCalendarView view,  DateTime date,  String? weekPitchId,  List<CalendarSlotModel> slots,  List<OperatingScheduleModel> schedules,  bool isLoading,  String? error,  bool picking,  Map<String, CalendarHour> pickedHours,  Map<String, bool> pickedTaken,  bool busy)?  $default,) {final _that = this;
switch (_that) {
case _VenueCalendarState() when $default != null:
return $default(_that.view,_that.date,_that.weekPitchId,_that.slots,_that.schedules,_that.isLoading,_that.error,_that.picking,_that.pickedHours,_that.pickedTaken,_that.busy);case _:
  return null;

}
}

}

/// @nodoc


class _VenueCalendarState implements VenueCalendarState {
  const _VenueCalendarState({required this.view, required this.date, this.weekPitchId, final  List<CalendarSlotModel> slots = const [], final  List<OperatingScheduleModel> schedules = const [], this.isLoading = true, this.error, this.picking = false, final  Map<String, CalendarHour> pickedHours = const {}, final  Map<String, bool> pickedTaken = const {}, this.busy = false}): _slots = slots,_schedules = schedules,_pickedHours = pickedHours,_pickedTaken = pickedTaken;
  

@override final  VenueCalendarView view;
/// The Cairo calendar date in focus (time part is midnight).
@override final  DateTime date;
/// The pitch the week view shows.
@override final  String? weekPitchId;
 final  List<CalendarSlotModel> _slots;
@override@JsonKey() List<CalendarSlotModel> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}

 final  List<OperatingScheduleModel> _schedules;
@override@JsonKey() List<OperatingScheduleModel> get schedules {
  if (_schedules is EqualUnmodifiableListView) return _schedules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_schedules);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;
/// Picking many hours at once: free hours to book, or the venue's own
/// bookings and blocked periods to free.
@override@JsonKey() final  bool picking;
 final  Map<String, CalendarHour> _pickedHours;
@override@JsonKey() Map<String, CalendarHour> get pickedHours {
  if (_pickedHours is EqualUnmodifiableMapView) return _pickedHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_pickedHours);
}

/// Picked taken slots: id → whether it is a blocked period.
 final  Map<String, bool> _pickedTaken;
/// Picked taken slots: id → whether it is a blocked period.
@override@JsonKey() Map<String, bool> get pickedTaken {
  if (_pickedTaken is EqualUnmodifiableMapView) return _pickedTaken;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_pickedTaken);
}

@override@JsonKey() final  bool busy;

/// Create a copy of VenueCalendarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueCalendarStateCopyWith<_VenueCalendarState> get copyWith => __$VenueCalendarStateCopyWithImpl<_VenueCalendarState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueCalendarState&&(identical(other.view, view) || other.view == view)&&(identical(other.date, date) || other.date == date)&&(identical(other.weekPitchId, weekPitchId) || other.weekPitchId == weekPitchId)&&const DeepCollectionEquality().equals(other._slots, _slots)&&const DeepCollectionEquality().equals(other._schedules, _schedules)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.picking, picking) || other.picking == picking)&&const DeepCollectionEquality().equals(other._pickedHours, _pickedHours)&&const DeepCollectionEquality().equals(other._pickedTaken, _pickedTaken)&&(identical(other.busy, busy) || other.busy == busy));
}


@override
int get hashCode => Object.hash(runtimeType,view,date,weekPitchId,const DeepCollectionEquality().hash(_slots),const DeepCollectionEquality().hash(_schedules),isLoading,error,picking,const DeepCollectionEquality().hash(_pickedHours),const DeepCollectionEquality().hash(_pickedTaken),busy);

@override
String toString() {
  return 'VenueCalendarState(view: $view, date: $date, weekPitchId: $weekPitchId, slots: $slots, schedules: $schedules, isLoading: $isLoading, error: $error, picking: $picking, pickedHours: $pickedHours, pickedTaken: $pickedTaken, busy: $busy)';
}


}

/// @nodoc
abstract mixin class _$VenueCalendarStateCopyWith<$Res> implements $VenueCalendarStateCopyWith<$Res> {
  factory _$VenueCalendarStateCopyWith(_VenueCalendarState value, $Res Function(_VenueCalendarState) _then) = __$VenueCalendarStateCopyWithImpl;
@override @useResult
$Res call({
 VenueCalendarView view, DateTime date, String? weekPitchId, List<CalendarSlotModel> slots, List<OperatingScheduleModel> schedules, bool isLoading, String? error, bool picking, Map<String, CalendarHour> pickedHours, Map<String, bool> pickedTaken, bool busy
});




}
/// @nodoc
class __$VenueCalendarStateCopyWithImpl<$Res>
    implements _$VenueCalendarStateCopyWith<$Res> {
  __$VenueCalendarStateCopyWithImpl(this._self, this._then);

  final _VenueCalendarState _self;
  final $Res Function(_VenueCalendarState) _then;

/// Create a copy of VenueCalendarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? view = null,Object? date = null,Object? weekPitchId = freezed,Object? slots = null,Object? schedules = null,Object? isLoading = null,Object? error = freezed,Object? picking = null,Object? pickedHours = null,Object? pickedTaken = null,Object? busy = null,}) {
  return _then(_VenueCalendarState(
view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as VenueCalendarView,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weekPitchId: freezed == weekPitchId ? _self.weekPitchId : weekPitchId // ignore: cast_nullable_to_non_nullable
as String?,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<CalendarSlotModel>,schedules: null == schedules ? _self._schedules : schedules // ignore: cast_nullable_to_non_nullable
as List<OperatingScheduleModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,picking: null == picking ? _self.picking : picking // ignore: cast_nullable_to_non_nullable
as bool,pickedHours: null == pickedHours ? _self._pickedHours : pickedHours // ignore: cast_nullable_to_non_nullable
as Map<String, CalendarHour>,pickedTaken: null == pickedTaken ? _self._pickedTaken : pickedTaken // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
