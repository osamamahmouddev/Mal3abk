// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manual_booking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ManualBookingState {

 String get pitchId;/// The Cairo business date.
 DateTime get date;/// Minutes from the business date's midnight; past 1440 is that night's
/// late session (after 12 at night).
 int get startMinutes; int get durationMinutes; ManualPaymentStatus get payment;/// The rules' price for the slot, filled in for the user to change.
 double? get suggestedPrice; List<CalendarSlotModel> get daySlots; List<VenueCustomerModel> get customers; bool get customersLoading; VenueCustomerModel? get selectedCustomer;/// Field → localization key of its error.
 Map<String, String> get errors; bool get submitting; String? get serverError; bool get done;
/// Create a copy of ManualBookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManualBookingStateCopyWith<ManualBookingState> get copyWith => _$ManualBookingStateCopyWithImpl<ManualBookingState>(this as ManualBookingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManualBookingState&&(identical(other.pitchId, pitchId) || other.pitchId == pitchId)&&(identical(other.date, date) || other.date == date)&&(identical(other.startMinutes, startMinutes) || other.startMinutes == startMinutes)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.payment, payment) || other.payment == payment)&&(identical(other.suggestedPrice, suggestedPrice) || other.suggestedPrice == suggestedPrice)&&const DeepCollectionEquality().equals(other.daySlots, daySlots)&&const DeepCollectionEquality().equals(other.customers, customers)&&(identical(other.customersLoading, customersLoading) || other.customersLoading == customersLoading)&&(identical(other.selectedCustomer, selectedCustomer) || other.selectedCustomer == selectedCustomer)&&const DeepCollectionEquality().equals(other.errors, errors)&&(identical(other.submitting, submitting) || other.submitting == submitting)&&(identical(other.serverError, serverError) || other.serverError == serverError)&&(identical(other.done, done) || other.done == done));
}


@override
int get hashCode => Object.hash(runtimeType,pitchId,date,startMinutes,durationMinutes,payment,suggestedPrice,const DeepCollectionEquality().hash(daySlots),const DeepCollectionEquality().hash(customers),customersLoading,selectedCustomer,const DeepCollectionEquality().hash(errors),submitting,serverError,done);

@override
String toString() {
  return 'ManualBookingState(pitchId: $pitchId, date: $date, startMinutes: $startMinutes, durationMinutes: $durationMinutes, payment: $payment, suggestedPrice: $suggestedPrice, daySlots: $daySlots, customers: $customers, customersLoading: $customersLoading, selectedCustomer: $selectedCustomer, errors: $errors, submitting: $submitting, serverError: $serverError, done: $done)';
}


}

