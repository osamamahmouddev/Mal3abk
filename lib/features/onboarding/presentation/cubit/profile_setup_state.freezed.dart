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


/// @nodoc


class ProfileSetupInitial implements ProfileSetupState {
  const ProfileSetupInitial();
  

@override
String toString() {
  return 'ProfileSetupState.initial()';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupInitial);
}

@override
int get hashCode => runtimeType.hashCode;

}




/// @nodoc


class ProfileSetupLoading implements ProfileSetupState {
  const ProfileSetupLoading();
  

@override
String toString() {
  return 'ProfileSetupState.loading()';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupLoading);
}

@override
int get hashCode => runtimeType.hashCode;

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
String toString() {
  return 'ProfileSetupState.success(profile: $profile)';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupSuccess&&(identical(other.profile, profile) || other.profile == profile));
}

@override
int get hashCode => Object.hash(runtimeType,profile);

}

/// @nodoc
abstract class $ProfileSetupSuccessCopyWith<$Res> implements $ProfileSetupStateCopyWith<$Res> {
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
String toString() {
  return 'ProfileSetupState.error(message: $message)';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupError&&(identical(other.message, message) || other.message == message));
}

@override
int get hashCode => Object.hash(runtimeType,message);

}

/// @nodoc
abstract class $ProfileSetupErrorCopyWith<$Res> implements $ProfileSetupStateCopyWith<$Res> {
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
