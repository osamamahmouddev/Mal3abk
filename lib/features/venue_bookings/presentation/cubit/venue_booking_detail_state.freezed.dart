// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_booking_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueBookingDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueBookingDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VenueBookingDetailState()';
}


}

/// @nodoc
class $VenueBookingDetailStateCopyWith<$Res>  {
$VenueBookingDetailStateCopyWith(VenueBookingDetailState _, $Res Function(VenueBookingDetailState) __);
}


/// Adds pattern-matching-related methods to [VenueBookingDetailState].
extension VenueBookingDetailStatePatterns on VenueBookingDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VenueBookingDetailLoading value)?  loading,TResult Function( VenueBookingDetailSuccess value)?  success,TResult Function( VenueBookingDetailError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VenueBookingDetailLoading() when loading != null:
return loading(_that);case VenueBookingDetailSuccess() when success != null:
return success(_that);case VenueBookingDetailError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VenueBookingDetailLoading value)  loading,required TResult Function( VenueBookingDetailSuccess value)  success,required TResult Function( VenueBookingDetailError value)  error,}){
final _that = this;
switch (_that) {
case VenueBookingDetailLoading():
return loading(_that);case VenueBookingDetailSuccess():
return success(_that);case VenueBookingDetailError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VenueBookingDetailLoading value)?  loading,TResult? Function( VenueBookingDetailSuccess value)?  success,TResult? Function( VenueBookingDetailError value)?  error,}){
final _that = this;
switch (_that) {
case VenueBookingDetailLoading() when loading != null:
return loading(_that);case VenueBookingDetailSuccess() when success != null:
return success(_that);case VenueBookingDetailError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( VenueBookingDetailModel booking,  VenueBookingAction? busy,  VenueBookingAction? done,  String? actionError)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VenueBookingDetailLoading() when loading != null:
return loading();case VenueBookingDetailSuccess() when success != null:
return success(_that.booking,_that.busy,_that.done,_that.actionError);case VenueBookingDetailError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( VenueBookingDetailModel booking,  VenueBookingAction? busy,  VenueBookingAction? done,  String? actionError)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case VenueBookingDetailLoading():
return loading();case VenueBookingDetailSuccess():
return success(_that.booking,_that.busy,_that.done,_that.actionError);case VenueBookingDetailError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( VenueBookingDetailModel booking,  VenueBookingAction? busy,  VenueBookingAction? done,  String? actionError)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case VenueBookingDetailLoading() when loading != null:
return loading();case VenueBookingDetailSuccess() when success != null:
return success(_that.booking,_that.busy,_that.done,_that.actionError);case VenueBookingDetailError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class VenueBookingDetailLoading implements VenueBookingDetailState {
  const VenueBookingDetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueBookingDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VenueBookingDetailState.loading()';
}


}




/// @nodoc


class VenueBookingDetailSuccess implements VenueBookingDetailState {
  const VenueBookingDetailSuccess({required this.booking, this.busy, this.done, this.actionError});
  

 final  VenueBookingDetailModel booking;
 final  VenueBookingAction? busy;
 final  VenueBookingAction? done;
 final  String? actionError;

/// Create a copy of VenueBookingDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueBookingDetailSuccessCopyWith<VenueBookingDetailSuccess> get copyWith => _$VenueBookingDetailSuccessCopyWithImpl<VenueBookingDetailSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueBookingDetailSuccess&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.busy, busy) || other.busy == busy)&&(identical(other.done, done) || other.done == done)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,booking,busy,done,actionError);

@override
String toString() {
  return 'VenueBookingDetailState.success(booking: $booking, busy: $busy, done: $done, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class $VenueBookingDetailSuccessCopyWith<$Res> implements $VenueBookingDetailStateCopyWith<$Res> {
  factory $VenueBookingDetailSuccessCopyWith(VenueBookingDetailSuccess value, $Res Function(VenueBookingDetailSuccess) _then) = _$VenueBookingDetailSuccessCopyWithImpl;
@useResult
$Res call({
 VenueBookingDetailModel booking, VenueBookingAction? busy, VenueBookingAction? done, String? actionError
});




}
/// @nodoc
class _$VenueBookingDetailSuccessCopyWithImpl<$Res>
    implements $VenueBookingDetailSuccessCopyWith<$Res> {
  _$VenueBookingDetailSuccessCopyWithImpl(this._self, this._then);

  final VenueBookingDetailSuccess _self;
  final $Res Function(VenueBookingDetailSuccess) _then;

/// Create a copy of VenueBookingDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? booking = null,Object? busy = freezed,Object? done = freezed,Object? actionError = freezed,}) {
  return _then(VenueBookingDetailSuccess(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as VenueBookingDetailModel,busy: freezed == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as VenueBookingAction?,done: freezed == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as VenueBookingAction?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class VenueBookingDetailError implements VenueBookingDetailState {
  const VenueBookingDetailError(this.message);
  

 final  String message;

/// Create a copy of VenueBookingDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueBookingDetailErrorCopyWith<VenueBookingDetailError> get copyWith => _$VenueBookingDetailErrorCopyWithImpl<VenueBookingDetailError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueBookingDetailError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'VenueBookingDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $VenueBookingDetailErrorCopyWith<$Res> implements $VenueBookingDetailStateCopyWith<$Res> {
  factory $VenueBookingDetailErrorCopyWith(VenueBookingDetailError value, $Res Function(VenueBookingDetailError) _then) = _$VenueBookingDetailErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$VenueBookingDetailErrorCopyWithImpl<$Res>
    implements $VenueBookingDetailErrorCopyWith<$Res> {
  _$VenueBookingDetailErrorCopyWithImpl(this._self, this._then);

  final VenueBookingDetailError _self;
  final $Res Function(VenueBookingDetailError) _then;

/// Create a copy of VenueBookingDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(VenueBookingDetailError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
