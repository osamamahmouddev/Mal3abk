// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sessions_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionsState()';
}


}

/// @nodoc
class $SessionsStateCopyWith<$Res>  {
$SessionsStateCopyWith(SessionsState _, $Res Function(SessionsState) __);
}


/// Adds pattern-matching-related methods to [SessionsState].
extension SessionsStatePatterns on SessionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SessionsInitial value)?  initial,TResult Function( SessionsLoading value)?  loading,TResult Function( SessionsSuccess value)?  success,TResult Function( SessionsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SessionsInitial() when initial != null:
return initial(_that);case SessionsLoading() when loading != null:
return loading(_that);case SessionsSuccess() when success != null:
return success(_that);case SessionsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SessionsInitial value)  initial,required TResult Function( SessionsLoading value)  loading,required TResult Function( SessionsSuccess value)  success,required TResult Function( SessionsError value)  error,}){
final _that = this;
switch (_that) {
case SessionsInitial():
return initial(_that);case SessionsLoading():
return loading(_that);case SessionsSuccess():
return success(_that);case SessionsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SessionsInitial value)?  initial,TResult? Function( SessionsLoading value)?  loading,TResult? Function( SessionsSuccess value)?  success,TResult? Function( SessionsError value)?  error,}){
final _that = this;
switch (_that) {
case SessionsInitial() when initial != null:
return initial(_that);case SessionsLoading() when loading != null:
return loading(_that);case SessionsSuccess() when success != null:
return success(_that);case SessionsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<SessionModel> sessions,  bool busy,  String? failure)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SessionsInitial() when initial != null:
return initial();case SessionsLoading() when loading != null:
return loading();case SessionsSuccess() when success != null:
return success(_that.sessions,_that.busy,_that.failure);case SessionsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<SessionModel> sessions,  bool busy,  String? failure)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case SessionsInitial():
return initial();case SessionsLoading():
return loading();case SessionsSuccess():
return success(_that.sessions,_that.busy,_that.failure);case SessionsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<SessionModel> sessions,  bool busy,  String? failure)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case SessionsInitial() when initial != null:
return initial();case SessionsLoading() when loading != null:
return loading();case SessionsSuccess() when success != null:
return success(_that.sessions,_that.busy,_that.failure);case SessionsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SessionsInitial implements SessionsState {
  const SessionsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionsState.initial()';
}


}




/// @nodoc


class SessionsLoading implements SessionsState {
  const SessionsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionsState.loading()';
}


}




/// @nodoc


class SessionsSuccess implements SessionsState {
  const SessionsSuccess(final  List<SessionModel> sessions, {this.busy = false, this.failure}): _sessions = sessions;
  

 final  List<SessionModel> _sessions;
 List<SessionModel> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}

@JsonKey() final  bool busy;
 final  String? failure;

/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionsSuccessCopyWith<SessionsSuccess> get copyWith => _$SessionsSuccessCopyWithImpl<SessionsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionsSuccess&&const DeepCollectionEquality().equals(other._sessions, _sessions)&&(identical(other.busy, busy) || other.busy == busy)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sessions),busy,failure);

@override
String toString() {
  return 'SessionsState.success(sessions: $sessions, busy: $busy, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $SessionsSuccessCopyWith<$Res> implements $SessionsStateCopyWith<$Res> {
  factory $SessionsSuccessCopyWith(SessionsSuccess value, $Res Function(SessionsSuccess) _then) = _$SessionsSuccessCopyWithImpl;
@useResult
$Res call({
 List<SessionModel> sessions, bool busy, String? failure
});




}
/// @nodoc
class _$SessionsSuccessCopyWithImpl<$Res>
    implements $SessionsSuccessCopyWith<$Res> {
  _$SessionsSuccessCopyWithImpl(this._self, this._then);

  final SessionsSuccess _self;
  final $Res Function(SessionsSuccess) _then;

/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sessions = null,Object? busy = null,Object? failure = freezed,}) {
  return _then(SessionsSuccess(
null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SessionModel>,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class SessionsError implements SessionsState {
  const SessionsError(this.message);
  

 final  String message;

/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionsErrorCopyWith<SessionsError> get copyWith => _$SessionsErrorCopyWithImpl<SessionsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SessionsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SessionsErrorCopyWith<$Res> implements $SessionsStateCopyWith<$Res> {
  factory $SessionsErrorCopyWith(SessionsError value, $Res Function(SessionsError) _then) = _$SessionsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SessionsErrorCopyWithImpl<$Res>
    implements $SessionsErrorCopyWith<$Res> {
  _$SessionsErrorCopyWithImpl(this._self, this._then);

  final SessionsError _self;
  final $Res Function(SessionsError) _then;

/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SessionsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
