// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_teams_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyTeamsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyTeamsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyTeamsState()';
}


}

/// @nodoc
class $MyTeamsStateCopyWith<$Res>  {
$MyTeamsStateCopyWith(MyTeamsState _, $Res Function(MyTeamsState) __);
}


/// Adds pattern-matching-related methods to [MyTeamsState].
extension MyTeamsStatePatterns on MyTeamsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MyTeamsInitial value)?  initial,TResult Function( MyTeamsLoading value)?  loading,TResult Function( MyTeamsSuccess value)?  success,TResult Function( MyTeamsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MyTeamsInitial() when initial != null:
return initial(_that);case MyTeamsLoading() when loading != null:
return loading(_that);case MyTeamsSuccess() when success != null:
return success(_that);case MyTeamsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MyTeamsInitial value)  initial,required TResult Function( MyTeamsLoading value)  loading,required TResult Function( MyTeamsSuccess value)  success,required TResult Function( MyTeamsError value)  error,}){
final _that = this;
switch (_that) {
case MyTeamsInitial():
return initial(_that);case MyTeamsLoading():
return loading(_that);case MyTeamsSuccess():
return success(_that);case MyTeamsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MyTeamsInitial value)?  initial,TResult? Function( MyTeamsLoading value)?  loading,TResult? Function( MyTeamsSuccess value)?  success,TResult? Function( MyTeamsError value)?  error,}){
final _that = this;
switch (_that) {
case MyTeamsInitial() when initial != null:
return initial(_that);case MyTeamsLoading() when loading != null:
return loading(_that);case MyTeamsSuccess() when success != null:
return success(_that);case MyTeamsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<TeamSummaryModel> teams)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MyTeamsInitial() when initial != null:
return initial();case MyTeamsLoading() when loading != null:
return loading();case MyTeamsSuccess() when success != null:
return success(_that.teams);case MyTeamsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<TeamSummaryModel> teams)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case MyTeamsInitial():
return initial();case MyTeamsLoading():
return loading();case MyTeamsSuccess():
return success(_that.teams);case MyTeamsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<TeamSummaryModel> teams)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case MyTeamsInitial() when initial != null:
return initial();case MyTeamsLoading() when loading != null:
return loading();case MyTeamsSuccess() when success != null:
return success(_that.teams);case MyTeamsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class MyTeamsInitial implements MyTeamsState {
  const MyTeamsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyTeamsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyTeamsState.initial()';
}


}




/// @nodoc


class MyTeamsLoading implements MyTeamsState {
  const MyTeamsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyTeamsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyTeamsState.loading()';
}


}




/// @nodoc


class MyTeamsSuccess implements MyTeamsState {
  const MyTeamsSuccess(final  List<TeamSummaryModel> teams): _teams = teams;
  

 final  List<TeamSummaryModel> _teams;
 List<TeamSummaryModel> get teams {
  if (_teams is EqualUnmodifiableListView) return _teams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teams);
}


/// Create a copy of MyTeamsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyTeamsSuccessCopyWith<MyTeamsSuccess> get copyWith => _$MyTeamsSuccessCopyWithImpl<MyTeamsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyTeamsSuccess&&const DeepCollectionEquality().equals(other._teams, _teams));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_teams));

@override
String toString() {
  return 'MyTeamsState.success(teams: $teams)';
}


}

/// @nodoc
abstract mixin class $MyTeamsSuccessCopyWith<$Res> implements $MyTeamsStateCopyWith<$Res> {
  factory $MyTeamsSuccessCopyWith(MyTeamsSuccess value, $Res Function(MyTeamsSuccess) _then) = _$MyTeamsSuccessCopyWithImpl;
@useResult
$Res call({
 List<TeamSummaryModel> teams
});




}
/// @nodoc
class _$MyTeamsSuccessCopyWithImpl<$Res>
    implements $MyTeamsSuccessCopyWith<$Res> {
  _$MyTeamsSuccessCopyWithImpl(this._self, this._then);

  final MyTeamsSuccess _self;
  final $Res Function(MyTeamsSuccess) _then;

/// Create a copy of MyTeamsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? teams = null,}) {
  return _then(MyTeamsSuccess(
null == teams ? _self._teams : teams // ignore: cast_nullable_to_non_nullable
as List<TeamSummaryModel>,
  ));
}


}

/// @nodoc


class MyTeamsError implements MyTeamsState {
  const MyTeamsError(this.message);
  

 final  String message;

/// Create a copy of MyTeamsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyTeamsErrorCopyWith<MyTeamsError> get copyWith => _$MyTeamsErrorCopyWithImpl<MyTeamsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyTeamsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MyTeamsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $MyTeamsErrorCopyWith<$Res> implements $MyTeamsStateCopyWith<$Res> {
  factory $MyTeamsErrorCopyWith(MyTeamsError value, $Res Function(MyTeamsError) _then) = _$MyTeamsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MyTeamsErrorCopyWithImpl<$Res>
    implements $MyTeamsErrorCopyWith<$Res> {
  _$MyTeamsErrorCopyWithImpl(this._self, this._then);

  final MyTeamsError _self;
  final $Res Function(MyTeamsError) _then;

/// Create a copy of MyTeamsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MyTeamsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
