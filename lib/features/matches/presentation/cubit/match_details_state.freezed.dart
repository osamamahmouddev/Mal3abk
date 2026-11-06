// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MatchDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchDetailsState()';
}


}

/// @nodoc
class $MatchDetailsStateCopyWith<$Res>  {
$MatchDetailsStateCopyWith(MatchDetailsState _, $Res Function(MatchDetailsState) __);
}


/// Adds pattern-matching-related methods to [MatchDetailsState].
extension MatchDetailsStatePatterns on MatchDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MatchDetailsInitial value)?  initial,TResult Function( MatchDetailsLoading value)?  loading,TResult Function( MatchDetailsSuccess value)?  success,TResult Function( MatchDetailsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MatchDetailsInitial() when initial != null:
return initial(_that);case MatchDetailsLoading() when loading != null:
return loading(_that);case MatchDetailsSuccess() when success != null:
return success(_that);case MatchDetailsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MatchDetailsInitial value)  initial,required TResult Function( MatchDetailsLoading value)  loading,required TResult Function( MatchDetailsSuccess value)  success,required TResult Function( MatchDetailsError value)  error,}){
final _that = this;
switch (_that) {
case MatchDetailsInitial():
return initial(_that);case MatchDetailsLoading():
return loading(_that);case MatchDetailsSuccess():
return success(_that);case MatchDetailsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MatchDetailsInitial value)?  initial,TResult? Function( MatchDetailsLoading value)?  loading,TResult? Function( MatchDetailsSuccess value)?  success,TResult? Function( MatchDetailsError value)?  error,}){
final _that = this;
switch (_that) {
case MatchDetailsInitial() when initial != null:
return initial(_that);case MatchDetailsLoading() when loading != null:
return loading(_that);case MatchDetailsSuccess() when success != null:
return success(_that);case MatchDetailsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( MatchDetailsModel details)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MatchDetailsInitial() when initial != null:
return initial();case MatchDetailsLoading() when loading != null:
return loading();case MatchDetailsSuccess() when success != null:
return success(_that.details);case MatchDetailsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( MatchDetailsModel details)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case MatchDetailsInitial():
return initial();case MatchDetailsLoading():
return loading();case MatchDetailsSuccess():
return success(_that.details);case MatchDetailsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( MatchDetailsModel details)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case MatchDetailsInitial() when initial != null:
return initial();case MatchDetailsLoading() when loading != null:
return loading();case MatchDetailsSuccess() when success != null:
return success(_that.details);case MatchDetailsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class MatchDetailsInitial implements MatchDetailsState {
  const MatchDetailsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchDetailsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchDetailsState.initial()';
}


}




/// @nodoc


class MatchDetailsLoading implements MatchDetailsState {
  const MatchDetailsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchDetailsState.loading()';
}


}




/// @nodoc


class MatchDetailsSuccess implements MatchDetailsState {
  const MatchDetailsSuccess(this.details);
  

 final  MatchDetailsModel details;

/// Create a copy of MatchDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchDetailsSuccessCopyWith<MatchDetailsSuccess> get copyWith => _$MatchDetailsSuccessCopyWithImpl<MatchDetailsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchDetailsSuccess&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode => Object.hash(runtimeType,details);

@override
String toString() {
  return 'MatchDetailsState.success(details: $details)';
}


}

/// @nodoc
abstract mixin class $MatchDetailsSuccessCopyWith<$Res> implements $MatchDetailsStateCopyWith<$Res> {
  factory $MatchDetailsSuccessCopyWith(MatchDetailsSuccess value, $Res Function(MatchDetailsSuccess) _then) = _$MatchDetailsSuccessCopyWithImpl;
@useResult
$Res call({
 MatchDetailsModel details
});




}
/// @nodoc
class _$MatchDetailsSuccessCopyWithImpl<$Res>
    implements $MatchDetailsSuccessCopyWith<$Res> {
  _$MatchDetailsSuccessCopyWithImpl(this._self, this._then);

  final MatchDetailsSuccess _self;
  final $Res Function(MatchDetailsSuccess) _then;

/// Create a copy of MatchDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? details = null,}) {
  return _then(MatchDetailsSuccess(
null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as MatchDetailsModel,
  ));
}


}

/// @nodoc


class MatchDetailsError implements MatchDetailsState {
  const MatchDetailsError(this.message);
  

 final  String message;

/// Create a copy of MatchDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchDetailsErrorCopyWith<MatchDetailsError> get copyWith => _$MatchDetailsErrorCopyWithImpl<MatchDetailsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchDetailsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MatchDetailsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $MatchDetailsErrorCopyWith<$Res> implements $MatchDetailsStateCopyWith<$Res> {
  factory $MatchDetailsErrorCopyWith(MatchDetailsError value, $Res Function(MatchDetailsError) _then) = _$MatchDetailsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MatchDetailsErrorCopyWithImpl<$Res>
    implements $MatchDetailsErrorCopyWith<$Res> {
  _$MatchDetailsErrorCopyWithImpl(this._self, this._then);

  final MatchDetailsError _self;
  final $Res Function(MatchDetailsError) _then;

/// Create a copy of MatchDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MatchDetailsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
