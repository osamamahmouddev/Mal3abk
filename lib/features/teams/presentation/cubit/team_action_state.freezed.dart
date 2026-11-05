// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_action_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeamActionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamActionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamActionState()';
}


}

/// @nodoc
class $TeamActionStateCopyWith<$Res>  {
$TeamActionStateCopyWith(TeamActionState _, $Res Function(TeamActionState) __);
}


/// Adds pattern-matching-related methods to [TeamActionState].
extension TeamActionStatePatterns on TeamActionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TeamActionInitial value)?  initial,TResult Function( TeamActionLoading value)?  loading,TResult Function( TeamActionSuccess value)?  success,TResult Function( TeamActionError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TeamActionInitial() when initial != null:
return initial(_that);case TeamActionLoading() when loading != null:
return loading(_that);case TeamActionSuccess() when success != null:
return success(_that);case TeamActionError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TeamActionInitial value)  initial,required TResult Function( TeamActionLoading value)  loading,required TResult Function( TeamActionSuccess value)  success,required TResult Function( TeamActionError value)  error,}){
final _that = this;
switch (_that) {
case TeamActionInitial():
return initial(_that);case TeamActionLoading():
return loading(_that);case TeamActionSuccess():
return success(_that);case TeamActionError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TeamActionInitial value)?  initial,TResult? Function( TeamActionLoading value)?  loading,TResult? Function( TeamActionSuccess value)?  success,TResult? Function( TeamActionError value)?  error,}){
final _that = this;
switch (_that) {
case TeamActionInitial() when initial != null:
return initial(_that);case TeamActionLoading() when loading != null:
return loading(_that);case TeamActionSuccess() when success != null:
return success(_that);case TeamActionError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( TeamActionType action)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TeamActionInitial() when initial != null:
return initial();case TeamActionLoading() when loading != null:
return loading();case TeamActionSuccess() when success != null:
return success(_that.action);case TeamActionError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( TeamActionType action)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case TeamActionInitial():
return initial();case TeamActionLoading():
return loading();case TeamActionSuccess():
return success(_that.action);case TeamActionError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( TeamActionType action)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case TeamActionInitial() when initial != null:
return initial();case TeamActionLoading() when loading != null:
return loading();case TeamActionSuccess() when success != null:
return success(_that.action);case TeamActionError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TeamActionInitial implements TeamActionState {
  const TeamActionInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamActionInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamActionState.initial()';
}


}




/// @nodoc


class TeamActionLoading implements TeamActionState {
  const TeamActionLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamActionLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamActionState.loading()';
}


}




/// @nodoc


class TeamActionSuccess implements TeamActionState {
  const TeamActionSuccess(this.action);
  

 final  TeamActionType action;

/// Create a copy of TeamActionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamActionSuccessCopyWith<TeamActionSuccess> get copyWith => _$TeamActionSuccessCopyWithImpl<TeamActionSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamActionSuccess&&(identical(other.action, action) || other.action == action));
}


@override
int get hashCode => Object.hash(runtimeType,action);

@override
String toString() {
  return 'TeamActionState.success(action: $action)';
}


}

/// @nodoc
abstract mixin class $TeamActionSuccessCopyWith<$Res> implements $TeamActionStateCopyWith<$Res> {
  factory $TeamActionSuccessCopyWith(TeamActionSuccess value, $Res Function(TeamActionSuccess) _then) = _$TeamActionSuccessCopyWithImpl;
@useResult
$Res call({
 TeamActionType action
});




}
/// @nodoc
class _$TeamActionSuccessCopyWithImpl<$Res>
    implements $TeamActionSuccessCopyWith<$Res> {
  _$TeamActionSuccessCopyWithImpl(this._self, this._then);

  final TeamActionSuccess _self;
  final $Res Function(TeamActionSuccess) _then;

/// Create a copy of TeamActionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? action = null,}) {
  return _then(TeamActionSuccess(
null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as TeamActionType,
  ));
}


}

/// @nodoc


class TeamActionError implements TeamActionState {
  const TeamActionError(this.message);
  

 final  String message;

/// Create a copy of TeamActionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamActionErrorCopyWith<TeamActionError> get copyWith => _$TeamActionErrorCopyWithImpl<TeamActionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamActionError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TeamActionState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TeamActionErrorCopyWith<$Res> implements $TeamActionStateCopyWith<$Res> {
  factory $TeamActionErrorCopyWith(TeamActionError value, $Res Function(TeamActionError) _then) = _$TeamActionErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TeamActionErrorCopyWithImpl<$Res>
    implements $TeamActionErrorCopyWith<$Res> {
  _$TeamActionErrorCopyWithImpl(this._self, this._then);

  final TeamActionError _self;
  final $Res Function(TeamActionError) _then;

/// Create a copy of TeamActionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TeamActionError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
