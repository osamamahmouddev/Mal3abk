// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owner_login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OwnerLoginState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerLoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OwnerLoginState()';
}


}

/// @nodoc
class $OwnerLoginStateCopyWith<$Res>  {
$OwnerLoginStateCopyWith(OwnerLoginState _, $Res Function(OwnerLoginState) __);
}


/// Adds pattern-matching-related methods to [OwnerLoginState].
extension OwnerLoginStatePatterns on OwnerLoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OwnerLoginInitial value)?  initial,TResult Function( OwnerLoginLoading value)?  loading,TResult Function( OwnerLoginTotpRequired value)?  totpRequired,TResult Function( OwnerLoginSuccess value)?  success,TResult Function( OwnerLoginError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OwnerLoginInitial() when initial != null:
return initial(_that);case OwnerLoginLoading() when loading != null:
return loading(_that);case OwnerLoginTotpRequired() when totpRequired != null:
return totpRequired(_that);case OwnerLoginSuccess() when success != null:
return success(_that);case OwnerLoginError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OwnerLoginInitial value)  initial,required TResult Function( OwnerLoginLoading value)  loading,required TResult Function( OwnerLoginTotpRequired value)  totpRequired,required TResult Function( OwnerLoginSuccess value)  success,required TResult Function( OwnerLoginError value)  error,}){
final _that = this;
switch (_that) {
case OwnerLoginInitial():
return initial(_that);case OwnerLoginLoading():
return loading(_that);case OwnerLoginTotpRequired():
return totpRequired(_that);case OwnerLoginSuccess():
return success(_that);case OwnerLoginError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OwnerLoginInitial value)?  initial,TResult? Function( OwnerLoginLoading value)?  loading,TResult? Function( OwnerLoginTotpRequired value)?  totpRequired,TResult? Function( OwnerLoginSuccess value)?  success,TResult? Function( OwnerLoginError value)?  error,}){
final _that = this;
switch (_that) {
case OwnerLoginInitial() when initial != null:
return initial(_that);case OwnerLoginLoading() when loading != null:
return loading(_that);case OwnerLoginTotpRequired() when totpRequired != null:
return totpRequired(_that);case OwnerLoginSuccess() when success != null:
return success(_that);case OwnerLoginError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  totpRequired,TResult Function()?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OwnerLoginInitial() when initial != null:
return initial();case OwnerLoginLoading() when loading != null:
return loading();case OwnerLoginTotpRequired() when totpRequired != null:
return totpRequired();case OwnerLoginSuccess() when success != null:
return success();case OwnerLoginError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  totpRequired,required TResult Function()  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case OwnerLoginInitial():
return initial();case OwnerLoginLoading():
return loading();case OwnerLoginTotpRequired():
return totpRequired();case OwnerLoginSuccess():
return success();case OwnerLoginError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  totpRequired,TResult? Function()?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case OwnerLoginInitial() when initial != null:
return initial();case OwnerLoginLoading() when loading != null:
return loading();case OwnerLoginTotpRequired() when totpRequired != null:
return totpRequired();case OwnerLoginSuccess() when success != null:
return success();case OwnerLoginError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class OwnerLoginInitial implements OwnerLoginState {
  const OwnerLoginInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerLoginInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OwnerLoginState.initial()';
}


}




/// @nodoc


class OwnerLoginLoading implements OwnerLoginState {
  const OwnerLoginLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerLoginLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OwnerLoginState.loading()';
}


}




/// @nodoc


class OwnerLoginTotpRequired implements OwnerLoginState {
  const OwnerLoginTotpRequired();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerLoginTotpRequired);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OwnerLoginState.totpRequired()';
}


}




/// @nodoc


class OwnerLoginSuccess implements OwnerLoginState {
  const OwnerLoginSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerLoginSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OwnerLoginState.success()';
}


}




/// @nodoc


class OwnerLoginError implements OwnerLoginState {
  const OwnerLoginError(this.message);
  

 final  String message;

/// Create a copy of OwnerLoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerLoginErrorCopyWith<OwnerLoginError> get copyWith => _$OwnerLoginErrorCopyWithImpl<OwnerLoginError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerLoginError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OwnerLoginState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $OwnerLoginErrorCopyWith<$Res> implements $OwnerLoginStateCopyWith<$Res> {
  factory $OwnerLoginErrorCopyWith(OwnerLoginError value, $Res Function(OwnerLoginError) _then) = _$OwnerLoginErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OwnerLoginErrorCopyWithImpl<$Res>
    implements $OwnerLoginErrorCopyWith<$Res> {
  _$OwnerLoginErrorCopyWithImpl(this._self, this._then);

  final OwnerLoginError _self;
  final $Res Function(OwnerLoginError) _then;

/// Create a copy of OwnerLoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OwnerLoginError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
