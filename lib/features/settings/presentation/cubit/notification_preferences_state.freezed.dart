// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_preferences_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationPreferencesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferencesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationPreferencesState()';
}


}

/// @nodoc
class $NotificationPreferencesStateCopyWith<$Res>  {
$NotificationPreferencesStateCopyWith(NotificationPreferencesState _, $Res Function(NotificationPreferencesState) __);
}


/// Adds pattern-matching-related methods to [NotificationPreferencesState].
extension NotificationPreferencesStatePatterns on NotificationPreferencesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotificationPreferencesInitial value)?  initial,TResult Function( NotificationPreferencesLoading value)?  loading,TResult Function( NotificationPreferencesSuccess value)?  success,TResult Function( NotificationPreferencesError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationPreferencesInitial() when initial != null:
return initial(_that);case NotificationPreferencesLoading() when loading != null:
return loading(_that);case NotificationPreferencesSuccess() when success != null:
return success(_that);case NotificationPreferencesError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotificationPreferencesInitial value)  initial,required TResult Function( NotificationPreferencesLoading value)  loading,required TResult Function( NotificationPreferencesSuccess value)  success,required TResult Function( NotificationPreferencesError value)  error,}){
final _that = this;
switch (_that) {
case NotificationPreferencesInitial():
return initial(_that);case NotificationPreferencesLoading():
return loading(_that);case NotificationPreferencesSuccess():
return success(_that);case NotificationPreferencesError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotificationPreferencesInitial value)?  initial,TResult? Function( NotificationPreferencesLoading value)?  loading,TResult? Function( NotificationPreferencesSuccess value)?  success,TResult? Function( NotificationPreferencesError value)?  error,}){
final _that = this;
switch (_that) {
case NotificationPreferencesInitial() when initial != null:
return initial(_that);case NotificationPreferencesLoading() when loading != null:
return loading(_that);case NotificationPreferencesSuccess() when success != null:
return success(_that);case NotificationPreferencesError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<NotificationPreferenceModel> preferences,  String? failure)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationPreferencesInitial() when initial != null:
return initial();case NotificationPreferencesLoading() when loading != null:
return loading();case NotificationPreferencesSuccess() when success != null:
return success(_that.preferences,_that.failure);case NotificationPreferencesError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<NotificationPreferenceModel> preferences,  String? failure)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case NotificationPreferencesInitial():
return initial();case NotificationPreferencesLoading():
return loading();case NotificationPreferencesSuccess():
return success(_that.preferences,_that.failure);case NotificationPreferencesError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<NotificationPreferenceModel> preferences,  String? failure)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case NotificationPreferencesInitial() when initial != null:
return initial();case NotificationPreferencesLoading() when loading != null:
return loading();case NotificationPreferencesSuccess() when success != null:
return success(_that.preferences,_that.failure);case NotificationPreferencesError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class NotificationPreferencesInitial implements NotificationPreferencesState {
  const NotificationPreferencesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferencesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationPreferencesState.initial()';
}


}




/// @nodoc


class NotificationPreferencesLoading implements NotificationPreferencesState {
  const NotificationPreferencesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferencesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationPreferencesState.loading()';
}


}




/// @nodoc


class NotificationPreferencesSuccess implements NotificationPreferencesState {
  const NotificationPreferencesSuccess(final  List<NotificationPreferenceModel> preferences, {this.failure}): _preferences = preferences;
  

 final  List<NotificationPreferenceModel> _preferences;
 List<NotificationPreferenceModel> get preferences {
  if (_preferences is EqualUnmodifiableListView) return _preferences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_preferences);
}

 final  String? failure;

/// Create a copy of NotificationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferencesSuccessCopyWith<NotificationPreferencesSuccess> get copyWith => _$NotificationPreferencesSuccessCopyWithImpl<NotificationPreferencesSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferencesSuccess&&const DeepCollectionEquality().equals(other._preferences, _preferences)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_preferences),failure);

@override
String toString() {
  return 'NotificationPreferencesState.success(preferences: $preferences, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $NotificationPreferencesSuccessCopyWith<$Res> implements $NotificationPreferencesStateCopyWith<$Res> {
  factory $NotificationPreferencesSuccessCopyWith(NotificationPreferencesSuccess value, $Res Function(NotificationPreferencesSuccess) _then) = _$NotificationPreferencesSuccessCopyWithImpl;
@useResult
$Res call({
 List<NotificationPreferenceModel> preferences, String? failure
});




}
/// @nodoc
class _$NotificationPreferencesSuccessCopyWithImpl<$Res>
    implements $NotificationPreferencesSuccessCopyWith<$Res> {
  _$NotificationPreferencesSuccessCopyWithImpl(this._self, this._then);

  final NotificationPreferencesSuccess _self;
  final $Res Function(NotificationPreferencesSuccess) _then;

/// Create a copy of NotificationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? preferences = null,Object? failure = freezed,}) {
  return _then(NotificationPreferencesSuccess(
null == preferences ? _self._preferences : preferences // ignore: cast_nullable_to_non_nullable
as List<NotificationPreferenceModel>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class NotificationPreferencesError implements NotificationPreferencesState {
  const NotificationPreferencesError(this.message);
  

 final  String message;

/// Create a copy of NotificationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferencesErrorCopyWith<NotificationPreferencesError> get copyWith => _$NotificationPreferencesErrorCopyWithImpl<NotificationPreferencesError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferencesError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotificationPreferencesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $NotificationPreferencesErrorCopyWith<$Res> implements $NotificationPreferencesStateCopyWith<$Res> {
  factory $NotificationPreferencesErrorCopyWith(NotificationPreferencesError value, $Res Function(NotificationPreferencesError) _then) = _$NotificationPreferencesErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$NotificationPreferencesErrorCopyWithImpl<$Res>
    implements $NotificationPreferencesErrorCopyWith<$Res> {
  _$NotificationPreferencesErrorCopyWithImpl(this._self, this._then);

  final NotificationPreferencesError _self;
  final $Res Function(NotificationPreferencesError) _then;

/// Create a copy of NotificationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NotificationPreferencesError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
