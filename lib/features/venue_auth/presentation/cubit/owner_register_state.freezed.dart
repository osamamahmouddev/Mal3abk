// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owner_register_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OwnerRegisterState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerRegisterState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OwnerRegisterState()';
}


}

/// @nodoc
class $OwnerRegisterStateCopyWith<$Res>  {
$OwnerRegisterStateCopyWith(OwnerRegisterState _, $Res Function(OwnerRegisterState) __);
}


/// Adds pattern-matching-related methods to [OwnerRegisterState].
extension OwnerRegisterStatePatterns on OwnerRegisterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OwnerRegisterInitial value)?  initial,TResult Function( OwnerRegisterLoading value)?  loading,TResult Function( OwnerRegisterSuccess value)?  success,TResult Function( OwnerRegisterError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OwnerRegisterInitial() when initial != null:
return initial(_that);case OwnerRegisterLoading() when loading != null:
return loading(_that);case OwnerRegisterSuccess() when success != null:
return success(_that);case OwnerRegisterError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OwnerRegisterInitial value)  initial,required TResult Function( OwnerRegisterLoading value)  loading,required TResult Function( OwnerRegisterSuccess value)  success,required TResult Function( OwnerRegisterError value)  error,}){
final _that = this;
switch (_that) {
case OwnerRegisterInitial():
return initial(_that);case OwnerRegisterLoading():
return loading(_that);case OwnerRegisterSuccess():
return success(_that);case OwnerRegisterError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OwnerRegisterInitial value)?  initial,TResult? Function( OwnerRegisterLoading value)?  loading,TResult? Function( OwnerRegisterSuccess value)?  success,TResult? Function( OwnerRegisterError value)?  error,}){
final _that = this;
switch (_that) {
case OwnerRegisterInitial() when initial != null:
return initial(_that);case OwnerRegisterLoading() when loading != null:
return loading(_that);case OwnerRegisterSuccess() when success != null:
return success(_that);case OwnerRegisterError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String email,  String phoneNumber,  bool resending,  bool resent)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OwnerRegisterInitial() when initial != null:
return initial();case OwnerRegisterLoading() when loading != null:
return loading();case OwnerRegisterSuccess() when success != null:
return success(_that.email,_that.phoneNumber,_that.resending,_that.resent);case OwnerRegisterError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String email,  String phoneNumber,  bool resending,  bool resent)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case OwnerRegisterInitial():
return initial();case OwnerRegisterLoading():
return loading();case OwnerRegisterSuccess():
return success(_that.email,_that.phoneNumber,_that.resending,_that.resent);case OwnerRegisterError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String email,  String phoneNumber,  bool resending,  bool resent)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case OwnerRegisterInitial() when initial != null:
return initial();case OwnerRegisterLoading() when loading != null:
return loading();case OwnerRegisterSuccess() when success != null:
return success(_that.email,_that.phoneNumber,_that.resending,_that.resent);case OwnerRegisterError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class OwnerRegisterInitial implements OwnerRegisterState {
  const OwnerRegisterInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerRegisterInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OwnerRegisterState.initial()';
}


}




/// @nodoc


class OwnerRegisterLoading implements OwnerRegisterState {
  const OwnerRegisterLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerRegisterLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OwnerRegisterState.loading()';
}


}




/// @nodoc


class OwnerRegisterSuccess implements OwnerRegisterState {
  const OwnerRegisterSuccess({required this.email, required this.phoneNumber, this.resending = false, this.resent = false});
  

 final  String email;
 final  String phoneNumber;
@JsonKey() final  bool resending;
@JsonKey() final  bool resent;

/// Create a copy of OwnerRegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerRegisterSuccessCopyWith<OwnerRegisterSuccess> get copyWith => _$OwnerRegisterSuccessCopyWithImpl<OwnerRegisterSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerRegisterSuccess&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.resending, resending) || other.resending == resending)&&(identical(other.resent, resent) || other.resent == resent));
}


@override
int get hashCode => Object.hash(runtimeType,email,phoneNumber,resending,resent);

@override
String toString() {
  return 'OwnerRegisterState.success(email: $email, phoneNumber: $phoneNumber, resending: $resending, resent: $resent)';
}


}

/// @nodoc
abstract mixin class $OwnerRegisterSuccessCopyWith<$Res> implements $OwnerRegisterStateCopyWith<$Res> {
  factory $OwnerRegisterSuccessCopyWith(OwnerRegisterSuccess value, $Res Function(OwnerRegisterSuccess) _then) = _$OwnerRegisterSuccessCopyWithImpl;
@useResult
$Res call({
 String email, String phoneNumber, bool resending, bool resent
});




}
/// @nodoc
class _$OwnerRegisterSuccessCopyWithImpl<$Res>
    implements $OwnerRegisterSuccessCopyWith<$Res> {
  _$OwnerRegisterSuccessCopyWithImpl(this._self, this._then);

  final OwnerRegisterSuccess _self;
  final $Res Function(OwnerRegisterSuccess) _then;

/// Create a copy of OwnerRegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? phoneNumber = null,Object? resending = null,Object? resent = null,}) {
  return _then(OwnerRegisterSuccess(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,resending: null == resending ? _self.resending : resending // ignore: cast_nullable_to_non_nullable
as bool,resent: null == resent ? _self.resent : resent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class OwnerRegisterError implements OwnerRegisterState {
  const OwnerRegisterError(this.message);
  

 final  String message;

/// Create a copy of OwnerRegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerRegisterErrorCopyWith<OwnerRegisterError> get copyWith => _$OwnerRegisterErrorCopyWithImpl<OwnerRegisterError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerRegisterError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OwnerRegisterState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $OwnerRegisterErrorCopyWith<$Res> implements $OwnerRegisterStateCopyWith<$Res> {
  factory $OwnerRegisterErrorCopyWith(OwnerRegisterError value, $Res Function(OwnerRegisterError) _then) = _$OwnerRegisterErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OwnerRegisterErrorCopyWithImpl<$Res>
    implements $OwnerRegisterErrorCopyWith<$Res> {
  _$OwnerRegisterErrorCopyWithImpl(this._self, this._then);

  final OwnerRegisterError _self;
  final $Res Function(OwnerRegisterError) _then;

/// Create a copy of OwnerRegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OwnerRegisterError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
