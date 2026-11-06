// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'avatar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AvatarState {

 String? get avatarUrl;
/// Create a copy of AvatarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarStateCopyWith<AvatarState> get copyWith => _$AvatarStateCopyWithImpl<AvatarState>(this as AvatarState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarState&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,avatarUrl);

@override
String toString() {
  return 'AvatarState(avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $AvatarStateCopyWith<$Res>  {
  factory $AvatarStateCopyWith(AvatarState value, $Res Function(AvatarState) _then) = _$AvatarStateCopyWithImpl;
@useResult
$Res call({
 String? avatarUrl
});




}
/// @nodoc
class _$AvatarStateCopyWithImpl<$Res>
    implements $AvatarStateCopyWith<$Res> {
  _$AvatarStateCopyWithImpl(this._self, this._then);

  final AvatarState _self;
  final $Res Function(AvatarState) _then;

/// Create a copy of AvatarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AvatarState].
extension AvatarStatePatterns on AvatarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AvatarIdle value)?  idle,TResult Function( AvatarUploading value)?  uploading,TResult Function( AvatarError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AvatarIdle() when idle != null:
return idle(_that);case AvatarUploading() when uploading != null:
return uploading(_that);case AvatarError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AvatarIdle value)  idle,required TResult Function( AvatarUploading value)  uploading,required TResult Function( AvatarError value)  error,}){
final _that = this;
switch (_that) {
case AvatarIdle():
return idle(_that);case AvatarUploading():
return uploading(_that);case AvatarError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AvatarIdle value)?  idle,TResult? Function( AvatarUploading value)?  uploading,TResult? Function( AvatarError value)?  error,}){
final _that = this;
switch (_that) {
case AvatarIdle() when idle != null:
return idle(_that);case AvatarUploading() when uploading != null:
return uploading(_that);case AvatarError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? avatarUrl)?  idle,TResult Function( String? avatarUrl)?  uploading,TResult Function( String message,  String? avatarUrl)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AvatarIdle() when idle != null:
return idle(_that.avatarUrl);case AvatarUploading() when uploading != null:
return uploading(_that.avatarUrl);case AvatarError() when error != null:
return error(_that.message,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? avatarUrl)  idle,required TResult Function( String? avatarUrl)  uploading,required TResult Function( String message,  String? avatarUrl)  error,}) {final _that = this;
switch (_that) {
case AvatarIdle():
return idle(_that.avatarUrl);case AvatarUploading():
return uploading(_that.avatarUrl);case AvatarError():
return error(_that.message,_that.avatarUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? avatarUrl)?  idle,TResult? Function( String? avatarUrl)?  uploading,TResult? Function( String message,  String? avatarUrl)?  error,}) {final _that = this;
switch (_that) {
case AvatarIdle() when idle != null:
return idle(_that.avatarUrl);case AvatarUploading() when uploading != null:
return uploading(_that.avatarUrl);case AvatarError() when error != null:
return error(_that.message,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc


class AvatarIdle implements AvatarState {
  const AvatarIdle({this.avatarUrl});
  

@override final  String? avatarUrl;

/// Create a copy of AvatarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarIdleCopyWith<AvatarIdle> get copyWith => _$AvatarIdleCopyWithImpl<AvatarIdle>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarIdle&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,avatarUrl);

@override
String toString() {
  return 'AvatarState.idle(avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $AvatarIdleCopyWith<$Res> implements $AvatarStateCopyWith<$Res> {
  factory $AvatarIdleCopyWith(AvatarIdle value, $Res Function(AvatarIdle) _then) = _$AvatarIdleCopyWithImpl;
@override @useResult
$Res call({
 String? avatarUrl
});




}
/// @nodoc
class _$AvatarIdleCopyWithImpl<$Res>
    implements $AvatarIdleCopyWith<$Res> {
  _$AvatarIdleCopyWithImpl(this._self, this._then);

  final AvatarIdle _self;
  final $Res Function(AvatarIdle) _then;

/// Create a copy of AvatarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? avatarUrl = freezed,}) {
  return _then(AvatarIdle(
avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class AvatarUploading implements AvatarState {
  const AvatarUploading({this.avatarUrl});
  

@override final  String? avatarUrl;

/// Create a copy of AvatarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarUploadingCopyWith<AvatarUploading> get copyWith => _$AvatarUploadingCopyWithImpl<AvatarUploading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploading&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,avatarUrl);

@override
String toString() {
  return 'AvatarState.uploading(avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $AvatarUploadingCopyWith<$Res> implements $AvatarStateCopyWith<$Res> {
  factory $AvatarUploadingCopyWith(AvatarUploading value, $Res Function(AvatarUploading) _then) = _$AvatarUploadingCopyWithImpl;
@override @useResult
$Res call({
 String? avatarUrl
});




}
/// @nodoc
class _$AvatarUploadingCopyWithImpl<$Res>
    implements $AvatarUploadingCopyWith<$Res> {
  _$AvatarUploadingCopyWithImpl(this._self, this._then);

  final AvatarUploading _self;
  final $Res Function(AvatarUploading) _then;

/// Create a copy of AvatarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? avatarUrl = freezed,}) {
  return _then(AvatarUploading(
avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class AvatarError implements AvatarState {
  const AvatarError(this.message, {this.avatarUrl});
  

 final  String message;
@override final  String? avatarUrl;

/// Create a copy of AvatarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarErrorCopyWith<AvatarError> get copyWith => _$AvatarErrorCopyWithImpl<AvatarError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarError&&(identical(other.message, message) || other.message == message)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,message,avatarUrl);

@override
String toString() {
  return 'AvatarState.error(message: $message, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $AvatarErrorCopyWith<$Res> implements $AvatarStateCopyWith<$Res> {
  factory $AvatarErrorCopyWith(AvatarError value, $Res Function(AvatarError) _then) = _$AvatarErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, String? avatarUrl
});




}
/// @nodoc
class _$AvatarErrorCopyWithImpl<$Res>
    implements $AvatarErrorCopyWith<$Res> {
  _$AvatarErrorCopyWithImpl(this._self, this._then);

  final AvatarError _self;
  final $Res Function(AvatarError) _then;

/// Create a copy of AvatarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? avatarUrl = freezed,}) {
  return _then(AvatarError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
