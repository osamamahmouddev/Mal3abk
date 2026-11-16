// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_otp_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SendOtpState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendOtpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SendOtpState()';
}


}

/// @nodoc
class $SendOtpStateCopyWith<$Res>  {
$SendOtpStateCopyWith(SendOtpState _, $Res Function(SendOtpState) __);
}


/// Adds pattern-matching-related methods to [SendOtpState].
extension SendOtpStatePatterns on SendOtpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SendOtpInitial value)?  initial,TResult Function( SendOtpLoading value)?  loading,TResult Function( SendOtpSuccess value)?  success,TResult Function( SendOtpError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SendOtpInitial() when initial != null:
return initial(_that);case SendOtpLoading() when loading != null:
return loading(_that);case SendOtpSuccess() when success != null:
return success(_that);case SendOtpError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SendOtpInitial value)  initial,required TResult Function( SendOtpLoading value)  loading,required TResult Function( SendOtpSuccess value)  success,required TResult Function( SendOtpError value)  error,}){
final _that = this;
switch (_that) {
case SendOtpInitial():
return initial(_that);case SendOtpLoading():
return loading(_that);case SendOtpSuccess():
return success(_that);case SendOtpError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SendOtpInitial value)?  initial,TResult? Function( SendOtpLoading value)?  loading,TResult? Function( SendOtpSuccess value)?  success,TResult? Function( SendOtpError value)?  error,}){
final _that = this;
switch (_that) {
case SendOtpInitial() when initial != null:
return initial(_that);case SendOtpLoading() when loading != null:
return loading(_that);case SendOtpSuccess() when success != null:
return success(_that);case SendOtpError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( SendOtpResponseModel data,  int sendCount,  bool resending,  String? resendError,  DateTime? resendBlockedUntil,  String? verificationId,  int? resendToken,  PhoneAuthCredential? autoCredential)?  success,TResult Function( String message,  DateTime? retryAt)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SendOtpInitial() when initial != null:
return initial();case SendOtpLoading() when loading != null:
return loading();case SendOtpSuccess() when success != null:
return success(_that.data,_that.sendCount,_that.resending,_that.resendError,_that.resendBlockedUntil,_that.verificationId,_that.resendToken,_that.autoCredential);case SendOtpError() when error != null:
return error(_that.message,_that.retryAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( SendOtpResponseModel data,  int sendCount,  bool resending,  String? resendError,  DateTime? resendBlockedUntil,  String? verificationId,  int? resendToken,  PhoneAuthCredential? autoCredential)  success,required TResult Function( String message,  DateTime? retryAt)  error,}) {final _that = this;
switch (_that) {
case SendOtpInitial():
return initial();case SendOtpLoading():
return loading();case SendOtpSuccess():
return success(_that.data,_that.sendCount,_that.resending,_that.resendError,_that.resendBlockedUntil,_that.verificationId,_that.resendToken,_that.autoCredential);case SendOtpError():
return error(_that.message,_that.retryAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( SendOtpResponseModel data,  int sendCount,  bool resending,  String? resendError,  DateTime? resendBlockedUntil,  String? verificationId,  int? resendToken,  PhoneAuthCredential? autoCredential)?  success,TResult? Function( String message,  DateTime? retryAt)?  error,}) {final _that = this;
switch (_that) {
case SendOtpInitial() when initial != null:
return initial();case SendOtpLoading() when loading != null:
return loading();case SendOtpSuccess() when success != null:
return success(_that.data,_that.sendCount,_that.resending,_that.resendError,_that.resendBlockedUntil,_that.verificationId,_that.resendToken,_that.autoCredential);case SendOtpError() when error != null:
return error(_that.message,_that.retryAt);case _:
  return null;

}
}

}

/// @nodoc


class SendOtpInitial implements SendOtpState {
  const SendOtpInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendOtpInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SendOtpState.initial()';
}


}




/// @nodoc


class SendOtpLoading implements SendOtpState {
  const SendOtpLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendOtpLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SendOtpState.loading()';
}


}




/// @nodoc


class SendOtpSuccess implements SendOtpState {
  const SendOtpSuccess(this.data, {this.sendCount = 1, this.resending = false, this.resendError, this.resendBlockedUntil, this.verificationId, this.resendToken, this.autoCredential});
  