/// @nodoc
abstract mixin class $ManualBookingStateCopyWith<$Res>  {
  factory $ManualBookingStateCopyWith(ManualBookingState value, $Res Function(ManualBookingState) _then) = _$ManualBookingStateCopyWithImpl;
@useResult
$Res call({
 String pitchId, DateTime date, int startMinutes, int durationMinutes, ManualPaymentStatus payment, double? suggestedPrice, List<CalendarSlotModel> daySlots, List<VenueCustomerModel> customers, bool customersLoading, VenueCustomerModel? selectedCustomer, Map<String, String> errors, bool submitting, String? serverError, bool done
});




}
/// @nodoc
class _$ManualBookingStateCopyWithImpl<$Res>
    implements $ManualBookingStateCopyWith<$Res> {
  _$ManualBookingStateCopyWithImpl(this._self, this._then);

  final ManualBookingState _self;
  final $Res Function(ManualBookingState) _then;

/// Create a copy of ManualBookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pitchId = null,Object? date = null,Object? startMinutes = null,Object? durationMinutes = null,Object? payment = null,Object? suggestedPrice = freezed,Object? daySlots = null,Object? customers = null,Object? customersLoading = null,Object? selectedCustomer = freezed,Object? errors = null,Object? submitting = null,Object? serverError = freezed,Object? done = null,}) {
  return _then(_self.copyWith(
pitchId: null == pitchId ? _self.pitchId : pitchId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,startMinutes: null == startMinutes ? _self.startMinutes : startMinutes // ignore: cast_nullable_to_non_nullable
as int,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as ManualPaymentStatus,suggestedPrice: freezed == suggestedPrice ? _self.suggestedPrice : suggestedPrice // ignore: cast_nullable_to_non_nullable
as double?,daySlots: null == daySlots ? _self.daySlots : daySlots // ignore: cast_nullable_to_non_nullable
as List<CalendarSlotModel>,customers: null == customers ? _self.customers : customers // ignore: cast_nullable_to_non_nullable
as List<VenueCustomerModel>,customersLoading: null == customersLoading ? _self.customersLoading : customersLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedCustomer: freezed == selectedCustomer ? _self.selectedCustomer : selectedCustomer // ignore: cast_nullable_to_non_nullable
as VenueCustomerModel?,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,serverError: freezed == serverError ? _self.serverError : serverError // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ManualBookingState].
extension ManualBookingStatePatterns on ManualBookingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ManualBookingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ManualBookingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ManualBookingState value)  $default,){
final _that = this;
switch (_that) {
case _ManualBookingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ManualBookingState value)?  $default,){
final _that = this;
switch (_that) {
case _ManualBookingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pitchId,  DateTime date,  int startMinutes,  int durationMinutes,  ManualPaymentStatus payment,  double? suggestedPrice,  List<CalendarSlotModel> daySlots,  List<VenueCustomerModel> customers,  bool customersLoading,  VenueCustomerModel? selectedCustomer,  Map<String, String> errors,  bool submitting,  String? serverError,  bool done)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ManualBookingState() when $default != null:
return $default(_that.pitchId,_that.date,_that.startMinutes,_that.durationMinutes,_that.payment,_that.suggestedPrice,_that.daySlots,_that.customers,_that.customersLoading,_that.selectedCustomer,_that.errors,_that.submitting,_that.serverError,_that.done);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pitchId,  DateTime date,  int startMinutes,  int durationMinutes,  ManualPaymentStatus payment,  double? suggestedPrice,  List<CalendarSlotModel> daySlots,  List<VenueCustomerModel> customers,  bool customersLoading,  VenueCustomerModel? selectedCustomer,  Map<String, String> errors,  bool submitting,  String? serverError,  bool done)  $default,) {final _that = this;
switch (_that) {
case _ManualBookingState():
return $default(_that.pitchId,_that.date,_that.startMinutes,_that.durationMinutes,_that.payment,_that.suggestedPrice,_that.daySlots,_that.customers,_that.customersLoading,_that.selectedCustomer,_that.errors,_that.submitting,_that.serverError,_that.done);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pitchId,  DateTime date,  int startMinutes,  int durationMinutes,  ManualPaymentStatus payment,  double? suggestedPrice,  List<CalendarSlotModel> daySlots,  List<VenueCustomerModel> customers,  bool customersLoading,  VenueCustomerModel? selectedCustomer,  Map<String, String> errors,  bool submitting,  String? serverError,  bool done)?  $default,) {final _that = this;
switch (_that) {
case _ManualBookingState() when $default != null:
return $default(_that.pitchId,_that.date,_that.startMinutes,_that.durationMinutes,_that.payment,_that.suggestedPrice,_that.daySlots,_that.customers,_that.customersLoading,_that.selectedCustomer,_that.errors,_that.submitting,_that.serverError,_that.done);case _:
  return null;

}
}

}

/// @nodoc


class _ManualBookingState implements ManualBookingState {
  const _ManualBookingState({required this.pitchId, required this.date, required this.startMinutes, this.durationMinutes = 60, this.payment = ManualPaymentStatus.full, this.suggestedPrice, final  List<CalendarSlotModel> daySlots = const [], final  List<VenueCustomerModel> customers = const [], this.customersLoading = false, this.selectedCustomer, final  Map<String, String> errors = const {}, this.submitting = false, this.serverError, this.done = false}): _daySlots = daySlots,_customers = customers,_errors = errors;
  

@override final  String pitchId;
/// The Cairo business date.
@override final  DateTime date;
/// Minutes from the business date's midnight; past 1440 is that night's
/// late session (after 12 at night).
@override final  int startMinutes;
@override@JsonKey() final  int durationMinutes;
@override@JsonKey() final  ManualPaymentStatus payment;
/// The rules' price for the slot, filled in for the user to change.
@override final  double? suggestedPrice;
 final  List<CalendarSlotModel> _daySlots;
@override@JsonKey() List<CalendarSlotModel> get daySlots {
  if (_daySlots is EqualUnmodifiableListView) return _daySlots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_daySlots);
}

 final  List<VenueCustomerModel> _customers;
@override@JsonKey() List<VenueCustomerModel> get customers {
  if (_customers is EqualUnmodifiableListView) return _customers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customers);
}

@override@JsonKey() final  bool customersLoading;
@override final  VenueCustomerModel? selectedCustomer;
/// Field → localization key of its error.
 final  Map<String, String> _errors;
