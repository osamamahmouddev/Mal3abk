// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'join_team_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JoinTeamState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinTeamState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JoinTeamState()';
}


}

/// @nodoc
class $JoinTeamStateCopyWith<$Res>  {
$JoinTeamStateCopyWith(JoinTeamState _, $Res Function(JoinTeamState) __);
}


/// Adds pattern-matching-related methods to [JoinTeamState].
extension JoinTeamStatePatterns on JoinTeamState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( JoinTeamInitial value)?  initial,TResult Function( JoinTeamLoading value)?  loading,TResult Function( JoinTeamSuccess value)?  success,TResult Function( JoinTeamError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case JoinTeamInitial() when initial != null:
return initial(_that);case JoinTeamLoading() when loading != null:
return loading(_that);case JoinTeamSuccess() when success != null:
return success(_that);case JoinTeamError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( JoinTeamInitial value)  initial,required TResult Function( JoinTeamLoading value)  loading,required TResult Function( JoinTeamSuccess value)  success,required TResult Function( JoinTeamError value)  error,}){
final _that = this;
switch (_that) {
case JoinTeamInitial():
return initial(_that);case JoinTeamLoading():
return loading(_that);case JoinTeamSuccess():
return success(_that);case JoinTeamError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( JoinTeamInitial value)?  initial,TResult? Function( JoinTeamLoading value)?  loading,TResult? Function( JoinTeamSuccess value)?  success,TResult? Function( JoinTeamError value)?  error,}){
final _that = this;
switch (_that) {
case JoinTeamInitial() when initial != null:
return initial(_that);case JoinTeamLoading() when loading != null:
return loading(_that);case JoinTeamSuccess() when success != null:
return success(_that);case JoinTeamError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( TeamDetailModel team)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case JoinTeamInitial() when initial != null:
return initial();case JoinTeamLoading() when loading != null:
return loading();case JoinTeamSuccess() when success != null:
return success(_that.team);case JoinTeamError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( TeamDetailModel team)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case JoinTeamInitial():
return initial();case JoinTeamLoading():
return loading();case JoinTeamSuccess():
return success(_that.team);case JoinTeamError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( TeamDetailModel team)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case JoinTeamInitial() when initial != null:
return initial();case JoinTeamLoading() when loading != null:
return loading();case JoinTeamSuccess() when success != null:
return success(_that.team);case JoinTeamError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class JoinTeamInitial implements JoinTeamState {
  const JoinTeamInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinTeamInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JoinTeamState.initial()';
}


}




/// @nodoc


class JoinTeamLoading implements JoinTeamState {
  const JoinTeamLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinTeamLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JoinTeamState.loading()';
}


}




/// @nodoc


class JoinTeamSuccess implements JoinTeamState {
  const JoinTeamSuccess(this.team);
  

 final  TeamDetailModel team;

/// Create a copy of JoinTeamState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinTeamSuccessCopyWith<JoinTeamSuccess> get copyWith => _$JoinTeamSuccessCopyWithImpl<JoinTeamSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinTeamSuccess&&(identical(other.team, team) || other.team == team));
}


@override
int get hashCode => Object.hash(runtimeType,team);

@override
String toString() {
  return 'JoinTeamState.success(team: $team)';
}


}

/// @nodoc
abstract mixin class $JoinTeamSuccessCopyWith<$Res> implements $JoinTeamStateCopyWith<$Res> {
  factory $JoinTeamSuccessCopyWith(JoinTeamSuccess value, $Res Function(JoinTeamSuccess) _then) = _$JoinTeamSuccessCopyWithImpl;
@useResult
$Res call({
 TeamDetailModel team
});




}
/// @nodoc
class _$JoinTeamSuccessCopyWithImpl<$Res>
    implements $JoinTeamSuccessCopyWith<$Res> {
  _$JoinTeamSuccessCopyWithImpl(this._self, this._then);

  final JoinTeamSuccess _self;
  final $Res Function(JoinTeamSuccess) _then;

/// Create a copy of JoinTeamState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? team = null,}) {
  return _then(JoinTeamSuccess(
null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamDetailModel,
  ));
}


}

/// @nodoc


class JoinTeamError implements JoinTeamState {
  const JoinTeamError(this.message);
  

 final  String message;

/// Create a copy of JoinTeamState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinTeamErrorCopyWith<JoinTeamError> get copyWith => _$JoinTeamErrorCopyWithImpl<JoinTeamError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinTeamError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'JoinTeamState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $JoinTeamErrorCopyWith<$Res> implements $JoinTeamStateCopyWith<$Res> {
  factory $JoinTeamErrorCopyWith(JoinTeamError value, $Res Function(JoinTeamError) _then) = _$JoinTeamErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$JoinTeamErrorCopyWithImpl<$Res>
    implements $JoinTeamErrorCopyWith<$Res> {
  _$JoinTeamErrorCopyWithImpl(this._self, this._then);

  final JoinTeamError _self;
  final $Res Function(JoinTeamError) _then;

/// Create a copy of JoinTeamState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(JoinTeamError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
