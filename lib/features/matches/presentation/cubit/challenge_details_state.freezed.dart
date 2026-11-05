// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChallengeDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChallengeDetailsState()';
}


}

/// @nodoc
class $ChallengeDetailsStateCopyWith<$Res>  {
$ChallengeDetailsStateCopyWith(ChallengeDetailsState _, $Res Function(ChallengeDetailsState) __);
}


/// Adds pattern-matching-related methods to [ChallengeDetailsState].
extension ChallengeDetailsStatePatterns on ChallengeDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChallengeDetailsInitial value)?  initial,TResult Function( ChallengeDetailsLoading value)?  loading,TResult Function( ChallengeDetailsSuccess value)?  success,TResult Function( ChallengeDetailsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChallengeDetailsInitial() when initial != null:
return initial(_that);case ChallengeDetailsLoading() when loading != null:
return loading(_that);case ChallengeDetailsSuccess() when success != null:
return success(_that);case ChallengeDetailsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChallengeDetailsInitial value)  initial,required TResult Function( ChallengeDetailsLoading value)  loading,required TResult Function( ChallengeDetailsSuccess value)  success,required TResult Function( ChallengeDetailsError value)  error,}){
final _that = this;
switch (_that) {
case ChallengeDetailsInitial():
return initial(_that);case ChallengeDetailsLoading():
return loading(_that);case ChallengeDetailsSuccess():
return success(_that);case ChallengeDetailsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChallengeDetailsInitial value)?  initial,TResult? Function( ChallengeDetailsLoading value)?  loading,TResult? Function( ChallengeDetailsSuccess value)?  success,TResult? Function( ChallengeDetailsError value)?  error,}){
final _that = this;
switch (_that) {
case ChallengeDetailsInitial() when initial != null:
return initial(_that);case ChallengeDetailsLoading() when loading != null:
return loading(_that);case ChallengeDetailsSuccess() when success != null:
return success(_that);case ChallengeDetailsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ChallengeDetailsModel details)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChallengeDetailsInitial() when initial != null:
return initial();case ChallengeDetailsLoading() when loading != null:
return loading();case ChallengeDetailsSuccess() when success != null:
return success(_that.details);case ChallengeDetailsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ChallengeDetailsModel details)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ChallengeDetailsInitial():
return initial();case ChallengeDetailsLoading():
return loading();case ChallengeDetailsSuccess():
return success(_that.details);case ChallengeDetailsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ChallengeDetailsModel details)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ChallengeDetailsInitial() when initial != null:
return initial();case ChallengeDetailsLoading() when loading != null:
return loading();case ChallengeDetailsSuccess() when success != null:
return success(_that.details);case ChallengeDetailsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ChallengeDetailsInitial implements ChallengeDetailsState {
  const ChallengeDetailsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeDetailsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChallengeDetailsState.initial()';
}


}




/// @nodoc


class ChallengeDetailsLoading implements ChallengeDetailsState {
  const ChallengeDetailsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChallengeDetailsState.loading()';
}


}




/// @nodoc


class ChallengeDetailsSuccess implements ChallengeDetailsState {
  const ChallengeDetailsSuccess(this.details);
  

 final  ChallengeDetailsModel details;

/// Create a copy of ChallengeDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChallengeDetailsSuccessCopyWith<ChallengeDetailsSuccess> get copyWith => _$ChallengeDetailsSuccessCopyWithImpl<ChallengeDetailsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeDetailsSuccess&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode => Object.hash(runtimeType,details);

@override
String toString() {
  return 'ChallengeDetailsState.success(details: $details)';
}


}

/// @nodoc
abstract mixin class $ChallengeDetailsSuccessCopyWith<$Res> implements $ChallengeDetailsStateCopyWith<$Res> {
  factory $ChallengeDetailsSuccessCopyWith(ChallengeDetailsSuccess value, $Res Function(ChallengeDetailsSuccess) _then) = _$ChallengeDetailsSuccessCopyWithImpl;
@useResult
$Res call({
 ChallengeDetailsModel details
});




}
/// @nodoc
class _$ChallengeDetailsSuccessCopyWithImpl<$Res>
    implements $ChallengeDetailsSuccessCopyWith<$Res> {
  _$ChallengeDetailsSuccessCopyWithImpl(this._self, this._then);

  final ChallengeDetailsSuccess _self;
  final $Res Function(ChallengeDetailsSuccess) _then;

/// Create a copy of ChallengeDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? details = null,}) {
  return _then(ChallengeDetailsSuccess(
null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as ChallengeDetailsModel,
  ));
}


}

/// @nodoc


class ChallengeDetailsError implements ChallengeDetailsState {
  const ChallengeDetailsError(this.message);
  

 final  String message;

/// Create a copy of ChallengeDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChallengeDetailsErrorCopyWith<ChallengeDetailsError> get copyWith => _$ChallengeDetailsErrorCopyWithImpl<ChallengeDetailsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeDetailsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ChallengeDetailsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ChallengeDetailsErrorCopyWith<$Res> implements $ChallengeDetailsStateCopyWith<$Res> {
  factory $ChallengeDetailsErrorCopyWith(ChallengeDetailsError value, $Res Function(ChallengeDetailsError) _then) = _$ChallengeDetailsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ChallengeDetailsErrorCopyWithImpl<$Res>
    implements $ChallengeDetailsErrorCopyWith<$Res> {
  _$ChallengeDetailsErrorCopyWithImpl(this._self, this._then);

  final ChallengeDetailsError _self;
  final $Res Function(ChallengeDetailsError) _then;

/// Create a copy of ChallengeDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ChallengeDetailsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
