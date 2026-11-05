// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consents_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConsentsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsentsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConsentsState()';
}


}

/// @nodoc
class $ConsentsStateCopyWith<$Res>  {
$ConsentsStateCopyWith(ConsentsState _, $Res Function(ConsentsState) __);
}


/// Adds pattern-matching-related methods to [ConsentsState].
extension ConsentsStatePatterns on ConsentsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ConsentsInitial value)?  initial,TResult Function( ConsentsLoading value)?  loading,TResult Function( ConsentsSuccess value)?  success,TResult Function( ConsentsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ConsentsInitial() when initial != null:
return initial(_that);case ConsentsLoading() when loading != null:
return loading(_that);case ConsentsSuccess() when success != null:
return success(_that);case ConsentsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ConsentsInitial value)  initial,required TResult Function( ConsentsLoading value)  loading,required TResult Function( ConsentsSuccess value)  success,required TResult Function( ConsentsError value)  error,}){
final _that = this;
switch (_that) {
case ConsentsInitial():
return initial(_that);case ConsentsLoading():
return loading(_that);case ConsentsSuccess():
return success(_that);case ConsentsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ConsentsInitial value)?  initial,TResult? Function( ConsentsLoading value)?  loading,TResult? Function( ConsentsSuccess value)?  success,TResult? Function( ConsentsError value)?  error,}){
final _that = this;
switch (_that) {
case ConsentsInitial() when initial != null:
return initial(_that);case ConsentsLoading() when loading != null:
return loading(_that);case ConsentsSuccess() when success != null:
return success(_that);case ConsentsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ConsentsModel consents,  String? failure)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ConsentsInitial() when initial != null:
return initial();case ConsentsLoading() when loading != null:
return loading();case ConsentsSuccess() when success != null:
return success(_that.consents,_that.failure);case ConsentsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ConsentsModel consents,  String? failure)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ConsentsInitial():
return initial();case ConsentsLoading():
return loading();case ConsentsSuccess():
return success(_that.consents,_that.failure);case ConsentsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ConsentsModel consents,  String? failure)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ConsentsInitial() when initial != null:
return initial();case ConsentsLoading() when loading != null:
return loading();case ConsentsSuccess() when success != null:
return success(_that.consents,_that.failure);case ConsentsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ConsentsInitial implements ConsentsState {
  const ConsentsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsentsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConsentsState.initial()';
}


}




/// @nodoc


class ConsentsLoading implements ConsentsState {
  const ConsentsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsentsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConsentsState.loading()';
}


}




/// @nodoc


class ConsentsSuccess implements ConsentsState {
  const ConsentsSuccess(this.consents, {this.failure});
  

 final  ConsentsModel consents;
 final  String? failure;

/// Create a copy of ConsentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsentsSuccessCopyWith<ConsentsSuccess> get copyWith => _$ConsentsSuccessCopyWithImpl<ConsentsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsentsSuccess&&(identical(other.consents, consents) || other.consents == consents)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,consents,failure);

@override
String toString() {
  return 'ConsentsState.success(consents: $consents, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ConsentsSuccessCopyWith<$Res> implements $ConsentsStateCopyWith<$Res> {
  factory $ConsentsSuccessCopyWith(ConsentsSuccess value, $Res Function(ConsentsSuccess) _then) = _$ConsentsSuccessCopyWithImpl;
@useResult
$Res call({
 ConsentsModel consents, String? failure
});




}
/// @nodoc
class _$ConsentsSuccessCopyWithImpl<$Res>
    implements $ConsentsSuccessCopyWith<$Res> {
  _$ConsentsSuccessCopyWithImpl(this._self, this._then);

  final ConsentsSuccess _self;
  final $Res Function(ConsentsSuccess) _then;

/// Create a copy of ConsentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? consents = null,Object? failure = freezed,}) {
  return _then(ConsentsSuccess(
null == consents ? _self.consents : consents // ignore: cast_nullable_to_non_nullable
as ConsentsModel,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ConsentsError implements ConsentsState {
  const ConsentsError(this.message);
  

 final  String message;

/// Create a copy of ConsentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsentsErrorCopyWith<ConsentsError> get copyWith => _$ConsentsErrorCopyWithImpl<ConsentsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsentsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ConsentsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ConsentsErrorCopyWith<$Res> implements $ConsentsStateCopyWith<$Res> {
  factory $ConsentsErrorCopyWith(ConsentsError value, $Res Function(ConsentsError) _then) = _$ConsentsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ConsentsErrorCopyWithImpl<$Res>
    implements $ConsentsErrorCopyWith<$Res> {
  _$ConsentsErrorCopyWithImpl(this._self, this._then);

  final ConsentsError _self;
  final $Res Function(ConsentsError) _then;

/// Create a copy of ConsentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ConsentsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
