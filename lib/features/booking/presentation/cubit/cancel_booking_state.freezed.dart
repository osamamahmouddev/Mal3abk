// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cancel_booking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CancelBookingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelBookingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CancelBookingState()';
}


}

/// @nodoc
class $CancelBookingStateCopyWith<$Res>  {
$CancelBookingStateCopyWith(CancelBookingState _, $Res Function(CancelBookingState) __);
}


/// Adds pattern-matching-related methods to [CancelBookingState].
extension CancelBookingStatePatterns on CancelBookingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CancelBookingLoading value)?  loading,TResult Function( CancelBookingReady value)?  ready,TResult Function( CancelBookingCancelled value)?  cancelled,TResult Function( CancelBookingError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CancelBookingLoading() when loading != null:
return loading(_that);case CancelBookingReady() when ready != null:
return ready(_that);case CancelBookingCancelled() when cancelled != null:
return cancelled(_that);case CancelBookingError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CancelBookingLoading value)  loading,required TResult Function( CancelBookingReady value)  ready,required TResult Function( CancelBookingCancelled value)  cancelled,required TResult Function( CancelBookingError value)  error,}){
final _that = this;
switch (_that) {
case CancelBookingLoading():
return loading(_that);case CancelBookingReady():
return ready(_that);case CancelBookingCancelled():
return cancelled(_that);case CancelBookingError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CancelBookingLoading value)?  loading,TResult? Function( CancelBookingReady value)?  ready,TResult? Function( CancelBookingCancelled value)?  cancelled,TResult? Function( CancelBookingError value)?  error,}){
final _that = this;
switch (_that) {
case CancelBookingLoading() when loading != null:
return loading(_that);case CancelBookingReady() when ready != null:
return ready(_that);case CancelBookingCancelled() when cancelled != null:
return cancelled(_that);case CancelBookingError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( CancelPreviewModel preview,  bool submitting,  String? failure)?  ready,TResult Function()?  cancelled,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CancelBookingLoading() when loading != null:
return loading();case CancelBookingReady() when ready != null:
return ready(_that.preview,_that.submitting,_that.failure);case CancelBookingCancelled() when cancelled != null:
return cancelled();case CancelBookingError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( CancelPreviewModel preview,  bool submitting,  String? failure)  ready,required TResult Function()  cancelled,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case CancelBookingLoading():
return loading();case CancelBookingReady():
return ready(_that.preview,_that.submitting,_that.failure);case CancelBookingCancelled():
return cancelled();case CancelBookingError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( CancelPreviewModel preview,  bool submitting,  String? failure)?  ready,TResult? Function()?  cancelled,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case CancelBookingLoading() when loading != null:
return loading();case CancelBookingReady() when ready != null:
return ready(_that.preview,_that.submitting,_that.failure);case CancelBookingCancelled() when cancelled != null:
return cancelled();case CancelBookingError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CancelBookingLoading implements CancelBookingState {
  const CancelBookingLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelBookingLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CancelBookingState.loading()';
}


}




/// @nodoc


class CancelBookingReady implements CancelBookingState {
  const CancelBookingReady(this.preview, {this.submitting = false, this.failure});
  

 final  CancelPreviewModel preview;
@JsonKey() final  bool submitting;
 final  String? failure;

/// Create a copy of CancelBookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CancelBookingReadyCopyWith<CancelBookingReady> get copyWith => _$CancelBookingReadyCopyWithImpl<CancelBookingReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelBookingReady&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.submitting, submitting) || other.submitting == submitting)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,preview,submitting,failure);

@override
String toString() {
  return 'CancelBookingState.ready(preview: $preview, submitting: $submitting, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $CancelBookingReadyCopyWith<$Res> implements $CancelBookingStateCopyWith<$Res> {
  factory $CancelBookingReadyCopyWith(CancelBookingReady value, $Res Function(CancelBookingReady) _then) = _$CancelBookingReadyCopyWithImpl;
@useResult
$Res call({
 CancelPreviewModel preview, bool submitting, String? failure
});




}
/// @nodoc
class _$CancelBookingReadyCopyWithImpl<$Res>
    implements $CancelBookingReadyCopyWith<$Res> {
  _$CancelBookingReadyCopyWithImpl(this._self, this._then);

  final CancelBookingReady _self;
  final $Res Function(CancelBookingReady) _then;

/// Create a copy of CancelBookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? preview = null,Object? submitting = null,Object? failure = freezed,}) {
  return _then(CancelBookingReady(
null == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as CancelPreviewModel,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class CancelBookingCancelled implements CancelBookingState {
  const CancelBookingCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelBookingCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CancelBookingState.cancelled()';
}


}




/// @nodoc


class CancelBookingError implements CancelBookingState {
  const CancelBookingError(this.message);
  

 final  String message;

/// Create a copy of CancelBookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CancelBookingErrorCopyWith<CancelBookingError> get copyWith => _$CancelBookingErrorCopyWithImpl<CancelBookingError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelBookingError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CancelBookingState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CancelBookingErrorCopyWith<$Res> implements $CancelBookingStateCopyWith<$Res> {
  factory $CancelBookingErrorCopyWith(CancelBookingError value, $Res Function(CancelBookingError) _then) = _$CancelBookingErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CancelBookingErrorCopyWithImpl<$Res>
    implements $CancelBookingErrorCopyWith<$Res> {
  _$CancelBookingErrorCopyWithImpl(this._self, this._then);

  final CancelBookingError _self;
  final $Res Function(CancelBookingError) _then;

/// Create a copy of CancelBookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CancelBookingError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
