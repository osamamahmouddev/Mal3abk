// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueSessionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueSessionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VenueSessionState()';
}


}

/// @nodoc
class $VenueSessionStateCopyWith<$Res>  {
$VenueSessionStateCopyWith(VenueSessionState _, $Res Function(VenueSessionState) __);
}


/// Adds pattern-matching-related methods to [VenueSessionState].
extension VenueSessionStatePatterns on VenueSessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VenueSessionLoading value)?  loading,TResult Function( VenueSessionReady value)?  ready,TResult Function( VenueSessionNoVenue value)?  noVenue,TResult Function( VenueSessionError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VenueSessionLoading() when loading != null:
return loading(_that);case VenueSessionReady() when ready != null:
return ready(_that);case VenueSessionNoVenue() when noVenue != null:
return noVenue(_that);case VenueSessionError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VenueSessionLoading value)  loading,required TResult Function( VenueSessionReady value)  ready,required TResult Function( VenueSessionNoVenue value)  noVenue,required TResult Function( VenueSessionError value)  error,}){
final _that = this;
switch (_that) {
case VenueSessionLoading():
return loading(_that);case VenueSessionReady():
return ready(_that);case VenueSessionNoVenue():
return noVenue(_that);case VenueSessionError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VenueSessionLoading value)?  loading,TResult? Function( VenueSessionReady value)?  ready,TResult? Function( VenueSessionNoVenue value)?  noVenue,TResult? Function( VenueSessionError value)?  error,}){
final _that = this;
switch (_that) {
case VenueSessionLoading() when loading != null:
return loading(_that);case VenueSessionReady() when ready != null:
return ready(_that);case VenueSessionNoVenue() when noVenue != null:
return noVenue(_that);case VenueSessionError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<VenueModel> venues,  VenueModel venue,  Set<String> permissions,  String accessLevel)?  ready,TResult Function()?  noVenue,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VenueSessionLoading() when loading != null:
return loading();case VenueSessionReady() when ready != null:
return ready(_that.venues,_that.venue,_that.permissions,_that.accessLevel);case VenueSessionNoVenue() when noVenue != null:
return noVenue();case VenueSessionError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<VenueModel> venues,  VenueModel venue,  Set<String> permissions,  String accessLevel)  ready,required TResult Function()  noVenue,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case VenueSessionLoading():
return loading();case VenueSessionReady():
return ready(_that.venues,_that.venue,_that.permissions,_that.accessLevel);case VenueSessionNoVenue():
return noVenue();case VenueSessionError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<VenueModel> venues,  VenueModel venue,  Set<String> permissions,  String accessLevel)?  ready,TResult? Function()?  noVenue,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case VenueSessionLoading() when loading != null:
return loading();case VenueSessionReady() when ready != null:
return ready(_that.venues,_that.venue,_that.permissions,_that.accessLevel);case VenueSessionNoVenue() when noVenue != null:
return noVenue();case VenueSessionError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class VenueSessionLoading implements VenueSessionState {
  const VenueSessionLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueSessionLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VenueSessionState.loading()';
}


}




/// @nodoc


class VenueSessionReady implements VenueSessionState {
  const VenueSessionReady({required final  List<VenueModel> venues, required this.venue, required final  Set<String> permissions, required this.accessLevel}): _venues = venues,_permissions = permissions;
  

 final  List<VenueModel> _venues;
 List<VenueModel> get venues {
  if (_venues is EqualUnmodifiableListView) return _venues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_venues);
}

 final  VenueModel venue;
 final  Set<String> _permissions;
 Set<String> get permissions {
  if (_permissions is EqualUnmodifiableSetView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_permissions);
}

 final  String accessLevel;

/// Create a copy of VenueSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueSessionReadyCopyWith<VenueSessionReady> get copyWith => _$VenueSessionReadyCopyWithImpl<VenueSessionReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueSessionReady&&const DeepCollectionEquality().equals(other._venues, _venues)&&(identical(other.venue, venue) || other.venue == venue)&&const DeepCollectionEquality().equals(other._permissions, _permissions)&&(identical(other.accessLevel, accessLevel) || other.accessLevel == accessLevel));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_venues),venue,const DeepCollectionEquality().hash(_permissions),accessLevel);

@override
String toString() {
  return 'VenueSessionState.ready(venues: $venues, venue: $venue, permissions: $permissions, accessLevel: $accessLevel)';
}


}

/// @nodoc
abstract mixin class $VenueSessionReadyCopyWith<$Res> implements $VenueSessionStateCopyWith<$Res> {
  factory $VenueSessionReadyCopyWith(VenueSessionReady value, $Res Function(VenueSessionReady) _then) = _$VenueSessionReadyCopyWithImpl;
@useResult
$Res call({
 List<VenueModel> venues, VenueModel venue, Set<String> permissions, String accessLevel
});




}
/// @nodoc
class _$VenueSessionReadyCopyWithImpl<$Res>
    implements $VenueSessionReadyCopyWith<$Res> {
  _$VenueSessionReadyCopyWithImpl(this._self, this._then);

  final VenueSessionReady _self;
  final $Res Function(VenueSessionReady) _then;

/// Create a copy of VenueSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? venues = null,Object? venue = null,Object? permissions = null,Object? accessLevel = null,}) {
  return _then(VenueSessionReady(
venues: null == venues ? _self._venues : venues // ignore: cast_nullable_to_non_nullable
as List<VenueModel>,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as VenueModel,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as Set<String>,accessLevel: null == accessLevel ? _self.accessLevel : accessLevel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VenueSessionNoVenue implements VenueSessionState {
  const VenueSessionNoVenue();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueSessionNoVenue);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VenueSessionState.noVenue()';
}


}




/// @nodoc


class VenueSessionError implements VenueSessionState {
  const VenueSessionError(this.message);
  

 final  String message;

/// Create a copy of VenueSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueSessionErrorCopyWith<VenueSessionError> get copyWith => _$VenueSessionErrorCopyWithImpl<VenueSessionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueSessionError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'VenueSessionState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $VenueSessionErrorCopyWith<$Res> implements $VenueSessionStateCopyWith<$Res> {
  factory $VenueSessionErrorCopyWith(VenueSessionError value, $Res Function(VenueSessionError) _then) = _$VenueSessionErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$VenueSessionErrorCopyWithImpl<$Res>
    implements $VenueSessionErrorCopyWith<$Res> {
  _$VenueSessionErrorCopyWithImpl(this._self, this._then);

  final VenueSessionError _self;
  final $Res Function(VenueSessionError) _then;

/// Create a copy of VenueSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(VenueSessionError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
