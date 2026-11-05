// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChallengeResponseState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeResponseState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChallengeResponseState()';
}


}

/// @nodoc
class $ChallengeResponseStateCopyWith<$Res>  {
$ChallengeResponseStateCopyWith(ChallengeResponseState _, $Res Function(ChallengeResponseState) __);
}


/// Adds pattern-matching-related methods to [ChallengeResponseState].
extension ChallengeResponseStatePatterns on ChallengeResponseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChallengeResponseInitial value)?  initial,TResult Function( ChallengeResponseLoading value)?  loading,TResult Function( ChallengeResponseSuccess value)?  success,TResult Function( ChallengeResponseError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChallengeResponseInitial() when initial != null:
return initial(_that);case ChallengeResponseLoading() when loading != null:
return loading(_that);case ChallengeResponseSuccess() when success != null:
return success(_that);case ChallengeResponseError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChallengeResponseInitial value)  initial,required TResult Function( ChallengeResponseLoading value)  loading,required TResult Function( ChallengeResponseSuccess value)  success,required TResult Function( ChallengeResponseError value)  error,}){
final _that = this;
switch (_that) {
case ChallengeResponseInitial():
return initial(_that);case ChallengeResponseLoading():
return loading(_that);case ChallengeResponseSuccess():
return success(_that);case ChallengeResponseError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChallengeResponseInitial value)?  initial,TResult? Function( ChallengeResponseLoading value)?  loading,TResult? Function( ChallengeResponseSuccess value)?  success,TResult? Function( ChallengeResponseError value)?  error,}){
final _that = this;
switch (_that) {
case ChallengeResponseInitial() when initial != null:
return initial(_that);case ChallengeResponseLoading() when loading != null:
return loading(_that);case ChallengeResponseSuccess() when success != null:
return success(_that);case ChallengeResponseError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( TeamChallengeModel challenge,  ChallengeResponseAction action)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChallengeResponseInitial() when initial != null:
return initial();case ChallengeResponseLoading() when loading != null:
return loading();case ChallengeResponseSuccess() when success != null:
return success(_that.challenge,_that.action);case ChallengeResponseError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( TeamChallengeModel challenge,  ChallengeResponseAction action)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ChallengeResponseInitial():
return initial();case ChallengeResponseLoading():
return loading();case ChallengeResponseSuccess():
return success(_that.challenge,_that.action);case ChallengeResponseError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( TeamChallengeModel challenge,  ChallengeResponseAction action)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ChallengeResponseInitial() when initial != null:
return initial();case ChallengeResponseLoading() when loading != null:
return loading();case ChallengeResponseSuccess() when success != null:
return success(_that.challenge,_that.action);case ChallengeResponseError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ChallengeResponseInitial implements ChallengeResponseState {
  const ChallengeResponseInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeResponseInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChallengeResponseState.initial()';
}


}




/// @nodoc


class ChallengeResponseLoading implements ChallengeResponseState {
  const ChallengeResponseLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeResponseLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChallengeResponseState.loading()';
}


}




/// @nodoc


class ChallengeResponseSuccess implements ChallengeResponseState {
  const ChallengeResponseSuccess(this.challenge, this.action);
  

 final  TeamChallengeModel challenge;
 final  ChallengeResponseAction action;

/// Create a copy of ChallengeResponseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChallengeResponseSuccessCopyWith<ChallengeResponseSuccess> get copyWith => _$ChallengeResponseSuccessCopyWithImpl<ChallengeResponseSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeResponseSuccess&&(identical(other.challenge, challenge) || other.challenge == challenge)&&(identical(other.action, action) || other.action == action));
}


@override
int get hashCode => Object.hash(runtimeType,challenge,action);

@override
String toString() {
  return 'ChallengeResponseState.success(challenge: $challenge, action: $action)';
}


}

/// @nodoc
abstract mixin class $ChallengeResponseSuccessCopyWith<$Res> implements $ChallengeResponseStateCopyWith<$Res> {
  factory $ChallengeResponseSuccessCopyWith(ChallengeResponseSuccess value, $Res Function(ChallengeResponseSuccess) _then) = _$ChallengeResponseSuccessCopyWithImpl;
@useResult
$Res call({
 TeamChallengeModel challenge, ChallengeResponseAction action
});




}
/// @nodoc
class _$ChallengeResponseSuccessCopyWithImpl<$Res>
    implements $ChallengeResponseSuccessCopyWith<$Res> {
  _$ChallengeResponseSuccessCopyWithImpl(this._self, this._then);

  final ChallengeResponseSuccess _self;
  final $Res Function(ChallengeResponseSuccess) _then;

/// Create a copy of ChallengeResponseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? challenge = null,Object? action = null,}) {
  return _then(ChallengeResponseSuccess(
null == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as TeamChallengeModel,null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as ChallengeResponseAction,
  ));
}


}

/// @nodoc


class ChallengeResponseError implements ChallengeResponseState {
  const ChallengeResponseError(this.message);
  

 final  String message;

/// Create a copy of ChallengeResponseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChallengeResponseErrorCopyWith<ChallengeResponseError> get copyWith => _$ChallengeResponseErrorCopyWithImpl<ChallengeResponseError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeResponseError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ChallengeResponseState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ChallengeResponseErrorCopyWith<$Res> implements $ChallengeResponseStateCopyWith<$Res> {
  factory $ChallengeResponseErrorCopyWith(ChallengeResponseError value, $Res Function(ChallengeResponseError) _then) = _$ChallengeResponseErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ChallengeResponseErrorCopyWithImpl<$Res>
    implements $ChallengeResponseErrorCopyWith<$Res> {
  _$ChallengeResponseErrorCopyWithImpl(this._self, this._then);

  final ChallengeResponseError _self;
  final $Res Function(ChallengeResponseError) _then;

/// Create a copy of ChallengeResponseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ChallengeResponseError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
