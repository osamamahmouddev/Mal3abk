// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pay_commission_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PayCommissionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayCommissionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PayCommissionState()';
}


}

/// @nodoc
class $PayCommissionStateCopyWith<$Res>  {
$PayCommissionStateCopyWith(PayCommissionState _, $Res Function(PayCommissionState) __);
}


/// Adds pattern-matching-related methods to [PayCommissionState].
extension PayCommissionStatePatterns on PayCommissionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PayCommissionInitial value)?  initial,TResult Function( PayCommissionLoading value)?  loading,TResult Function( PayCommissionSuccess value)?  success,TResult Function( PayCommissionError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PayCommissionInitial() when initial != null:
return initial(_that);case PayCommissionLoading() when loading != null:
return loading(_that);case PayCommissionSuccess() when success != null:
return success(_that);case PayCommissionError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PayCommissionInitial value)  initial,required TResult Function( PayCommissionLoading value)  loading,required TResult Function( PayCommissionSuccess value)  success,required TResult Function( PayCommissionError value)  error,}){
final _that = this;
switch (_that) {
case PayCommissionInitial():
return initial(_that);case PayCommissionLoading():
return loading(_that);case PayCommissionSuccess():
return success(_that);case PayCommissionError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PayCommissionInitial value)?  initial,TResult? Function( PayCommissionLoading value)?  loading,TResult? Function( PayCommissionSuccess value)?  success,TResult? Function( PayCommissionError value)?  error,}){
final _that = this;
switch (_that) {
case PayCommissionInitial() when initial != null:
return initial(_that);case PayCommissionLoading() when loading != null:
return loading(_that);case PayCommissionSuccess() when success != null:
return success(_that);case PayCommissionError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String checkoutUrl)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PayCommissionInitial() when initial != null:
return initial();case PayCommissionLoading() when loading != null:
return loading();case PayCommissionSuccess() when success != null:
return success(_that.checkoutUrl);case PayCommissionError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String checkoutUrl)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case PayCommissionInitial():
return initial();case PayCommissionLoading():
return loading();case PayCommissionSuccess():
return success(_that.checkoutUrl);case PayCommissionError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String checkoutUrl)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case PayCommissionInitial() when initial != null:
return initial();case PayCommissionLoading() when loading != null:
return loading();case PayCommissionSuccess() when success != null:
return success(_that.checkoutUrl);case PayCommissionError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class PayCommissionInitial implements PayCommissionState {
  const PayCommissionInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayCommissionInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PayCommissionState.initial()';
}


}




/// @nodoc


class PayCommissionLoading implements PayCommissionState {
  const PayCommissionLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayCommissionLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PayCommissionState.loading()';
}


}




/// @nodoc


class PayCommissionSuccess implements PayCommissionState {
  const PayCommissionSuccess(this.checkoutUrl);
  

 final  String checkoutUrl;

/// Create a copy of PayCommissionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayCommissionSuccessCopyWith<PayCommissionSuccess> get copyWith => _$PayCommissionSuccessCopyWithImpl<PayCommissionSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayCommissionSuccess&&(identical(other.checkoutUrl, checkoutUrl) || other.checkoutUrl == checkoutUrl));
}


@override
int get hashCode => Object.hash(runtimeType,checkoutUrl);

@override
String toString() {
  return 'PayCommissionState.success(checkoutUrl: $checkoutUrl)';
}


}

/// @nodoc
abstract mixin class $PayCommissionSuccessCopyWith<$Res> implements $PayCommissionStateCopyWith<$Res> {
  factory $PayCommissionSuccessCopyWith(PayCommissionSuccess value, $Res Function(PayCommissionSuccess) _then) = _$PayCommissionSuccessCopyWithImpl;
@useResult
$Res call({
 String checkoutUrl
});




}
/// @nodoc
class _$PayCommissionSuccessCopyWithImpl<$Res>
    implements $PayCommissionSuccessCopyWith<$Res> {
  _$PayCommissionSuccessCopyWithImpl(this._self, this._then);

  final PayCommissionSuccess _self;
  final $Res Function(PayCommissionSuccess) _then;

/// Create a copy of PayCommissionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? checkoutUrl = null,}) {
  return _then(PayCommissionSuccess(
null == checkoutUrl ? _self.checkoutUrl : checkoutUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PayCommissionError implements PayCommissionState {
  const PayCommissionError(this.message);
  

 final  String message;

/// Create a copy of PayCommissionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayCommissionErrorCopyWith<PayCommissionError> get copyWith => _$PayCommissionErrorCopyWithImpl<PayCommissionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayCommissionError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PayCommissionState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $PayCommissionErrorCopyWith<$Res> implements $PayCommissionStateCopyWith<$Res> {
  factory $PayCommissionErrorCopyWith(PayCommissionError value, $Res Function(PayCommissionError) _then) = _$PayCommissionErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PayCommissionErrorCopyWithImpl<$Res>
    implements $PayCommissionErrorCopyWith<$Res> {
  _$PayCommissionErrorCopyWithImpl(this._self, this._then);

  final PayCommissionError _self;
  final $Res Function(PayCommissionError) _then;

/// Create a copy of PayCommissionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PayCommissionError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
