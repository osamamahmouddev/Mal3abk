// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_invite_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeamInviteState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamInviteState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamInviteState()';
}


}

/// @nodoc
class $TeamInviteStateCopyWith<$Res>  {
$TeamInviteStateCopyWith(TeamInviteState _, $Res Function(TeamInviteState) __);
}


/// Adds pattern-matching-related methods to [TeamInviteState].
extension TeamInviteStatePatterns on TeamInviteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TeamInviteInitial value)?  initial,TResult Function( TeamInviteLoading value)?  loading,TResult Function( TeamInviteSuccess value)?  success,TResult Function( TeamInviteError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TeamInviteInitial() when initial != null:
return initial(_that);case TeamInviteLoading() when loading != null:
return loading(_that);case TeamInviteSuccess() when success != null:
return success(_that);case TeamInviteError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TeamInviteInitial value)  initial,required TResult Function( TeamInviteLoading value)  loading,required TResult Function( TeamInviteSuccess value)  success,required TResult Function( TeamInviteError value)  error,}){
final _that = this;
switch (_that) {
case TeamInviteInitial():
return initial(_that);case TeamInviteLoading():
return loading(_that);case TeamInviteSuccess():
return success(_that);case TeamInviteError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TeamInviteInitial value)?  initial,TResult? Function( TeamInviteLoading value)?  loading,TResult? Function( TeamInviteSuccess value)?  success,TResult? Function( TeamInviteError value)?  error,}){
final _that = this;
switch (_that) {
case TeamInviteInitial() when initial != null:
return initial(_that);case TeamInviteLoading() when loading != null:
return loading(_that);case TeamInviteSuccess() when success != null:
return success(_that);case TeamInviteError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( TeamInvitationModel invitation)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TeamInviteInitial() when initial != null:
return initial();case TeamInviteLoading() when loading != null:
return loading();case TeamInviteSuccess() when success != null:
return success(_that.invitation);case TeamInviteError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( TeamInvitationModel invitation)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case TeamInviteInitial():
return initial();case TeamInviteLoading():
return loading();case TeamInviteSuccess():
return success(_that.invitation);case TeamInviteError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( TeamInvitationModel invitation)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case TeamInviteInitial() when initial != null:
return initial();case TeamInviteLoading() when loading != null:
return loading();case TeamInviteSuccess() when success != null:
return success(_that.invitation);case TeamInviteError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TeamInviteInitial implements TeamInviteState {
  const TeamInviteInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamInviteInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamInviteState.initial()';
}


}




/// @nodoc


class TeamInviteLoading implements TeamInviteState {
  const TeamInviteLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamInviteLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamInviteState.loading()';
}


}




/// @nodoc


class TeamInviteSuccess implements TeamInviteState {
  const TeamInviteSuccess(this.invitation);
  

 final  TeamInvitationModel invitation;

/// Create a copy of TeamInviteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamInviteSuccessCopyWith<TeamInviteSuccess> get copyWith => _$TeamInviteSuccessCopyWithImpl<TeamInviteSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamInviteSuccess&&(identical(other.invitation, invitation) || other.invitation == invitation));
}


@override
int get hashCode => Object.hash(runtimeType,invitation);

@override
String toString() {
  return 'TeamInviteState.success(invitation: $invitation)';
}


}

/// @nodoc
abstract mixin class $TeamInviteSuccessCopyWith<$Res> implements $TeamInviteStateCopyWith<$Res> {
  factory $TeamInviteSuccessCopyWith(TeamInviteSuccess value, $Res Function(TeamInviteSuccess) _then) = _$TeamInviteSuccessCopyWithImpl;
@useResult
$Res call({
 TeamInvitationModel invitation
});




}
/// @nodoc
class _$TeamInviteSuccessCopyWithImpl<$Res>
    implements $TeamInviteSuccessCopyWith<$Res> {
  _$TeamInviteSuccessCopyWithImpl(this._self, this._then);

  final TeamInviteSuccess _self;
  final $Res Function(TeamInviteSuccess) _then;

/// Create a copy of TeamInviteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? invitation = null,}) {
  return _then(TeamInviteSuccess(
null == invitation ? _self.invitation : invitation // ignore: cast_nullable_to_non_nullable
as TeamInvitationModel,
  ));
}


}

/// @nodoc


class TeamInviteError implements TeamInviteState {
  const TeamInviteError(this.message);
  

 final  String message;

/// Create a copy of TeamInviteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamInviteErrorCopyWith<TeamInviteError> get copyWith => _$TeamInviteErrorCopyWithImpl<TeamInviteError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamInviteError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TeamInviteState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TeamInviteErrorCopyWith<$Res> implements $TeamInviteStateCopyWith<$Res> {
  factory $TeamInviteErrorCopyWith(TeamInviteError value, $Res Function(TeamInviteError) _then) = _$TeamInviteErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TeamInviteErrorCopyWithImpl<$Res>
    implements $TeamInviteErrorCopyWith<$Res> {
  _$TeamInviteErrorCopyWithImpl(this._self, this._then);

  final TeamInviteError _self;
  final $Res Function(TeamInviteError) _then;

/// Create a copy of TeamInviteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TeamInviteError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
