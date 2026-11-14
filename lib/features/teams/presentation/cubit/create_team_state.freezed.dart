// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_team_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateTeamState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTeamState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateTeamState()';
}


}

/// @nodoc
class $CreateTeamStateCopyWith<$Res>  {
$CreateTeamStateCopyWith(CreateTeamState _, $Res Function(CreateTeamState) __);
}


/// Adds pattern-matching-related methods to [CreateTeamState].
extension CreateTeamStatePatterns on CreateTeamState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CreateTeamInitial value)?  initial,TResult Function( CreateTeamLoading value)?  loading,TResult Function( CreateTeamSuccess value)?  success,TResult Function( CreateTeamError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CreateTeamInitial() when initial != null:
return initial(_that);case CreateTeamLoading() when loading != null:
return loading(_that);case CreateTeamSuccess() when success != null:
return success(_that);case CreateTeamError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CreateTeamInitial value)  initial,required TResult Function( CreateTeamLoading value)  loading,required TResult Function( CreateTeamSuccess value)  success,required TResult Function( CreateTeamError value)  error,}){
final _that = this;
switch (_that) {
case CreateTeamInitial():
return initial(_that);case CreateTeamLoading():
return loading(_that);case CreateTeamSuccess():
return success(_that);case CreateTeamError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CreateTeamInitial value)?  initial,TResult? Function( CreateTeamLoading value)?  loading,TResult? Function( CreateTeamSuccess value)?  success,TResult? Function( CreateTeamError value)?  error,}){
final _that = this;
switch (_that) {
case CreateTeamInitial() when initial != null:
return initial(_that);case CreateTeamLoading() when loading != null:
return loading(_that);case CreateTeamSuccess() when success != null:
return success(_that);case CreateTeamError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( TeamDetailModel team,  bool settingsSaved)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CreateTeamInitial() when initial != null:
return initial();case CreateTeamLoading() when loading != null:
return loading();case CreateTeamSuccess() when success != null:
return success(_that.team,_that.settingsSaved);case CreateTeamError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( TeamDetailModel team,  bool settingsSaved)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case CreateTeamInitial():
return initial();case CreateTeamLoading():
return loading();case CreateTeamSuccess():
return success(_that.team,_that.settingsSaved);case CreateTeamError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( TeamDetailModel team,  bool settingsSaved)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case CreateTeamInitial() when initial != null:
return initial();case CreateTeamLoading() when loading != null:
return loading();case CreateTeamSuccess() when success != null:
return success(_that.team,_that.settingsSaved);case CreateTeamError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CreateTeamInitial implements CreateTeamState {
  const CreateTeamInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTeamInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateTeamState.initial()';
}


}




/// @nodoc


class CreateTeamLoading implements CreateTeamState {
  const CreateTeamLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTeamLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateTeamState.loading()';
}


}




/// @nodoc


class CreateTeamSuccess implements CreateTeamState {
  const CreateTeamSuccess(this.team, {this.settingsSaved = true});
  

 final  TeamDetailModel team;
@JsonKey() final  bool settingsSaved;

/// Create a copy of CreateTeamState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTeamSuccessCopyWith<CreateTeamSuccess> get copyWith => _$CreateTeamSuccessCopyWithImpl<CreateTeamSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTeamSuccess&&(identical(other.team, team) || other.team == team)&&(identical(other.settingsSaved, settingsSaved) || other.settingsSaved == settingsSaved));
}


@override
int get hashCode => Object.hash(runtimeType,team,settingsSaved);

@override
String toString() {
  return 'CreateTeamState.success(team: $team, settingsSaved: $settingsSaved)';
}


}

/// @nodoc
abstract mixin class $CreateTeamSuccessCopyWith<$Res> implements $CreateTeamStateCopyWith<$Res> {
  factory $CreateTeamSuccessCopyWith(CreateTeamSuccess value, $Res Function(CreateTeamSuccess) _then) = _$CreateTeamSuccessCopyWithImpl;
@useResult
$Res call({
 TeamDetailModel team, bool settingsSaved
});




}
/// @nodoc
class _$CreateTeamSuccessCopyWithImpl<$Res>
    implements $CreateTeamSuccessCopyWith<$Res> {
  _$CreateTeamSuccessCopyWithImpl(this._self, this._then);

  final CreateTeamSuccess _self;
  final $Res Function(CreateTeamSuccess) _then;

/// Create a copy of CreateTeamState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? team = null,Object? settingsSaved = null,}) {
  return _then(CreateTeamSuccess(
null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamDetailModel,settingsSaved: null == settingsSaved ? _self.settingsSaved : settingsSaved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class CreateTeamError implements CreateTeamState {
  const CreateTeamError(this.message);
  

 final  String message;

/// Create a copy of CreateTeamState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTeamErrorCopyWith<CreateTeamError> get copyWith => _$CreateTeamErrorCopyWithImpl<CreateTeamError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTeamError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CreateTeamState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CreateTeamErrorCopyWith<$Res> implements $CreateTeamStateCopyWith<$Res> {
  factory $CreateTeamErrorCopyWith(CreateTeamError value, $Res Function(CreateTeamError) _then) = _$CreateTeamErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CreateTeamErrorCopyWithImpl<$Res>
    implements $CreateTeamErrorCopyWith<$Res> {
  _$CreateTeamErrorCopyWithImpl(this._self, this._then);

  final CreateTeamError _self;
  final $Res Function(CreateTeamError) _then;

/// Create a copy of CreateTeamState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CreateTeamError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
