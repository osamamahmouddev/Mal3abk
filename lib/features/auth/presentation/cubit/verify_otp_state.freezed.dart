// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerifyOtpState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyOtpState()';
}


}

/// @nodoc
class $VerifyOtpStateCopyWith<$Res>  {
$VerifyOtpStateCopyWith(VerifyOtpState _, $Res Function(VerifyOtpState) __);
}


/// Adds pattern-matching-related methods to [VerifyOtpState].
extension VerifyOtpStatePatterns on VerifyOtpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VerifyOtpInitial value)?  initial,TResult Function( VerifyOtpLoading value)?  loading,TResult Function( VerifyOtpSuccess value)?  success,TResult Function( VerifyOtpError value)?  error,TResult Function( VerifyOtpAccountPendingDeletion value)?  accountPendingDeletion,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VerifyOtpInitial() when initial != null:
return initial(_that);case VerifyOtpLoading() when loading != null:
return loading(_that);case VerifyOtpSuccess() when success != null:
return success(_that);case VerifyOtpError() when error != null:
return error(_that);case VerifyOtpAccountPendingDeletion() when accountPendingDeletion != null:
return accountPendingDeletion(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VerifyOtpInitial value)  initial,required TResult Function( VerifyOtpLoading value)  loading,required TResult Function( VerifyOtpSuccess value)  success,required TResult Function( VerifyOtpError value)  error,required TResult Function( VerifyOtpAccountPendingDeletion value)  accountPendingDeletion,}){
final _that = this;
switch (_that) {
case VerifyOtpInitial():
return initial(_that);case VerifyOtpLoading():
return loading(_that);case VerifyOtpSuccess():
return success(_that);case VerifyOtpError():
return error(_that);case VerifyOtpAccountPendingDeletion():
return accountPendingDeletion(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VerifyOtpInitial value)?  initial,TResult? Function( VerifyOtpLoading value)?  loading,TResult? Function( VerifyOtpSuccess value)?  success,TResult? Function( VerifyOtpError value)?  error,TResult? Function( VerifyOtpAccountPendingDeletion value)?  accountPendingDeletion,}){
final _that = this;
switch (_that) {
case VerifyOtpInitial() when initial != null:
return initial(_that);case VerifyOtpLoading() when loading != null:
return loading(_that);case VerifyOtpSuccess() when success != null:
return success(_that);case VerifyOtpError() when error != null:
return error(_that);case VerifyOtpAccountPendingDeletion() when accountPendingDeletion != null:
return accountPendingDeletion(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( VerifyOtpResponseModel data)?  success,TResult Function( String message)?  error,TResult Function()?  accountPendingDeletion,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VerifyOtpInitial() when initial != null:
return initial();case VerifyOtpLoading() when loading != null:
return loading();case VerifyOtpSuccess() when success != null:
return success(_that.data);case VerifyOtpError() when error != null:
return error(_that.message);case VerifyOtpAccountPendingDeletion() when accountPendingDeletion != null:
return accountPendingDeletion();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( VerifyOtpResponseModel data)  success,required TResult Function( String message)  error,required TResult Function()  accountPendingDeletion,}) {final _that = this;
switch (_that) {
case VerifyOtpInitial():
return initial();case VerifyOtpLoading():
return loading();case VerifyOtpSuccess():
return success(_that.data);case VerifyOtpError():
return error(_that.message);case VerifyOtpAccountPendingDeletion():
return accountPendingDeletion();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( VerifyOtpResponseModel data)?  success,TResult? Function( String message)?  error,TResult? Function()?  accountPendingDeletion,}) {final _that = this;
switch (_that) {
case VerifyOtpInitial() when initial != null:
return initial();case VerifyOtpLoading() when loading != null:
return loading();case VerifyOtpSuccess() when success != null:
return success(_that.data);case VerifyOtpError() when error != null:
return error(_that.message);case VerifyOtpAccountPendingDeletion() when accountPendingDeletion != null:
return accountPendingDeletion();case _:
  return null;

}
}

}

/// @nodoc


class VerifyOtpInitial implements VerifyOtpState {
  const VerifyOtpInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyOtpState.initial()';
}


}




/// @nodoc


class VerifyOtpLoading implements VerifyOtpState {
  const VerifyOtpLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyOtpState.loading()';
}


}




/// @nodoc


class VerifyOtpSuccess implements VerifyOtpState {
  const VerifyOtpSuccess(this.data);
  

 final  VerifyOtpResponseModel data;

/// Create a copy of VerifyOtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpSuccessCopyWith<VerifyOtpSuccess> get copyWith => _$VerifyOtpSuccessCopyWithImpl<VerifyOtpSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'VerifyOtpState.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpSuccessCopyWith<$Res> implements $VerifyOtpStateCopyWith<$Res> {
  factory $VerifyOtpSuccessCopyWith(VerifyOtpSuccess value, $Res Function(VerifyOtpSuccess) _then) = _$VerifyOtpSuccessCopyWithImpl;
@useResult
$Res call({
 VerifyOtpResponseModel data
});




}
/// @nodoc
class _$VerifyOtpSuccessCopyWithImpl<$Res>
    implements $VerifyOtpSuccessCopyWith<$Res> {
  _$VerifyOtpSuccessCopyWithImpl(this._self, this._then);

  final VerifyOtpSuccess _self;
  final $Res Function(VerifyOtpSuccess) _then;

/// Create a copy of VerifyOtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(VerifyOtpSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as VerifyOtpResponseModel,
  ));
}


}

/// @nodoc


class VerifyOtpError implements VerifyOtpState {
  const VerifyOtpError(this.message);
  

 final  String message;

/// Create a copy of VerifyOtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpErrorCopyWith<VerifyOtpError> get copyWith => _$VerifyOtpErrorCopyWithImpl<VerifyOtpError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'VerifyOtpState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpErrorCopyWith<$Res> implements $VerifyOtpStateCopyWith<$Res> {
  factory $VerifyOtpErrorCopyWith(VerifyOtpError value, $Res Function(VerifyOtpError) _then) = _$VerifyOtpErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$VerifyOtpErrorCopyWithImpl<$Res>
    implements $VerifyOtpErrorCopyWith<$Res> {
  _$VerifyOtpErrorCopyWithImpl(this._self, this._then);

  final VerifyOtpError _self;
  final $Res Function(VerifyOtpError) _then;

/// Create a copy of VerifyOtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(VerifyOtpError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VerifyOtpAccountPendingDeletion implements VerifyOtpState {
  const VerifyOtpAccountPendingDeletion();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpAccountPendingDeletion);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyOtpState.accountPendingDeletion()';
}


}




// dart format on
