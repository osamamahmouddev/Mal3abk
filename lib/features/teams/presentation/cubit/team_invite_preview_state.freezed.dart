// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_invite_preview_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeamInvitePreviewState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamInvitePreviewState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamInvitePreviewState()';
}


}

/// @nodoc
class $TeamInvitePreviewStateCopyWith<$Res>  {
$TeamInvitePreviewStateCopyWith(TeamInvitePreviewState _, $Res Function(TeamInvitePreviewState) __);
}


/// Adds pattern-matching-related methods to [TeamInvitePreviewState].
extension TeamInvitePreviewStatePatterns on TeamInvitePreviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TeamInvitePreviewInitial value)?  initial,TResult Function( TeamInvitePreviewLoading value)?  loading,TResult Function( TeamInvitePreviewSuccess value)?  success,TResult Function( TeamInvitePreviewError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TeamInvitePreviewInitial() when initial != null:
return initial(_that);case TeamInvitePreviewLoading() when loading != null:
return loading(_that);case TeamInvitePreviewSuccess() when success != null:
return success(_that);case TeamInvitePreviewError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TeamInvitePreviewInitial value)  initial,required TResult Function( TeamInvitePreviewLoading value)  loading,required TResult Function( TeamInvitePreviewSuccess value)  success,required TResult Function( TeamInvitePreviewError value)  error,}){
final _that = this;
switch (_that) {
case TeamInvitePreviewInitial():
return initial(_that);case TeamInvitePreviewLoading():
return loading(_that);case TeamInvitePreviewSuccess():
return success(_that);case TeamInvitePreviewError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TeamInvitePreviewInitial value)?  initial,TResult? Function( TeamInvitePreviewLoading value)?  loading,TResult? Function( TeamInvitePreviewSuccess value)?  success,TResult? Function( TeamInvitePreviewError value)?  error,}){
final _that = this;
switch (_that) {
case TeamInvitePreviewInitial() when initial != null:
return initial(_that);case TeamInvitePreviewLoading() when loading != null:
return loading(_that);case TeamInvitePreviewSuccess() when success != null:
return success(_that);case TeamInvitePreviewError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( TeamInvitePreviewModel preview)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TeamInvitePreviewInitial() when initial != null:
return initial();case TeamInvitePreviewLoading() when loading != null:
return loading();case TeamInvitePreviewSuccess() when success != null:
return success(_that.preview);case TeamInvitePreviewError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( TeamInvitePreviewModel preview)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case TeamInvitePreviewInitial():
return initial();case TeamInvitePreviewLoading():
return loading();case TeamInvitePreviewSuccess():
return success(_that.preview);case TeamInvitePreviewError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( TeamInvitePreviewModel preview)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case TeamInvitePreviewInitial() when initial != null:
return initial();case TeamInvitePreviewLoading() when loading != null:
return loading();case TeamInvitePreviewSuccess() when success != null:
return success(_that.preview);case TeamInvitePreviewError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TeamInvitePreviewInitial implements TeamInvitePreviewState {
  const TeamInvitePreviewInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamInvitePreviewInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamInvitePreviewState.initial()';
}


}




/// @nodoc


class TeamInvitePreviewLoading implements TeamInvitePreviewState {
  const TeamInvitePreviewLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamInvitePreviewLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamInvitePreviewState.loading()';
}


}




/// @nodoc


class TeamInvitePreviewSuccess implements TeamInvitePreviewState {
  const TeamInvitePreviewSuccess(this.preview);
  

 final  TeamInvitePreviewModel preview;

/// Create a copy of TeamInvitePreviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamInvitePreviewSuccessCopyWith<TeamInvitePreviewSuccess> get copyWith => _$TeamInvitePreviewSuccessCopyWithImpl<TeamInvitePreviewSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamInvitePreviewSuccess&&(identical(other.preview, preview) || other.preview == preview));
}


@override
int get hashCode => Object.hash(runtimeType,preview);

@override
String toString() {
  return 'TeamInvitePreviewState.success(preview: $preview)';
}


}

/// @nodoc
abstract mixin class $TeamInvitePreviewSuccessCopyWith<$Res> implements $TeamInvitePreviewStateCopyWith<$Res> {
  factory $TeamInvitePreviewSuccessCopyWith(TeamInvitePreviewSuccess value, $Res Function(TeamInvitePreviewSuccess) _then) = _$TeamInvitePreviewSuccessCopyWithImpl;
@useResult
$Res call({
 TeamInvitePreviewModel preview
});




}
/// @nodoc
class _$TeamInvitePreviewSuccessCopyWithImpl<$Res>
    implements $TeamInvitePreviewSuccessCopyWith<$Res> {
  _$TeamInvitePreviewSuccessCopyWithImpl(this._self, this._then);

  final TeamInvitePreviewSuccess _self;
  final $Res Function(TeamInvitePreviewSuccess) _then;

/// Create a copy of TeamInvitePreviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? preview = null,}) {
  return _then(TeamInvitePreviewSuccess(
null == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as TeamInvitePreviewModel,
  ));
}


}

/// @nodoc


class TeamInvitePreviewError implements TeamInvitePreviewState {
  const TeamInvitePreviewError(this.message);
  

 final  String message;

/// Create a copy of TeamInvitePreviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamInvitePreviewErrorCopyWith<TeamInvitePreviewError> get copyWith => _$TeamInvitePreviewErrorCopyWithImpl<TeamInvitePreviewError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamInvitePreviewError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TeamInvitePreviewState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TeamInvitePreviewErrorCopyWith<$Res> implements $TeamInvitePreviewStateCopyWith<$Res> {
  factory $TeamInvitePreviewErrorCopyWith(TeamInvitePreviewError value, $Res Function(TeamInvitePreviewError) _then) = _$TeamInvitePreviewErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TeamInvitePreviewErrorCopyWithImpl<$Res>
    implements $TeamInvitePreviewErrorCopyWith<$Res> {
  _$TeamInvitePreviewErrorCopyWithImpl(this._self, this._then);

  final TeamInvitePreviewError _self;
  final $Res Function(TeamInvitePreviewError) _then;

/// Create a copy of TeamInvitePreviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TeamInvitePreviewError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
