// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'start_phone_change_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StartPhoneChangeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartPhoneChangeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StartPhoneChangeState()';
}


}

/// @nodoc
class $StartPhoneChangeStateCopyWith<$Res>  {
$StartPhoneChangeStateCopyWith(StartPhoneChangeState _, $Res Function(StartPhoneChangeState) __);
}


/// Adds pattern-matching-related methods to [StartPhoneChangeState].
extension StartPhoneChangeStatePatterns on StartPhoneChangeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StartPhoneChangeInitial value)?  initial,TResult Function( StartPhoneChangeLoading value)?  loading,TResult Function( StartPhoneChangeSuccess value)?  success,TResult Function( StartPhoneChangeError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StartPhoneChangeInitial() when initial != null:
return initial(_that);case StartPhoneChangeLoading() when loading != null:
return loading(_that);case StartPhoneChangeSuccess() when success != null:
return success(_that);case StartPhoneChangeError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StartPhoneChangeInitial value)  initial,required TResult Function( StartPhoneChangeLoading value)  loading,required TResult Function( StartPhoneChangeSuccess value)  success,required TResult Function( StartPhoneChangeError value)  error,}){
final _that = this;
switch (_that) {
case StartPhoneChangeInitial():
return initial(_that);case StartPhoneChangeLoading():
return loading(_that);case StartPhoneChangeSuccess():
return success(_that);case StartPhoneChangeError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StartPhoneChangeInitial value)?  initial,TResult? Function( StartPhoneChangeLoading value)?  loading,TResult? Function( StartPhoneChangeSuccess value)?  success,TResult? Function( StartPhoneChangeError value)?  error,}){
final _that = this;
switch (_that) {
case StartPhoneChangeInitial() when initial != null:
return initial(_that);case StartPhoneChangeLoading() when loading != null:
return loading(_that);case StartPhoneChangeSuccess() when success != null:
return success(_that);case StartPhoneChangeError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( StartPhoneChangeResponseModel data)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StartPhoneChangeInitial() when initial != null:
return initial();case StartPhoneChangeLoading() when loading != null:
return loading();case StartPhoneChangeSuccess() when success != null:
return success(_that.data);case StartPhoneChangeError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( StartPhoneChangeResponseModel data)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case StartPhoneChangeInitial():
return initial();case StartPhoneChangeLoading():
return loading();case StartPhoneChangeSuccess():
return success(_that.data);case StartPhoneChangeError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( StartPhoneChangeResponseModel data)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case StartPhoneChangeInitial() when initial != null:
return initial();case StartPhoneChangeLoading() when loading != null:
return loading();case StartPhoneChangeSuccess() when success != null:
return success(_that.data);case StartPhoneChangeError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class StartPhoneChangeInitial implements StartPhoneChangeState {
  const StartPhoneChangeInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartPhoneChangeInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StartPhoneChangeState.initial()';
}


}




/// @nodoc


class StartPhoneChangeLoading implements StartPhoneChangeState {
  const StartPhoneChangeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartPhoneChangeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StartPhoneChangeState.loading()';
}


}




/// @nodoc


class StartPhoneChangeSuccess implements StartPhoneChangeState {
  const StartPhoneChangeSuccess(this.data);
  

 final  StartPhoneChangeResponseModel data;

/// Create a copy of StartPhoneChangeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartPhoneChangeSuccessCopyWith<StartPhoneChangeSuccess> get copyWith => _$StartPhoneChangeSuccessCopyWithImpl<StartPhoneChangeSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartPhoneChangeSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'StartPhoneChangeState.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $StartPhoneChangeSuccessCopyWith<$Res> implements $StartPhoneChangeStateCopyWith<$Res> {
  factory $StartPhoneChangeSuccessCopyWith(StartPhoneChangeSuccess value, $Res Function(StartPhoneChangeSuccess) _then) = _$StartPhoneChangeSuccessCopyWithImpl;
@useResult
$Res call({
 StartPhoneChangeResponseModel data
});




}
/// @nodoc
class _$StartPhoneChangeSuccessCopyWithImpl<$Res>
    implements $StartPhoneChangeSuccessCopyWith<$Res> {
  _$StartPhoneChangeSuccessCopyWithImpl(this._self, this._then);

  final StartPhoneChangeSuccess _self;
  final $Res Function(StartPhoneChangeSuccess) _then;

/// Create a copy of StartPhoneChangeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(StartPhoneChangeSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as StartPhoneChangeResponseModel,
  ));
}


}

/// @nodoc


class StartPhoneChangeError implements StartPhoneChangeState {
  const StartPhoneChangeError(this.message);
  

 final  String message;

/// Create a copy of StartPhoneChangeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartPhoneChangeErrorCopyWith<StartPhoneChangeError> get copyWith => _$StartPhoneChangeErrorCopyWithImpl<StartPhoneChangeError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartPhoneChangeError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'StartPhoneChangeState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $StartPhoneChangeErrorCopyWith<$Res> implements $StartPhoneChangeStateCopyWith<$Res> {
  factory $StartPhoneChangeErrorCopyWith(StartPhoneChangeError value, $Res Function(StartPhoneChangeError) _then) = _$StartPhoneChangeErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$StartPhoneChangeErrorCopyWithImpl<$Res>
    implements $StartPhoneChangeErrorCopyWith<$Res> {
  _$StartPhoneChangeErrorCopyWithImpl(this._self, this._then);

  final StartPhoneChangeError _self;
  final $Res Function(StartPhoneChangeError) _then;

/// Create a copy of StartPhoneChangeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(StartPhoneChangeError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
