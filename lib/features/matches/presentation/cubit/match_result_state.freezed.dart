// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_result_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MatchResultState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchResultState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchResultState()';
}


}

/// @nodoc
class $MatchResultStateCopyWith<$Res>  {
$MatchResultStateCopyWith(MatchResultState _, $Res Function(MatchResultState) __);
}


/// Adds pattern-matching-related methods to [MatchResultState].
extension MatchResultStatePatterns on MatchResultState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MatchResultInitial value)?  initial,TResult Function( MatchResultLoading value)?  loading,TResult Function( MatchResultSuccess value)?  success,TResult Function( MatchResultError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MatchResultInitial() when initial != null:
return initial(_that);case MatchResultLoading() when loading != null:
return loading(_that);case MatchResultSuccess() when success != null:
return success(_that);case MatchResultError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MatchResultInitial value)  initial,required TResult Function( MatchResultLoading value)  loading,required TResult Function( MatchResultSuccess value)  success,required TResult Function( MatchResultError value)  error,}){
final _that = this;
switch (_that) {
case MatchResultInitial():
return initial(_that);case MatchResultLoading():
return loading(_that);case MatchResultSuccess():
return success(_that);case MatchResultError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MatchResultInitial value)?  initial,TResult? Function( MatchResultLoading value)?  loading,TResult? Function( MatchResultSuccess value)?  success,TResult? Function( MatchResultError value)?  error,}){
final _that = this;
switch (_that) {
case MatchResultInitial() when initial != null:
return initial(_that);case MatchResultLoading() when loading != null:
return loading(_that);case MatchResultSuccess() when success != null:
return success(_that);case MatchResultError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( MatchModel match,  MatchResultAction action)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MatchResultInitial() when initial != null:
return initial();case MatchResultLoading() when loading != null:
return loading();case MatchResultSuccess() when success != null:
return success(_that.match,_that.action);case MatchResultError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( MatchModel match,  MatchResultAction action)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case MatchResultInitial():
return initial();case MatchResultLoading():
return loading();case MatchResultSuccess():
return success(_that.match,_that.action);case MatchResultError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( MatchModel match,  MatchResultAction action)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case MatchResultInitial() when initial != null:
return initial();case MatchResultLoading() when loading != null:
return loading();case MatchResultSuccess() when success != null:
return success(_that.match,_that.action);case MatchResultError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class MatchResultInitial implements MatchResultState {
  const MatchResultInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchResultInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchResultState.initial()';
}


}




/// @nodoc


class MatchResultLoading implements MatchResultState {
  const MatchResultLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchResultLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchResultState.loading()';
}


}




/// @nodoc


class MatchResultSuccess implements MatchResultState {
  const MatchResultSuccess(this.match, this.action);
  

 final  MatchModel match;
 final  MatchResultAction action;

/// Create a copy of MatchResultState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchResultSuccessCopyWith<MatchResultSuccess> get copyWith => _$MatchResultSuccessCopyWithImpl<MatchResultSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchResultSuccess&&(identical(other.match, match) || other.match == match)&&(identical(other.action, action) || other.action == action));
}


@override
int get hashCode => Object.hash(runtimeType,match,action);

@override
String toString() {
  return 'MatchResultState.success(match: $match, action: $action)';
}


}

/// @nodoc
abstract mixin class $MatchResultSuccessCopyWith<$Res> implements $MatchResultStateCopyWith<$Res> {
  factory $MatchResultSuccessCopyWith(MatchResultSuccess value, $Res Function(MatchResultSuccess) _then) = _$MatchResultSuccessCopyWithImpl;
@useResult
$Res call({
 MatchModel match, MatchResultAction action
});




}
/// @nodoc
class _$MatchResultSuccessCopyWithImpl<$Res>
    implements $MatchResultSuccessCopyWith<$Res> {
  _$MatchResultSuccessCopyWithImpl(this._self, this._then);

  final MatchResultSuccess _self;
  final $Res Function(MatchResultSuccess) _then;

/// Create a copy of MatchResultState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? match = null,Object? action = null,}) {
  return _then(MatchResultSuccess(
null == match ? _self.match : match // ignore: cast_nullable_to_non_nullable
as MatchModel,null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as MatchResultAction,
  ));
}


}

/// @nodoc


class MatchResultError implements MatchResultState {
  const MatchResultError(this.message);
  

 final  String message;

/// Create a copy of MatchResultState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchResultErrorCopyWith<MatchResultError> get copyWith => _$MatchResultErrorCopyWithImpl<MatchResultError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchResultError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MatchResultState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $MatchResultErrorCopyWith<$Res> implements $MatchResultStateCopyWith<$Res> {
  factory $MatchResultErrorCopyWith(MatchResultError value, $Res Function(MatchResultError) _then) = _$MatchResultErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MatchResultErrorCopyWithImpl<$Res>
    implements $MatchResultErrorCopyWith<$Res> {
  _$MatchResultErrorCopyWithImpl(this._self, this._then);

  final MatchResultError _self;
  final $Res Function(MatchResultError) _then;

/// Create a copy of MatchResultState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MatchResultError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
