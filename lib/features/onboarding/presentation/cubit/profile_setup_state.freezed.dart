// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_setup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileSetupState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileSetupState()';
}


}

/// @nodoc
class $ProfileSetupStateCopyWith<$Res>  {
$ProfileSetupStateCopyWith(ProfileSetupState _, $Res Function(ProfileSetupState) __);
}


/// Adds pattern-matching-related methods to [ProfileSetupState].
extension ProfileSetupStatePatterns on ProfileSetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileSetupInitial value)?  initial,TResult Function( ProfileSetupLoading value)?  loading,TResult Function( ProfileSetupSuccess value)?  success,TResult Function( ProfileSetupError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileSetupInitial() when initial != null:
return initial(_that);case ProfileSetupLoading() when loading != null:
return loading(_that);case ProfileSetupSuccess() when success != null:
return success(_that);case ProfileSetupError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileSetupInitial value)  initial,required TResult Function( ProfileSetupLoading value)  loading,required TResult Function( ProfileSetupSuccess value)  success,required TResult Function( ProfileSetupError value)  error,}){
final _that = this;
switch (_that) {
case ProfileSetupInitial():
return initial(_that);case ProfileSetupLoading():
return loading(_that);case ProfileSetupSuccess():
return success(_that);case ProfileSetupError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileSetupInitial value)?  initial,TResult? Function( ProfileSetupLoading value)?  loading,TResult? Function( ProfileSetupSuccess value)?  success,TResult? Function( ProfileSetupError value)?  error,}){
final _that = this;
switch (_that) {
case ProfileSetupInitial() when initial != null:
return initial(_that);case ProfileSetupLoading() when loading != null:
return loading(_that);case ProfileSetupSuccess() when success != null:
return success(_that);case ProfileSetupError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( MyProfileModel profile)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileSetupInitial() when initial != null:
return initial();case ProfileSetupLoading() when loading != null:
return loading();case ProfileSetupSuccess() when success != null:
return success(_that.profile);case ProfileSetupError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( MyProfileModel profile)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ProfileSetupInitial():
return initial();case ProfileSetupLoading():
return loading();case ProfileSetupSuccess():
return success(_that.profile);case ProfileSetupError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( MyProfileModel profile)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ProfileSetupInitial() when initial != null:
return initial();case ProfileSetupLoading() when loading != null:
return loading();case ProfileSetupSuccess() when success != null:
return success(_that.profile);case ProfileSetupError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ProfileSetupInitial implements ProfileSetupState {
  const ProfileSetupInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileSetupState.initial()';
}


}




/// @nodoc


class ProfileSetupLoading implements ProfileSetupState {
  const ProfileSetupLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileSetupState.loading()';
}


}




/// @nodoc


class ProfileSetupSuccess implements ProfileSetupState {
  const ProfileSetupSuccess(this.profile);
  

 final  MyProfileModel profile;

/// Create a copy of ProfileSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSetupSuccessCopyWith<ProfileSetupSuccess> get copyWith => _$ProfileSetupSuccessCopyWithImpl<ProfileSetupSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupSuccess&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'ProfileSetupState.success(profile: $profile)';
}


}

/// @nodoc
abstract mixin class $ProfileSetupSuccessCopyWith<$Res> implements $ProfileSetupStateCopyWith<$Res> {
  factory $ProfileSetupSuccessCopyWith(ProfileSetupSuccess value, $Res Function(ProfileSetupSuccess) _then) = _$ProfileSetupSuccessCopyWithImpl;
@useResult
$Res call({
 MyProfileModel profile
});




}
/// @nodoc
class _$ProfileSetupSuccessCopyWithImpl<$Res>
    implements $ProfileSetupSuccessCopyWith<$Res> {
  _$ProfileSetupSuccessCopyWithImpl(this._self, this._then);

  final ProfileSetupSuccess _self;
  final $Res Function(ProfileSetupSuccess) _then;

/// Create a copy of ProfileSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(ProfileSetupSuccess(
null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as MyProfileModel,
  ));
}


}

/// @nodoc


class ProfileSetupError implements ProfileSetupState {
  const ProfileSetupError(this.message);
  

 final  String message;

/// Create a copy of ProfileSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSetupErrorCopyWith<ProfileSetupError> get copyWith => _$ProfileSetupErrorCopyWithImpl<ProfileSetupError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProfileSetupState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ProfileSetupErrorCopyWith<$Res> implements $ProfileSetupStateCopyWith<$Res> {
  factory $ProfileSetupErrorCopyWith(ProfileSetupError value, $Res Function(ProfileSetupError) _then) = _$ProfileSetupErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ProfileSetupErrorCopyWithImpl<$Res>
    implements $ProfileSetupErrorCopyWith<$Res> {
  _$ProfileSetupErrorCopyWithImpl(this._self, this._then);

  final ProfileSetupError _self;
  final $Res Function(ProfileSetupError) _then;

/// Create a copy of ProfileSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ProfileSetupError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
