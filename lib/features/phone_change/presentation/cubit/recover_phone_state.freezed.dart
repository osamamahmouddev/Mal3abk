// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recover_phone_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecoverPhoneState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecoverPhoneState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecoverPhoneState()';
}


}

/// @nodoc
class $RecoverPhoneStateCopyWith<$Res>  {
$RecoverPhoneStateCopyWith(RecoverPhoneState _, $Res Function(RecoverPhoneState) __);
}


/// Adds pattern-matching-related methods to [RecoverPhoneState].
extension RecoverPhoneStatePatterns on RecoverPhoneState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RecoverPhoneInitial value)?  initial,TResult Function( RecoverPhoneLoading value)?  loading,TResult Function( RecoverPhoneSuccess value)?  success,TResult Function( RecoverPhoneError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecoverPhoneInitial() when initial != null:
return initial(_that);case RecoverPhoneLoading() when loading != null:
return loading(_that);case RecoverPhoneSuccess() when success != null:
return success(_that);case RecoverPhoneError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RecoverPhoneInitial value)  initial,required TResult Function( RecoverPhoneLoading value)  loading,required TResult Function( RecoverPhoneSuccess value)  success,required TResult Function( RecoverPhoneError value)  error,}){
final _that = this;
switch (_that) {
case RecoverPhoneInitial():
return initial(_that);case RecoverPhoneLoading():
return loading(_that);case RecoverPhoneSuccess():
return success(_that);case RecoverPhoneError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RecoverPhoneInitial value)?  initial,TResult? Function( RecoverPhoneLoading value)?  loading,TResult? Function( RecoverPhoneSuccess value)?  success,TResult? Function( RecoverPhoneError value)?  error,}){
final _that = this;
switch (_that) {
case RecoverPhoneInitial() when initial != null:
return initial(_that);case RecoverPhoneLoading() when loading != null:
return loading(_that);case RecoverPhoneSuccess() when success != null:
return success(_that);case RecoverPhoneError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecoverPhoneInitial() when initial != null:
return initial();case RecoverPhoneLoading() when loading != null:
return loading();case RecoverPhoneSuccess() when success != null:
return success();case RecoverPhoneError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case RecoverPhoneInitial():
return initial();case RecoverPhoneLoading():
return loading();case RecoverPhoneSuccess():
return success();case RecoverPhoneError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case RecoverPhoneInitial() when initial != null:
return initial();case RecoverPhoneLoading() when loading != null:
return loading();case RecoverPhoneSuccess() when success != null:
return success();case RecoverPhoneError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class RecoverPhoneInitial implements RecoverPhoneState {
  const RecoverPhoneInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecoverPhoneInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecoverPhoneState.initial()';
}


}




/// @nodoc


class RecoverPhoneLoading implements RecoverPhoneState {
  const RecoverPhoneLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecoverPhoneLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecoverPhoneState.loading()';
}


}




/// @nodoc


class RecoverPhoneSuccess implements RecoverPhoneState {
  const RecoverPhoneSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecoverPhoneSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecoverPhoneState.success()';
}


}




/// @nodoc


class RecoverPhoneError implements RecoverPhoneState {
  const RecoverPhoneError(this.message);
  

 final  String message;

/// Create a copy of RecoverPhoneState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecoverPhoneErrorCopyWith<RecoverPhoneError> get copyWith => _$RecoverPhoneErrorCopyWithImpl<RecoverPhoneError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecoverPhoneError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RecoverPhoneState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $RecoverPhoneErrorCopyWith<$Res> implements $RecoverPhoneStateCopyWith<$Res> {
  factory $RecoverPhoneErrorCopyWith(RecoverPhoneError value, $Res Function(RecoverPhoneError) _then) = _$RecoverPhoneErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RecoverPhoneErrorCopyWithImpl<$Res>
    implements $RecoverPhoneErrorCopyWith<$Res> {
  _$RecoverPhoneErrorCopyWithImpl(this._self, this._then);

  final RecoverPhoneError _self;
  final $Res Function(RecoverPhoneError) _then;

/// Create a copy of RecoverPhoneState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RecoverPhoneError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
