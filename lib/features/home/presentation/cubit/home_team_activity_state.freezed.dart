// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_team_activity_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeTeamActivityState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeTeamActivityState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeTeamActivityState()';
}


}

/// @nodoc
class $HomeTeamActivityStateCopyWith<$Res>  {
$HomeTeamActivityStateCopyWith(HomeTeamActivityState _, $Res Function(HomeTeamActivityState) __);
}


/// Adds pattern-matching-related methods to [HomeTeamActivityState].
extension HomeTeamActivityStatePatterns on HomeTeamActivityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeTeamActivityInitial value)?  initial,TResult Function( HomeTeamActivityLoading value)?  loading,TResult Function( HomeTeamActivitySuccess value)?  success,TResult Function( HomeTeamActivityError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeTeamActivityInitial() when initial != null:
return initial(_that);case HomeTeamActivityLoading() when loading != null:
return loading(_that);case HomeTeamActivitySuccess() when success != null:
return success(_that);case HomeTeamActivityError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeTeamActivityInitial value)  initial,required TResult Function( HomeTeamActivityLoading value)  loading,required TResult Function( HomeTeamActivitySuccess value)  success,required TResult Function( HomeTeamActivityError value)  error,}){
final _that = this;
switch (_that) {
case HomeTeamActivityInitial():
return initial(_that);case HomeTeamActivityLoading():
return loading(_that);case HomeTeamActivitySuccess():
return success(_that);case HomeTeamActivityError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeTeamActivityInitial value)?  initial,TResult? Function( HomeTeamActivityLoading value)?  loading,TResult? Function( HomeTeamActivitySuccess value)?  success,TResult? Function( HomeTeamActivityError value)?  error,}){
final _that = this;
switch (_that) {
case HomeTeamActivityInitial() when initial != null:
return initial(_that);case HomeTeamActivityLoading() when loading != null:
return loading(_that);case HomeTeamActivitySuccess() when success != null:
return success(_that);case HomeTeamActivityError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( HomeTeamActivityModel activity)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeTeamActivityInitial() when initial != null:
return initial();case HomeTeamActivityLoading() when loading != null:
return loading();case HomeTeamActivitySuccess() when success != null:
return success(_that.activity);case HomeTeamActivityError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( HomeTeamActivityModel activity)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case HomeTeamActivityInitial():
return initial();case HomeTeamActivityLoading():
return loading();case HomeTeamActivitySuccess():
return success(_that.activity);case HomeTeamActivityError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( HomeTeamActivityModel activity)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case HomeTeamActivityInitial() when initial != null:
return initial();case HomeTeamActivityLoading() when loading != null:
return loading();case HomeTeamActivitySuccess() when success != null:
return success(_that.activity);case HomeTeamActivityError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class HomeTeamActivityInitial implements HomeTeamActivityState {
  const HomeTeamActivityInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeTeamActivityInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeTeamActivityState.initial()';
}


}




/// @nodoc


class HomeTeamActivityLoading implements HomeTeamActivityState {
  const HomeTeamActivityLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeTeamActivityLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeTeamActivityState.loading()';
}


}




/// @nodoc


class HomeTeamActivitySuccess implements HomeTeamActivityState {
  const HomeTeamActivitySuccess(this.activity);
  

 final  HomeTeamActivityModel activity;

/// Create a copy of HomeTeamActivityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeTeamActivitySuccessCopyWith<HomeTeamActivitySuccess> get copyWith => _$HomeTeamActivitySuccessCopyWithImpl<HomeTeamActivitySuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeTeamActivitySuccess&&(identical(other.activity, activity) || other.activity == activity));
}


@override
int get hashCode => Object.hash(runtimeType,activity);

@override
String toString() {
  return 'HomeTeamActivityState.success(activity: $activity)';
}


}

/// @nodoc
abstract mixin class $HomeTeamActivitySuccessCopyWith<$Res> implements $HomeTeamActivityStateCopyWith<$Res> {
  factory $HomeTeamActivitySuccessCopyWith(HomeTeamActivitySuccess value, $Res Function(HomeTeamActivitySuccess) _then) = _$HomeTeamActivitySuccessCopyWithImpl;
@useResult
$Res call({
 HomeTeamActivityModel activity
});




}
/// @nodoc
class _$HomeTeamActivitySuccessCopyWithImpl<$Res>
    implements $HomeTeamActivitySuccessCopyWith<$Res> {
  _$HomeTeamActivitySuccessCopyWithImpl(this._self, this._then);

  final HomeTeamActivitySuccess _self;
  final $Res Function(HomeTeamActivitySuccess) _then;

/// Create a copy of HomeTeamActivityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? activity = null,}) {
  return _then(HomeTeamActivitySuccess(
null == activity ? _self.activity : activity // ignore: cast_nullable_to_non_nullable
as HomeTeamActivityModel,
  ));
}


}

/// @nodoc


class HomeTeamActivityError implements HomeTeamActivityState {
  const HomeTeamActivityError(this.message);
  

 final  String message;

/// Create a copy of HomeTeamActivityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeTeamActivityErrorCopyWith<HomeTeamActivityError> get copyWith => _$HomeTeamActivityErrorCopyWithImpl<HomeTeamActivityError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeTeamActivityError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'HomeTeamActivityState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $HomeTeamActivityErrorCopyWith<$Res> implements $HomeTeamActivityStateCopyWith<$Res> {
  factory $HomeTeamActivityErrorCopyWith(HomeTeamActivityError value, $Res Function(HomeTeamActivityError) _then) = _$HomeTeamActivityErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$HomeTeamActivityErrorCopyWithImpl<$Res>
    implements $HomeTeamActivityErrorCopyWith<$Res> {
  _$HomeTeamActivityErrorCopyWithImpl(this._self, this._then);

  final HomeTeamActivityError _self;
  final $Res Function(HomeTeamActivityError) _then;

/// Create a copy of HomeTeamActivityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(HomeTeamActivityError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