 final  SendOtpResponseModel data;
@JsonKey() final  int sendCount;
@JsonKey() final  bool resending;
 final  String? resendError;
 final  DateTime? resendBlockedUntil;
 final  String? verificationId;
 final  int? resendToken;
 final  PhoneAuthCredential? autoCredential;

/// Create a copy of SendOtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendOtpSuccessCopyWith<SendOtpSuccess> get copyWith => _$SendOtpSuccessCopyWithImpl<SendOtpSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendOtpSuccess&&(identical(other.data, data) || other.data == data)&&(identical(other.sendCount, sendCount) || other.sendCount == sendCount)&&(identical(other.resending, resending) || other.resending == resending)&&(identical(other.resendError, resendError) || other.resendError == resendError)&&(identical(other.resendBlockedUntil, resendBlockedUntil) || other.resendBlockedUntil == resendBlockedUntil)&&(identical(other.verificationId, verificationId) || other.verificationId == verificationId)&&(identical(other.resendToken, resendToken) || other.resendToken == resendToken)&&(identical(other.autoCredential, autoCredential) || other.autoCredential == autoCredential));
}


@override
int get hashCode => Object.hash(runtimeType,data,sendCount,resending,resendError,resendBlockedUntil,verificationId,resendToken,autoCredential);

@override
String toString() {
  return 'SendOtpState.success(data: $data, sendCount: $sendCount, resending: $resending, resendError: $resendError, resendBlockedUntil: $resendBlockedUntil, verificationId: $verificationId, resendToken: $resendToken, autoCredential: $autoCredential)';
}


}

/// @nodoc
abstract mixin class $SendOtpSuccessCopyWith<$Res> implements $SendOtpStateCopyWith<$Res> {
  factory $SendOtpSuccessCopyWith(SendOtpSuccess value, $Res Function(SendOtpSuccess) _then) = _$SendOtpSuccessCopyWithImpl;
@useResult
$Res call({
 SendOtpResponseModel data, int sendCount, bool resending, String? resendError, DateTime? resendBlockedUntil, String? verificationId, int? resendToken, PhoneAuthCredential? autoCredential
});




}
/// @nodoc
class _$SendOtpSuccessCopyWithImpl<$Res>
    implements $SendOtpSuccessCopyWith<$Res> {
  _$SendOtpSuccessCopyWithImpl(this._self, this._then);

  final SendOtpSuccess _self;
  final $Res Function(SendOtpSuccess) _then;

/// Create a copy of SendOtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? sendCount = null,Object? resending = null,Object? resendError = freezed,Object? resendBlockedUntil = freezed,Object? verificationId = freezed,Object? resendToken = freezed,Object? autoCredential = freezed,}) {
  return _then(SendOtpSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SendOtpResponseModel,sendCount: null == sendCount ? _self.sendCount : sendCount // ignore: cast_nullable_to_non_nullable
as int,resending: null == resending ? _self.resending : resending // ignore: cast_nullable_to_non_nullable
as bool,resendError: freezed == resendError ? _self.resendError : resendError // ignore: cast_nullable_to_non_nullable
as String?,resendBlockedUntil: freezed == resendBlockedUntil ? _self.resendBlockedUntil : resendBlockedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,verificationId: freezed == verificationId ? _self.verificationId : verificationId // ignore: cast_nullable_to_non_nullable
as String?,resendToken: freezed == resendToken ? _self.resendToken : resendToken // ignore: cast_nullable_to_non_nullable
as int?,autoCredential: freezed == autoCredential ? _self.autoCredential : autoCredential // ignore: cast_nullable_to_non_nullable
as PhoneAuthCredential?,
  ));
}


}

/// @nodoc


class SendOtpError implements SendOtpState {
  const SendOtpError(this.message, {this.retryAt});
  

 final  String message;
 final  DateTime? retryAt;

/// Create a copy of SendOtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendOtpErrorCopyWith<SendOtpError> get copyWith => _$SendOtpErrorCopyWithImpl<SendOtpError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendOtpError&&(identical(other.message, message) || other.message == message)&&(identical(other.retryAt, retryAt) || other.retryAt == retryAt));
}


@override
int get hashCode => Object.hash(runtimeType,message,retryAt);

@override
String toString() {
  return 'SendOtpState.error(message: $message, retryAt: $retryAt)';
}


}

/// @nodoc
abstract mixin class $SendOtpErrorCopyWith<$Res> implements $SendOtpStateCopyWith<$Res> {
  factory $SendOtpErrorCopyWith(SendOtpError value, $Res Function(SendOtpError) _then) = _$SendOtpErrorCopyWithImpl;
@useResult
$Res call({
 String message, DateTime? retryAt
});




}
/// @nodoc
class _$SendOtpErrorCopyWithImpl<$Res>
    implements $SendOtpErrorCopyWith<$Res> {
  _$SendOtpErrorCopyWithImpl(this._self, this._then);

  final SendOtpError _self;
  final $Res Function(SendOtpError) _then;

/// Create a copy of SendOtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? retryAt = freezed,}) {
  return _then(SendOtpError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,retryAt: freezed == retryAt ? _self.retryAt : retryAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
