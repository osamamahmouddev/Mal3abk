// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'step_up_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StepUpState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepUpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StepUpState()';
}


}

/// @nodoc
class $StepUpStateCopyWith<$Res>  {
$StepUpStateCopyWith(StepUpState _, $Res Function(StepUpState) __);
}


/// Adds pattern-matching-related methods to [StepUpState].
extension StepUpStatePatterns on StepUpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StepUpSending value)?  sending,TResult Function( StepUpCodeSent value)?  codeSent,TResult Function( StepUpVerifying value)?  verifying,TResult Function( StepUpVerified value)?  verified,TResult Function( StepUpError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StepUpSending() when sending != null:
return sending(_that);case StepUpCodeSent() when codeSent != null:
return codeSent(_that);case StepUpVerifying() when verifying != null:
return verifying(_that);case StepUpVerified() when verified != null:
return verified(_that);case StepUpError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StepUpSending value)  sending,required TResult Function( StepUpCodeSent value)  codeSent,required TResult Function( StepUpVerifying value)  verifying,required TResult Function( StepUpVerified value)  verified,required TResult Function( StepUpError value)  error,}){
final _that = this;
switch (_that) {
case StepUpSending():
return sending(_that);case StepUpCodeSent():
return codeSent(_that);case StepUpVerifying():
return verifying(_that);case StepUpVerified():
return verified(_that);case StepUpError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StepUpSending value)?  sending,TResult? Function( StepUpCodeSent value)?  codeSent,TResult? Function( StepUpVerifying value)?  verifying,TResult? Function( StepUpVerified value)?  verified,TResult? Function( StepUpError value)?  error,}){
final _that = this;
switch (_that) {
case StepUpSending() when sending != null:
return sending(_that);case StepUpCodeSent() when codeSent != null:
return codeSent(_that);case StepUpVerifying() when verifying != null:
return verifying(_that);case StepUpVerified() when verified != null:
return verified(_that);case StepUpError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  sending,TResult Function()?  codeSent,TResult Function()?  verifying,TResult Function( String token)?  verified,TResult Function( String message,  bool codeSent)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StepUpSending() when sending != null:
return sending();case StepUpCodeSent() when codeSent != null:
return codeSent();case StepUpVerifying() when verifying != null:
return verifying();case StepUpVerified() when verified != null:
return verified(_that.token);case StepUpError() when error != null:
return error(_that.message,_that.codeSent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  sending,required TResult Function()  codeSent,required TResult Function()  verifying,required TResult Function( String token)  verified,required TResult Function( String message,  bool codeSent)  error,}) {final _that = this;
switch (_that) {
case StepUpSending():
return sending();case StepUpCodeSent():
return codeSent();case StepUpVerifying():
return verifying();case StepUpVerified():
return verified(_that.token);case StepUpError():
return error(_that.message,_that.codeSent);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  sending,TResult? Function()?  codeSent,TResult? Function()?  verifying,TResult? Function( String token)?  verified,TResult? Function( String message,  bool codeSent)?  error,}) {final _that = this;
switch (_that) {
case StepUpSending() when sending != null:
return sending();case StepUpCodeSent() when codeSent != null:
return codeSent();case StepUpVerifying() when verifying != null:
return verifying();case StepUpVerified() when verified != null:
return verified(_that.token);case StepUpError() when error != null:
return error(_that.message,_that.codeSent);case _:
  return null;

}
}

}

/// @nodoc


class StepUpSending implements StepUpState {
  const StepUpSending();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepUpSending);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StepUpState.sending()';
}


}




/// @nodoc


class StepUpCodeSent implements StepUpState {
  const StepUpCodeSent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepUpCodeSent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StepUpState.codeSent()';
}


}




/// @nodoc


class StepUpVerifying implements StepUpState {
  const StepUpVerifying();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepUpVerifying);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StepUpState.verifying()';
}


}




/// @nodoc


class StepUpVerified implements StepUpState {
  const StepUpVerified(this.token);
  

 final  String token;

/// Create a copy of StepUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepUpVerifiedCopyWith<StepUpVerified> get copyWith => _$StepUpVerifiedCopyWithImpl<StepUpVerified>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepUpVerified&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'StepUpState.verified(token: $token)';
}


}

/// @nodoc
abstract mixin class $StepUpVerifiedCopyWith<$Res> implements $StepUpStateCopyWith<$Res> {
  factory $StepUpVerifiedCopyWith(StepUpVerified value, $Res Function(StepUpVerified) _then) = _$StepUpVerifiedCopyWithImpl;
@useResult
$Res call({
 String token
});




}
/// @nodoc
class _$StepUpVerifiedCopyWithImpl<$Res>
    implements $StepUpVerifiedCopyWith<$Res> {
  _$StepUpVerifiedCopyWithImpl(this._self, this._then);

  final StepUpVerified _self;
  final $Res Function(StepUpVerified) _then;

/// Create a copy of StepUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(StepUpVerified(
null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class StepUpError implements StepUpState {
  const StepUpError(this.message, {required this.codeSent});
  

 final  String message;
 final  bool codeSent;

/// Create a copy of StepUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepUpErrorCopyWith<StepUpError> get copyWith => _$StepUpErrorCopyWithImpl<StepUpError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepUpError&&(identical(other.message, message) || other.message == message)&&(identical(other.codeSent, codeSent) || other.codeSent == codeSent));
}


@override
int get hashCode => Object.hash(runtimeType,message,codeSent);

@override
String toString() {
  return 'StepUpState.error(message: $message, codeSent: $codeSent)';
}


}

/// @nodoc
abstract mixin class $StepUpErrorCopyWith<$Res> implements $StepUpStateCopyWith<$Res> {
  factory $StepUpErrorCopyWith(StepUpError value, $Res Function(StepUpError) _then) = _$StepUpErrorCopyWithImpl;
@useResult
$Res call({
 String message, bool codeSent
});




}
/// @nodoc
class _$StepUpErrorCopyWithImpl<$Res>
    implements $StepUpErrorCopyWith<$Res> {
  _$StepUpErrorCopyWithImpl(this._self, this._then);

  final StepUpError _self;
  final $Res Function(StepUpError) _then;

/// Create a copy of StepUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? codeSent = null,}) {
  return _then(StepUpError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,codeSent: null == codeSent ? _self.codeSent : codeSent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
