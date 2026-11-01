// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueProfileState {

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueProfileState);
}

@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VenueProfileState()';
}

}

/// @nodoc
class $VenueProfileStateCopyWith<$Res>  {
$VenueProfileStateCopyWith(VenueProfileState _, $Res Function(VenueProfileState) __);
}


/// @nodoc


class VenueProfileInitial implements VenueProfileState {
  const VenueProfileInitial();
  

@override
String toString() {
  return 'VenueProfileState.initial()';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueProfileInitial);
}

@override
int get hashCode => runtimeType.hashCode;

}




/// @nodoc


class VenueProfileLoading implements VenueProfileState {
  const VenueProfileLoading();
  

@override
String toString() {
  return 'VenueProfileState.loading()';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueProfileLoading);
}

@override
int get hashCode => runtimeType.hashCode;

}




/// @nodoc


class VenueProfileSuccess implements VenueProfileState {
  const VenueProfileSuccess({required this.venue, required final  List<PitchDetailsModel> pitches}): _pitches = pitches;
  

 final  VenueDetailsModel venue;
 final  List<PitchDetailsModel> _pitches;
 List<PitchDetailsModel> get pitches {
  if (_pitches is EqualUnmodifiableListView) return _pitches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pitches);
}


/// Create a copy of VenueProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueProfileSuccessCopyWith<VenueProfileSuccess> get copyWith => _$VenueProfileSuccessCopyWithImpl<VenueProfileSuccess>(this, _$identity);



@override
String toString() {
  return 'VenueProfileState.success(venue: $venue, pitches: $pitches)';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueProfileSuccess&&(identical(other.venue, venue) || other.venue == venue)&&const DeepCollectionEquality().equals(other._pitches, _pitches));
}

@override
int get hashCode => Object.hash(runtimeType,venue,const DeepCollectionEquality().hash(_pitches));

}

/// @nodoc
abstract class $VenueProfileSuccessCopyWith<$Res> implements $VenueProfileStateCopyWith<$Res> {
  factory $VenueProfileSuccessCopyWith(VenueProfileSuccess value, $Res Function(VenueProfileSuccess) _then) = _$VenueProfileSuccessCopyWithImpl;
@useResult
$Res call({
 VenueDetailsModel venue, List<PitchDetailsModel> pitches
});




}
/// @nodoc
class _$VenueProfileSuccessCopyWithImpl<$Res>
    implements $VenueProfileSuccessCopyWith<$Res> {
  _$VenueProfileSuccessCopyWithImpl(this._self, this._then);

  final VenueProfileSuccess _self;
  final $Res Function(VenueProfileSuccess) _then;

/// Create a copy of VenueProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? venue = null,Object? pitches = null,}) {
  return _then(VenueProfileSuccess(
venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as VenueDetailsModel,pitches: null == pitches ? _self._pitches : pitches // ignore: cast_nullable_to_non_nullable
as List<PitchDetailsModel>,
  ));
}


}

/// @nodoc


class VenueProfileError implements VenueProfileState {
  const VenueProfileError(this.message);
  

 final  String message;

/// Create a copy of VenueProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueProfileErrorCopyWith<VenueProfileError> get copyWith => _$VenueProfileErrorCopyWithImpl<VenueProfileError>(this, _$identity);



@override
String toString() {
  return 'VenueProfileState.error(message: $message)';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueProfileError&&(identical(other.message, message) || other.message == message));
}

@override
int get hashCode => Object.hash(runtimeType,message);

}

/// @nodoc
abstract class $VenueProfileErrorCopyWith<$Res> implements $VenueProfileStateCopyWith<$Res> {
  factory $VenueProfileErrorCopyWith(VenueProfileError value, $Res Function(VenueProfileError) _then) = _$VenueProfileErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$VenueProfileErrorCopyWithImpl<$Res>
    implements $VenueProfileErrorCopyWith<$Res> {
  _$VenueProfileErrorCopyWithImpl(this._self, this._then);

  final VenueProfileError _self;
  final $Res Function(VenueProfileError) _then;

/// Create a copy of VenueProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(VenueProfileError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
