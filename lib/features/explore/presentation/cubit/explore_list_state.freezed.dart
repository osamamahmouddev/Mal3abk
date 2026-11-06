// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExploreListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExploreListState()';
}


}

/// @nodoc
class $ExploreListStateCopyWith<$Res>  {
$ExploreListStateCopyWith(ExploreListState _, $Res Function(ExploreListState) __);
}


/// Adds pattern-matching-related methods to [ExploreListState].
extension ExploreListStatePatterns on ExploreListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ExploreListInitial value)?  initial,TResult Function( ExploreListLoading value)?  loading,TResult Function( ExploreListSuccess value)?  success,TResult Function( ExploreListError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ExploreListInitial() when initial != null:
return initial(_that);case ExploreListLoading() when loading != null:
return loading(_that);case ExploreListSuccess() when success != null:
return success(_that);case ExploreListError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ExploreListInitial value)  initial,required TResult Function( ExploreListLoading value)  loading,required TResult Function( ExploreListSuccess value)  success,required TResult Function( ExploreListError value)  error,}){
final _that = this;
switch (_that) {
case ExploreListInitial():
return initial(_that);case ExploreListLoading():
return loading(_that);case ExploreListSuccess():
return success(_that);case ExploreListError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ExploreListInitial value)?  initial,TResult? Function( ExploreListLoading value)?  loading,TResult? Function( ExploreListSuccess value)?  success,TResult? Function( ExploreListError value)?  error,}){
final _that = this;
switch (_that) {
case ExploreListInitial() when initial != null:
return initial(_that);case ExploreListLoading() when loading != null:
return loading(_that);case ExploreListSuccess() when success != null:
return success(_that);case ExploreListError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ExploreResultModel result)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ExploreListInitial() when initial != null:
return initial();case ExploreListLoading() when loading != null:
return loading();case ExploreListSuccess() when success != null:
return success(_that.result);case ExploreListError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ExploreResultModel result)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ExploreListInitial():
return initial();case ExploreListLoading():
return loading();case ExploreListSuccess():
return success(_that.result);case ExploreListError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ExploreResultModel result)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ExploreListInitial() when initial != null:
return initial();case ExploreListLoading() when loading != null:
return loading();case ExploreListSuccess() when success != null:
return success(_that.result);case ExploreListError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ExploreListInitial implements ExploreListState {
  const ExploreListInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreListInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExploreListState.initial()';
}


}




/// @nodoc


class ExploreListLoading implements ExploreListState {
  const ExploreListLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreListLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExploreListState.loading()';
}


}




/// @nodoc


class ExploreListSuccess implements ExploreListState {
  const ExploreListSuccess(this.result);
  

 final  ExploreResultModel result;

/// Create a copy of ExploreListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreListSuccessCopyWith<ExploreListSuccess> get copyWith => _$ExploreListSuccessCopyWithImpl<ExploreListSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreListSuccess&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'ExploreListState.success(result: $result)';
}


}

/// @nodoc
abstract mixin class $ExploreListSuccessCopyWith<$Res> implements $ExploreListStateCopyWith<$Res> {
  factory $ExploreListSuccessCopyWith(ExploreListSuccess value, $Res Function(ExploreListSuccess) _then) = _$ExploreListSuccessCopyWithImpl;
@useResult
$Res call({
 ExploreResultModel result
});




}
/// @nodoc
class _$ExploreListSuccessCopyWithImpl<$Res>
    implements $ExploreListSuccessCopyWith<$Res> {
  _$ExploreListSuccessCopyWithImpl(this._self, this._then);

  final ExploreListSuccess _self;
  final $Res Function(ExploreListSuccess) _then;

/// Create a copy of ExploreListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(ExploreListSuccess(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ExploreResultModel,
  ));
}


}

/// @nodoc


class ExploreListError implements ExploreListState {
  const ExploreListError(this.message);
  

 final  String message;

/// Create a copy of ExploreListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreListErrorCopyWith<ExploreListError> get copyWith => _$ExploreListErrorCopyWithImpl<ExploreListError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreListError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ExploreListState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ExploreListErrorCopyWith<$Res> implements $ExploreListStateCopyWith<$Res> {
  factory $ExploreListErrorCopyWith(ExploreListError value, $Res Function(ExploreListError) _then) = _$ExploreListErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ExploreListErrorCopyWithImpl<$Res>
    implements $ExploreListErrorCopyWith<$Res> {
  _$ExploreListErrorCopyWithImpl(this._self, this._then);

  final ExploreListError _self;
  final $Res Function(ExploreListError) _then;

/// Create a copy of ExploreListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ExploreListError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