/// Field → localization key of its error.
@override@JsonKey() Map<String, String> get errors {
  if (_errors is EqualUnmodifiableMapView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_errors);
}

@override@JsonKey() final  bool submitting;
@override final  String? serverError;
@override@JsonKey() final  bool done;

/// Create a copy of ManualBookingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManualBookingStateCopyWith<_ManualBookingState> get copyWith => __$ManualBookingStateCopyWithImpl<_ManualBookingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManualBookingState&&(identical(other.pitchId, pitchId) || other.pitchId == pitchId)&&(identical(other.date, date) || other.date == date)&&(identical(other.startMinutes, startMinutes) || other.startMinutes == startMinutes)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.payment, payment) || other.payment == payment)&&(identical(other.suggestedPrice, suggestedPrice) || other.suggestedPrice == suggestedPrice)&&const DeepCollectionEquality().equals(other._daySlots, _daySlots)&&const DeepCollectionEquality().equals(other._customers, _customers)&&(identical(other.customersLoading, customersLoading) || other.customersLoading == customersLoading)&&(identical(other.selectedCustomer, selectedCustomer) || other.selectedCustomer == selectedCustomer)&&const DeepCollectionEquality().equals(other._errors, _errors)&&(identical(other.submitting, submitting) || other.submitting == submitting)&&(identical(other.serverError, serverError) || other.serverError == serverError)&&(identical(other.done, done) || other.done == done));
}


@override
int get hashCode => Object.hash(runtimeType,pitchId,date,startMinutes,durationMinutes,payment,suggestedPrice,const DeepCollectionEquality().hash(_daySlots),const DeepCollectionEquality().hash(_customers),customersLoading,selectedCustomer,const DeepCollectionEquality().hash(_errors),submitting,serverError,done);

@override
String toString() {
  return 'ManualBookingState(pitchId: $pitchId, date: $date, startMinutes: $startMinutes, durationMinutes: $durationMinutes, payment: $payment, suggestedPrice: $suggestedPrice, daySlots: $daySlots, customers: $customers, customersLoading: $customersLoading, selectedCustomer: $selectedCustomer, errors: $errors, submitting: $submitting, serverError: $serverError, done: $done)';
}


}

/// @nodoc
abstract mixin class _$ManualBookingStateCopyWith<$Res> implements $ManualBookingStateCopyWith<$Res> {
  factory _$ManualBookingStateCopyWith(_ManualBookingState value, $Res Function(_ManualBookingState) _then) = __$ManualBookingStateCopyWithImpl;
@override @useResult
$Res call({
 String pitchId, DateTime date, int startMinutes, int durationMinutes, ManualPaymentStatus payment, double? suggestedPrice, List<CalendarSlotModel> daySlots, List<VenueCustomerModel> customers, bool customersLoading, VenueCustomerModel? selectedCustomer, Map<String, String> errors, bool submitting, String? serverError, bool done
});




}
/// @nodoc
class __$ManualBookingStateCopyWithImpl<$Res>
    implements _$ManualBookingStateCopyWith<$Res> {
  __$ManualBookingStateCopyWithImpl(this._self, this._then);

  final _ManualBookingState _self;
  final $Res Function(_ManualBookingState) _then;

/// Create a copy of ManualBookingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pitchId = null,Object? date = null,Object? startMinutes = null,Object? durationMinutes = null,Object? payment = null,Object? suggestedPrice = freezed,Object? daySlots = null,Object? customers = null,Object? customersLoading = null,Object? selectedCustomer = freezed,Object? errors = null,Object? submitting = null,Object? serverError = freezed,Object? done = null,}) {
  return _then(_ManualBookingState(
pitchId: null == pitchId ? _self.pitchId : pitchId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,startMinutes: null == startMinutes ? _self.startMinutes : startMinutes // ignore: cast_nullable_to_non_nullable
as int,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as ManualPaymentStatus,suggestedPrice: freezed == suggestedPrice ? _self.suggestedPrice : suggestedPrice // ignore: cast_nullable_to_non_nullable
as double?,daySlots: null == daySlots ? _self._daySlots : daySlots // ignore: cast_nullable_to_non_nullable
as List<CalendarSlotModel>,customers: null == customers ? _self._customers : customers // ignore: cast_nullable_to_non_nullable
as List<VenueCustomerModel>,customersLoading: null == customersLoading ? _self.customersLoading : customersLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedCustomer: freezed == selectedCustomer ? _self.selectedCustomer : selectedCustomer // ignore: cast_nullable_to_non_nullable
as VenueCustomerModel?,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,serverError: freezed == serverError ? _self.serverError : serverError // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
