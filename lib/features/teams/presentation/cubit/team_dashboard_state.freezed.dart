// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeamDashboardState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamDashboardState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamDashboardState()';
}


}

/// @nodoc
class $TeamDashboardStateCopyWith<$Res>  {
$TeamDashboardStateCopyWith(TeamDashboardState _, $Res Function(TeamDashboardState) __);
}


/// Adds pattern-matching-related methods to [TeamDashboardState].
extension TeamDashboardStatePatterns on TeamDashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TeamDashboardInitial value)?  initial,TResult Function( TeamDashboardLoading value)?  loading,TResult Function( TeamDashboardSuccess value)?  success,TResult Function( TeamDashboardError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TeamDashboardInitial() when initial != null:
return initial(_that);case TeamDashboardLoading() when loading != null:
return loading(_that);case TeamDashboardSuccess() when success != null:
return success(_that);case TeamDashboardError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TeamDashboardInitial value)  initial,required TResult Function( TeamDashboardLoading value)  loading,required TResult Function( TeamDashboardSuccess value)  success,required TResult Function( TeamDashboardError value)  error,}){
final _that = this;
switch (_that) {
case TeamDashboardInitial():
return initial(_that);case TeamDashboardLoading():
return loading(_that);case TeamDashboardSuccess():
return success(_that);case TeamDashboardError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TeamDashboardInitial value)?  initial,TResult? Function( TeamDashboardLoading value)?  loading,TResult? Function( TeamDashboardSuccess value)?  success,TResult? Function( TeamDashboardError value)?  error,}){
final _that = this;
switch (_that) {
case TeamDashboardInitial() when initial != null:
return initial(_that);case TeamDashboardLoading() when loading != null:
return loading(_that);case TeamDashboardSuccess() when success != null:
return success(_that);case TeamDashboardError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( TeamDashboardModel dashboard)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TeamDashboardInitial() when initial != null:
return initial();case TeamDashboardLoading() when loading != null:
return loading();case TeamDashboardSuccess() when success != null:
return success(_that.dashboard);case TeamDashboardError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( TeamDashboardModel dashboard)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case TeamDashboardInitial():
return initial();case TeamDashboardLoading():
return loading();case TeamDashboardSuccess():
return success(_that.dashboard);case TeamDashboardError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( TeamDashboardModel dashboard)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case TeamDashboardInitial() when initial != null:
return initial();case TeamDashboardLoading() when loading != null:
return loading();case TeamDashboardSuccess() when success != null:
return success(_that.dashboard);case TeamDashboardError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TeamDashboardInitial implements TeamDashboardState {
  const TeamDashboardInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamDashboardInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamDashboardState.initial()';
}


}




/// @nodoc


class TeamDashboardLoading implements TeamDashboardState {
  const TeamDashboardLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamDashboardLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamDashboardState.loading()';
}


}




/// @nodoc


class TeamDashboardSuccess implements TeamDashboardState {
  const TeamDashboardSuccess(this.dashboard);
  

 final  TeamDashboardModel dashboard;

/// Create a copy of TeamDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamDashboardSuccessCopyWith<TeamDashboardSuccess> get copyWith => _$TeamDashboardSuccessCopyWithImpl<TeamDashboardSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamDashboardSuccess&&(identical(other.dashboard, dashboard) || other.dashboard == dashboard));
}


@override
int get hashCode => Object.hash(runtimeType,dashboard);

@override
String toString() {
  return 'TeamDashboardState.success(dashboard: $dashboard)';
}


}

/// @nodoc
abstract mixin class $TeamDashboardSuccessCopyWith<$Res> implements $TeamDashboardStateCopyWith<$Res> {
  factory $TeamDashboardSuccessCopyWith(TeamDashboardSuccess value, $Res Function(TeamDashboardSuccess) _then) = _$TeamDashboardSuccessCopyWithImpl;
@useResult
$Res call({
 TeamDashboardModel dashboard
});




}
/// @nodoc
class _$TeamDashboardSuccessCopyWithImpl<$Res>
    implements $TeamDashboardSuccessCopyWith<$Res> {
  _$TeamDashboardSuccessCopyWithImpl(this._self, this._then);

  final TeamDashboardSuccess _self;
  final $Res Function(TeamDashboardSuccess) _then;

/// Create a copy of TeamDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dashboard = null,}) {
  return _then(TeamDashboardSuccess(
null == dashboard ? _self.dashboard : dashboard // ignore: cast_nullable_to_non_nullable
as TeamDashboardModel,
  ));
}


}

/// @nodoc


class TeamDashboardError implements TeamDashboardState {
  const TeamDashboardError(this.message);
  

 final  String message;

/// Create a copy of TeamDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamDashboardErrorCopyWith<TeamDashboardError> get copyWith => _$TeamDashboardErrorCopyWithImpl<TeamDashboardError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamDashboardError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TeamDashboardState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TeamDashboardErrorCopyWith<$Res> implements $TeamDashboardStateCopyWith<$Res> {
  factory $TeamDashboardErrorCopyWith(TeamDashboardError value, $Res Function(TeamDashboardError) _then) = _$TeamDashboardErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TeamDashboardErrorCopyWithImpl<$Res>
    implements $TeamDashboardErrorCopyWith<$Res> {
  _$TeamDashboardErrorCopyWithImpl(this._self, this._then);

  final TeamDashboardError _self;
  final $Res Function(TeamDashboardError) _then;

/// Create a copy of TeamDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TeamDashboardError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
