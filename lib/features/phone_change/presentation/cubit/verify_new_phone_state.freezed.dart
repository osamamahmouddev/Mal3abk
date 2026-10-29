// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_new_phone_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerifyNewPhoneState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyNewPhoneState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyNewPhoneState()';
}


}

/// @nodoc
class $VerifyNewPhoneStateCopyWith<$Res>  {
$VerifyNewPhoneStateCopyWith(VerifyNewPhoneState _, $Res Function(VerifyNewPhoneState) __);
}


/// Adds pattern-matching-related methods to [VerifyNewPhoneState].
extension VerifyNewPhoneStatePatterns on VerifyNewPhoneState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VerifyNewPhoneInitial value)?  initial,TResult Function( VerifyNewPhoneLoading value)?  loading,TResult Function( VerifyNewPhoneSuccess value)?  success,TResult Function( VerifyNewPhoneError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VerifyNewPhoneInitial() when initial != null:
return initial(_that);case VerifyNewPhoneLoading() when loading != null:
return loading(_that);case VerifyNewPhoneSuccess() when success != null:
return success(_that);case VerifyNewPhoneError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VerifyNewPhoneInitial value)  initial,required TResult Function( VerifyNewPhoneLoading value)  loading,required TResult Function( VerifyNewPhoneSuccess value)  success,required TResult Function( VerifyNewPhoneError value)  error,}){
final _that = this;
switch (_that) {
case VerifyNewPhoneInitial():
return initial(_that);case VerifyNewPhoneLoading():
return loading(_that);case VerifyNewPhoneSuccess():
return success(_that);case VerifyNewPhoneError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VerifyNewPhoneInitial value)?  initial,TResult? Function( VerifyNewPhoneLoading value)?  loading,TResult? Function( VerifyNewPhoneSuccess value)?  success,TResult? Function( VerifyNewPhoneError value)?  error,}){
final _that = this;
switch (_that) {
case VerifyNewPhoneInitial() when initial != null:
return initial(_that);case VerifyNewPhoneLoading() when loading != null:
return loading(_that);case VerifyNewPhoneSuccess() when success != null:
return success(_that);case VerifyNewPhoneError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( VerifyNewPhoneResponseModel data)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VerifyNewPhoneInitial() when initial != null:
return initial();case VerifyNewPhoneLoading() when loading != null:
return loading();case VerifyNewPhoneSuccess() when success != null:
return success(_that.data);case VerifyNewPhoneError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( VerifyNewPhoneResponseModel data)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case VerifyNewPhoneInitial():
return initial();case VerifyNewPhoneLoading():
return loading();case VerifyNewPhoneSuccess():
return success(_that.data);case VerifyNewPhoneError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( VerifyNewPhoneResponseModel data)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case VerifyNewPhoneInitial() when initial != null:
return initial();case VerifyNewPhoneLoading() when loading != null:
return loading();case VerifyNewPhoneSuccess() when success != null:
return success(_that.data);case VerifyNewPhoneError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class VerifyNewPhoneInitial implements VerifyNewPhoneState {
  const VerifyNewPhoneInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyNewPhoneInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyNewPhoneState.initial()';
}


}




/// @nodoc


class VerifyNewPhoneLoading implements VerifyNewPhoneState {
  const VerifyNewPhoneLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyNewPhoneLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyNewPhoneState.loading()';
}


}




/// @nodoc


class VerifyNewPhoneSuccess implements VerifyNewPhoneState {
  const VerifyNewPhoneSuccess(this.data);
  

 final  VerifyNewPhoneResponseModel data;

/// Create a copy of VerifyNewPhoneState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyNewPhoneSuccessCopyWith<VerifyNewPhoneSuccess> get copyWith => _$VerifyNewPhoneSuccessCopyWithImpl<VerifyNewPhoneSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyNewPhoneSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'VerifyNewPhoneState.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $VerifyNewPhoneSuccessCopyWith<$Res> implements $VerifyNewPhoneStateCopyWith<$Res> {
  factory $VerifyNewPhoneSuccessCopyWith(VerifyNewPhoneSuccess value, $Res Function(VerifyNewPhoneSuccess) _then) = _$VerifyNewPhoneSuccessCopyWithImpl;
@useResult
$Res call({
 VerifyNewPhoneResponseModel data
});




}
/// @nodoc
class _$VerifyNewPhoneSuccessCopyWithImpl<$Res>
    implements $VerifyNewPhoneSuccessCopyWith<$Res> {
  _$VerifyNewPhoneSuccessCopyWithImpl(this._self, this._then);

  final VerifyNewPhoneSuccess _self;
  final $Res Function(VerifyNewPhoneSuccess) _then;

/// Create a copy of VerifyNewPhoneState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(VerifyNewPhoneSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as VerifyNewPhoneResponseModel,
  ));
}


}

/// @nodoc


class VerifyNewPhoneError implements VerifyNewPhoneState {
  const VerifyNewPhoneError(this.message);
  

 final  String message;

/// Create a copy of VerifyNewPhoneState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyNewPhoneErrorCopyWith<VerifyNewPhoneError> get copyWith => _$VerifyNewPhoneErrorCopyWithImpl<VerifyNewPhoneError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyNewPhoneError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'VerifyNewPhoneState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $VerifyNewPhoneErrorCopyWith<$Res> implements $VerifyNewPhoneStateCopyWith<$Res> {
  factory $VerifyNewPhoneErrorCopyWith(VerifyNewPhoneError value, $Res Function(VerifyNewPhoneError) _then) = _$VerifyNewPhoneErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$VerifyNewPhoneErrorCopyWithImpl<$Res>
    implements $VerifyNewPhoneErrorCopyWith<$Res> {
  _$VerifyNewPhoneErrorCopyWithImpl(this._self, this._then);

  final VerifyNewPhoneError _self;
  final $Res Function(VerifyNewPhoneError) _then;

/// Create a copy of VerifyNewPhoneState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(VerifyNewPhoneError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
