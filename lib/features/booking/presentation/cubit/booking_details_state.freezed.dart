// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingDetailsState()';
}


}

/// @nodoc
class $BookingDetailsStateCopyWith<$Res>  {
$BookingDetailsStateCopyWith(BookingDetailsState _, $Res Function(BookingDetailsState) __);
}


/// Adds pattern-matching-related methods to [BookingDetailsState].
extension BookingDetailsStatePatterns on BookingDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BookingDetailsInitial value)?  initial,TResult Function( BookingDetailsLoading value)?  loading,TResult Function( BookingDetailsSuccess value)?  success,TResult Function( BookingDetailsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BookingDetailsInitial() when initial != null:
return initial(_that);case BookingDetailsLoading() when loading != null:
return loading(_that);case BookingDetailsSuccess() when success != null:
return success(_that);case BookingDetailsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BookingDetailsInitial value)  initial,required TResult Function( BookingDetailsLoading value)  loading,required TResult Function( BookingDetailsSuccess value)  success,required TResult Function( BookingDetailsError value)  error,}){
final _that = this;
switch (_that) {
case BookingDetailsInitial():
return initial(_that);case BookingDetailsLoading():
return loading(_that);case BookingDetailsSuccess():
return success(_that);case BookingDetailsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BookingDetailsInitial value)?  initial,TResult? Function( BookingDetailsLoading value)?  loading,TResult? Function( BookingDetailsSuccess value)?  success,TResult? Function( BookingDetailsError value)?  error,}){
final _that = this;
switch (_that) {
case BookingDetailsInitial() when initial != null:
return initial(_that);case BookingDetailsLoading() when loading != null:
return loading(_that);case BookingDetailsSuccess() when success != null:
return success(_that);case BookingDetailsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( PlayerBookingDetailModel booking)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BookingDetailsInitial() when initial != null:
return initial();case BookingDetailsLoading() when loading != null:
return loading();case BookingDetailsSuccess() when success != null:
return success(_that.booking);case BookingDetailsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( PlayerBookingDetailModel booking)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case BookingDetailsInitial():
return initial();case BookingDetailsLoading():
return loading();case BookingDetailsSuccess():
return success(_that.booking);case BookingDetailsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( PlayerBookingDetailModel booking)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case BookingDetailsInitial() when initial != null:
return initial();case BookingDetailsLoading() when loading != null:
return loading();case BookingDetailsSuccess() when success != null:
return success(_that.booking);case BookingDetailsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class BookingDetailsInitial implements BookingDetailsState {
  const BookingDetailsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingDetailsState.initial()';
}


}




/// @nodoc


class BookingDetailsLoading implements BookingDetailsState {
  const BookingDetailsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingDetailsState.loading()';
}


}




/// @nodoc


class BookingDetailsSuccess implements BookingDetailsState {
  const BookingDetailsSuccess(this.booking);
  

 final  PlayerBookingDetailModel booking;

/// Create a copy of BookingDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDetailsSuccessCopyWith<BookingDetailsSuccess> get copyWith => _$BookingDetailsSuccessCopyWithImpl<BookingDetailsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsSuccess&&(identical(other.booking, booking) || other.booking == booking));
}


@override
int get hashCode => Object.hash(runtimeType,booking);

@override
String toString() {
  return 'BookingDetailsState.success(booking: $booking)';
}


}

/// @nodoc
abstract mixin class $BookingDetailsSuccessCopyWith<$Res> implements $BookingDetailsStateCopyWith<$Res> {
  factory $BookingDetailsSuccessCopyWith(BookingDetailsSuccess value, $Res Function(BookingDetailsSuccess) _then) = _$BookingDetailsSuccessCopyWithImpl;
@useResult
$Res call({
 PlayerBookingDetailModel booking
});




}
/// @nodoc
class _$BookingDetailsSuccessCopyWithImpl<$Res>
    implements $BookingDetailsSuccessCopyWith<$Res> {
  _$BookingDetailsSuccessCopyWithImpl(this._self, this._then);

  final BookingDetailsSuccess _self;
  final $Res Function(BookingDetailsSuccess) _then;

/// Create a copy of BookingDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? booking = null,}) {
  return _then(BookingDetailsSuccess(
null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as PlayerBookingDetailModel,
  ));
}


}

/// @nodoc


class BookingDetailsError implements BookingDetailsState {
  const BookingDetailsError(this.message);
  

 final  String message;

/// Create a copy of BookingDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDetailsErrorCopyWith<BookingDetailsError> get copyWith => _$BookingDetailsErrorCopyWithImpl<BookingDetailsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BookingDetailsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $BookingDetailsErrorCopyWith<$Res> implements $BookingDetailsStateCopyWith<$Res> {
  factory $BookingDetailsErrorCopyWith(BookingDetailsError value, $Res Function(BookingDetailsError) _then) = _$BookingDetailsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$BookingDetailsErrorCopyWithImpl<$Res>
    implements $BookingDetailsErrorCopyWith<$Res> {
  _$BookingDetailsErrorCopyWithImpl(this._self, this._then);

  final BookingDetailsError _self;
  final $Res Function(BookingDetailsError) _then;

/// Create a copy of BookingDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(BookingDetailsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
