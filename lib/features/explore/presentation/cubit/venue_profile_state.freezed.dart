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


/// Adds pattern-matching-related methods to [VenueProfileState].
extension VenueProfileStatePatterns on VenueProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VenueProfileInitial value)?  initial,TResult Function( VenueProfileLoading value)?  loading,TResult Function( VenueProfileSuccess value)?  success,TResult Function( VenueProfileError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VenueProfileInitial() when initial != null:
return initial(_that);case VenueProfileLoading() when loading != null:
return loading(_that);case VenueProfileSuccess() when success != null:
return success(_that);case VenueProfileError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VenueProfileInitial value)  initial,required TResult Function( VenueProfileLoading value)  loading,required TResult Function( VenueProfileSuccess value)  success,required TResult Function( VenueProfileError value)  error,}){
final _that = this;
switch (_that) {
case VenueProfileInitial():
return initial(_that);case VenueProfileLoading():
return loading(_that);case VenueProfileSuccess():
return success(_that);case VenueProfileError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VenueProfileInitial value)?  initial,TResult? Function( VenueProfileLoading value)?  loading,TResult? Function( VenueProfileSuccess value)?  success,TResult? Function( VenueProfileError value)?  error,}){
final _that = this;
switch (_that) {
case VenueProfileInitial() when initial != null:
return initial(_that);case VenueProfileLoading() when loading != null:
return loading(_that);case VenueProfileSuccess() when success != null:
return success(_that);case VenueProfileError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( VenueDetailsModel venue,  List<PitchDetailsModel> pitches)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VenueProfileInitial() when initial != null:
return initial();case VenueProfileLoading() when loading != null:
return loading();case VenueProfileSuccess() when success != null:
return success(_that.venue,_that.pitches);case VenueProfileError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( VenueDetailsModel venue,  List<PitchDetailsModel> pitches)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case VenueProfileInitial():
return initial();case VenueProfileLoading():
return loading();case VenueProfileSuccess():
return success(_that.venue,_that.pitches);case VenueProfileError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( VenueDetailsModel venue,  List<PitchDetailsModel> pitches)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case VenueProfileInitial() when initial != null:
return initial();case VenueProfileLoading() when loading != null:
return loading();case VenueProfileSuccess() when success != null:
return success(_that.venue,_that.pitches);case VenueProfileError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class VenueProfileInitial implements VenueProfileState {
  const VenueProfileInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueProfileInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VenueProfileState.initial()';
}


}




/// @nodoc


class VenueProfileLoading implements VenueProfileState {
  const VenueProfileLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueProfileLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VenueProfileState.loading()';
}


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
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueProfileSuccess&&(identical(other.venue, venue) || other.venue == venue)&&const DeepCollectionEquality().equals(other._pitches, _pitches));
}


@override
int get hashCode => Object.hash(runtimeType,venue,const DeepCollectionEquality().hash(_pitches));

@override
String toString() {
  return 'VenueProfileState.success(venue: $venue, pitches: $pitches)';
}


}

/// @nodoc
abstract mixin class $VenueProfileSuccessCopyWith<$Res> implements $VenueProfileStateCopyWith<$Res> {
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
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueProfileError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'VenueProfileState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $VenueProfileErrorCopyWith<$Res> implements $VenueProfileStateCopyWith<$Res> {
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
