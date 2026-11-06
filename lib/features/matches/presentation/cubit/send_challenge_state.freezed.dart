// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_challenge_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SendChallengeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendChallengeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SendChallengeState()';
}


}

/// @nodoc
class $SendChallengeStateCopyWith<$Res>  {
$SendChallengeStateCopyWith(SendChallengeState _, $Res Function(SendChallengeState) __);
}


/// Adds pattern-matching-related methods to [SendChallengeState].
extension SendChallengeStatePatterns on SendChallengeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SendChallengeInitial value)?  initial,TResult Function( SendChallengeLoading value)?  loading,TResult Function( SendChallengeSuccess value)?  success,TResult Function( SendChallengeError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SendChallengeInitial() when initial != null:
return initial(_that);case SendChallengeLoading() when loading != null:
return loading(_that);case SendChallengeSuccess() when success != null:
return success(_that);case SendChallengeError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SendChallengeInitial value)  initial,required TResult Function( SendChallengeLoading value)  loading,required TResult Function( SendChallengeSuccess value)  success,required TResult Function( SendChallengeError value)  error,}){
final _that = this;
switch (_that) {
case SendChallengeInitial():
return initial(_that);case SendChallengeLoading():
return loading(_that);case SendChallengeSuccess():
return success(_that);case SendChallengeError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SendChallengeInitial value)?  initial,TResult? Function( SendChallengeLoading value)?  loading,TResult? Function( SendChallengeSuccess value)?  success,TResult? Function( SendChallengeError value)?  error,}){
final _that = this;
switch (_that) {
case SendChallengeInitial() when initial != null:
return initial(_that);case SendChallengeLoading() when loading != null:
return loading(_that);case SendChallengeSuccess() when success != null:
return success(_that);case SendChallengeError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( TeamChallengeModel challenge)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SendChallengeInitial() when initial != null:
return initial();case SendChallengeLoading() when loading != null:
return loading();case SendChallengeSuccess() when success != null:
return success(_that.challenge);case SendChallengeError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( TeamChallengeModel challenge)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case SendChallengeInitial():
return initial();case SendChallengeLoading():
return loading();case SendChallengeSuccess():
return success(_that.challenge);case SendChallengeError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( TeamChallengeModel challenge)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case SendChallengeInitial() when initial != null:
return initial();case SendChallengeLoading() when loading != null:
return loading();case SendChallengeSuccess() when success != null:
return success(_that.challenge);case SendChallengeError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SendChallengeInitial implements SendChallengeState {
  const SendChallengeInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendChallengeInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SendChallengeState.initial()';
}


}




/// @nodoc


class SendChallengeLoading implements SendChallengeState {
  const SendChallengeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendChallengeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SendChallengeState.loading()';
}


}




/// @nodoc


class SendChallengeSuccess implements SendChallengeState {
  const SendChallengeSuccess(this.challenge);
  

 final  TeamChallengeModel challenge;

/// Create a copy of SendChallengeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendChallengeSuccessCopyWith<SendChallengeSuccess> get copyWith => _$SendChallengeSuccessCopyWithImpl<SendChallengeSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendChallengeSuccess&&(identical(other.challenge, challenge) || other.challenge == challenge));
}


@override
int get hashCode => Object.hash(runtimeType,challenge);

@override
String toString() {
  return 'SendChallengeState.success(challenge: $challenge)';
}


}

/// @nodoc
abstract mixin class $SendChallengeSuccessCopyWith<$Res> implements $SendChallengeStateCopyWith<$Res> {
  factory $SendChallengeSuccessCopyWith(SendChallengeSuccess value, $Res Function(SendChallengeSuccess) _then) = _$SendChallengeSuccessCopyWithImpl;
@useResult
$Res call({
 TeamChallengeModel challenge
});




}
/// @nodoc
class _$SendChallengeSuccessCopyWithImpl<$Res>
    implements $SendChallengeSuccessCopyWith<$Res> {
  _$SendChallengeSuccessCopyWithImpl(this._self, this._then);

  final SendChallengeSuccess _self;
  final $Res Function(SendChallengeSuccess) _then;

/// Create a copy of SendChallengeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? challenge = null,}) {
  return _then(SendChallengeSuccess(
null == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as TeamChallengeModel,
  ));
}


}

/// @nodoc


class SendChallengeError implements SendChallengeState {
  const SendChallengeError(this.message);
  

 final  String message;

/// Create a copy of SendChallengeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendChallengeErrorCopyWith<SendChallengeError> get copyWith => _$SendChallengeErrorCopyWithImpl<SendChallengeError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendChallengeError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SendChallengeState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SendChallengeErrorCopyWith<$Res> implements $SendChallengeStateCopyWith<$Res> {
  factory $SendChallengeErrorCopyWith(SendChallengeError value, $Res Function(SendChallengeError) _then) = _$SendChallengeErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SendChallengeErrorCopyWithImpl<$Res>
    implements $SendChallengeErrorCopyWith<$Res> {
  _$SendChallengeErrorCopyWithImpl(this._self, this._then);

  final SendChallengeError _self;
  final $Res Function(SendChallengeError) _then;

/// Create a copy of SendChallengeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SendChallengeError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
