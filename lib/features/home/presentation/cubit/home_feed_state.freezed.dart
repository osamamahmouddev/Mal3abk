// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_feed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeFeedState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFeedState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeFeedState()';
}


}

/// @nodoc
class $HomeFeedStateCopyWith<$Res>  {
$HomeFeedStateCopyWith(HomeFeedState _, $Res Function(HomeFeedState) __);
}


/// Adds pattern-matching-related methods to [HomeFeedState].
extension HomeFeedStatePatterns on HomeFeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeFeedInitial value)?  initial,TResult Function( HomeFeedLoading value)?  loading,TResult Function( HomeFeedSuccess value)?  success,TResult Function( HomeFeedError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeFeedInitial() when initial != null:
return initial(_that);case HomeFeedLoading() when loading != null:
return loading(_that);case HomeFeedSuccess() when success != null:
return success(_that);case HomeFeedError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeFeedInitial value)  initial,required TResult Function( HomeFeedLoading value)  loading,required TResult Function( HomeFeedSuccess value)  success,required TResult Function( HomeFeedError value)  error,}){
final _that = this;
switch (_that) {
case HomeFeedInitial():
return initial(_that);case HomeFeedLoading():
return loading(_that);case HomeFeedSuccess():
return success(_that);case HomeFeedError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeFeedInitial value)?  initial,TResult? Function( HomeFeedLoading value)?  loading,TResult? Function( HomeFeedSuccess value)?  success,TResult? Function( HomeFeedError value)?  error,}){
final _that = this;
switch (_that) {
case HomeFeedInitial() when initial != null:
return initial(_that);case HomeFeedLoading() when loading != null:
return loading(_that);case HomeFeedSuccess() when success != null:
return success(_that);case HomeFeedError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( LocatedHomeFeedModel located)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeFeedInitial() when initial != null:
return initial();case HomeFeedLoading() when loading != null:
return loading();case HomeFeedSuccess() when success != null:
return success(_that.located);case HomeFeedError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( LocatedHomeFeedModel located)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case HomeFeedInitial():
return initial();case HomeFeedLoading():
return loading();case HomeFeedSuccess():
return success(_that.located);case HomeFeedError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( LocatedHomeFeedModel located)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case HomeFeedInitial() when initial != null:
return initial();case HomeFeedLoading() when loading != null:
return loading();case HomeFeedSuccess() when success != null:
return success(_that.located);case HomeFeedError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class HomeFeedInitial implements HomeFeedState {
  const HomeFeedInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFeedInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeFeedState.initial()';
}


}




/// @nodoc


class HomeFeedLoading implements HomeFeedState {
  const HomeFeedLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFeedLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeFeedState.loading()';
}


}




/// @nodoc


class HomeFeedSuccess implements HomeFeedState {
  const HomeFeedSuccess(this.located);
  

 final  LocatedHomeFeedModel located;

/// Create a copy of HomeFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeFeedSuccessCopyWith<HomeFeedSuccess> get copyWith => _$HomeFeedSuccessCopyWithImpl<HomeFeedSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFeedSuccess&&(identical(other.located, located) || other.located == located));
}


@override
int get hashCode => Object.hash(runtimeType,located);

@override
String toString() {
  return 'HomeFeedState.success(located: $located)';
}


}

/// @nodoc
abstract mixin class $HomeFeedSuccessCopyWith<$Res> implements $HomeFeedStateCopyWith<$Res> {
  factory $HomeFeedSuccessCopyWith(HomeFeedSuccess value, $Res Function(HomeFeedSuccess) _then) = _$HomeFeedSuccessCopyWithImpl;
@useResult
$Res call({
 LocatedHomeFeedModel located
});




}
/// @nodoc
class _$HomeFeedSuccessCopyWithImpl<$Res>
    implements $HomeFeedSuccessCopyWith<$Res> {
  _$HomeFeedSuccessCopyWithImpl(this._self, this._then);

  final HomeFeedSuccess _self;
  final $Res Function(HomeFeedSuccess) _then;

/// Create a copy of HomeFeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? located = null,}) {
  return _then(HomeFeedSuccess(
null == located ? _self.located : located // ignore: cast_nullable_to_non_nullable
as LocatedHomeFeedModel,
  ));
}


}

/// @nodoc


class HomeFeedError implements HomeFeedState {
  const HomeFeedError(this.message);
  

 final  String message;

/// Create a copy of HomeFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeFeedErrorCopyWith<HomeFeedError> get copyWith => _$HomeFeedErrorCopyWithImpl<HomeFeedError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFeedError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'HomeFeedState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $HomeFeedErrorCopyWith<$Res> implements $HomeFeedStateCopyWith<$Res> {
  factory $HomeFeedErrorCopyWith(HomeFeedError value, $Res Function(HomeFeedError) _then) = _$HomeFeedErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$HomeFeedErrorCopyWithImpl<$Res>
    implements $HomeFeedErrorCopyWith<$Res> {
  _$HomeFeedErrorCopyWithImpl(this._self, this._then);

  final HomeFeedError _self;
  final $Res Function(HomeFeedError) _then;

/// Create a copy of HomeFeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(HomeFeedError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
