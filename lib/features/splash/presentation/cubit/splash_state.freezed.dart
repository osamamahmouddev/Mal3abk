// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splash_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SplashState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState()';
}


}

/// @nodoc
class $SplashStateCopyWith<$Res>  {
$SplashStateCopyWith(SplashState _, $Res Function(SplashState) __);
}


/// Adds pattern-matching-related methods to [SplashState].
extension SplashStatePatterns on SplashState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( SplashLoading value)?  loading,TResult Function( SplashAuthenticated value)?  authenticated,TResult Function( SplashUnauthenticated value)?  unauthenticated,TResult Function( SplashLocked value)?  locked,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case SplashLoading() when loading != null:
return loading(_that);case SplashAuthenticated() when authenticated != null:
return authenticated(_that);case SplashUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case SplashLocked() when locked != null:
return locked(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( SplashLoading value)  loading,required TResult Function( SplashAuthenticated value)  authenticated,required TResult Function( SplashUnauthenticated value)  unauthenticated,required TResult Function( SplashLocked value)  locked,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case SplashLoading():
return loading(_that);case SplashAuthenticated():
return authenticated(_that);case SplashUnauthenticated():
return unauthenticated(_that);case SplashLocked():
return locked(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( SplashLoading value)?  loading,TResult? Function( SplashAuthenticated value)?  authenticated,TResult? Function( SplashUnauthenticated value)?  unauthenticated,TResult? Function( SplashLocked value)?  locked,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case SplashLoading() when loading != null:
return loading(_that);case SplashAuthenticated() when authenticated != null:
return authenticated(_that);case SplashUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case SplashLocked() when locked != null:
return locked(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( bool isVenue)?  authenticated,TResult Function()?  unauthenticated,TResult Function()?  locked,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case SplashLoading() when loading != null:
return loading();case SplashAuthenticated() when authenticated != null:
return authenticated(_that.isVenue);case SplashUnauthenticated() when unauthenticated != null:
return unauthenticated();case SplashLocked() when locked != null:
return locked();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( bool isVenue)  authenticated,required TResult Function()  unauthenticated,required TResult Function()  locked,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case SplashLoading():
return loading();case SplashAuthenticated():
return authenticated(_that.isVenue);case SplashUnauthenticated():
return unauthenticated();case SplashLocked():
return locked();case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( bool isVenue)?  authenticated,TResult? Function()?  unauthenticated,TResult? Function()?  locked,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case SplashLoading() when loading != null:
return loading();case SplashAuthenticated() when authenticated != null:
return authenticated(_that.isVenue);case SplashUnauthenticated() when unauthenticated != null:
return unauthenticated();case SplashLocked() when locked != null:
return locked();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements SplashState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState.initial()';
}


}




/// @nodoc


class SplashLoading implements SplashState {
  const SplashLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState.loading()';
}


}




/// @nodoc


class SplashAuthenticated implements SplashState {
  const SplashAuthenticated({this.isVenue = false});
  

@JsonKey() final  bool isVenue;

/// Create a copy of SplashState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplashAuthenticatedCopyWith<SplashAuthenticated> get copyWith => _$SplashAuthenticatedCopyWithImpl<SplashAuthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashAuthenticated&&(identical(other.isVenue, isVenue) || other.isVenue == isVenue));
}


@override
int get hashCode => Object.hash(runtimeType,isVenue);

@override
String toString() {
  return 'SplashState.authenticated(isVenue: $isVenue)';
}


}

/// @nodoc
abstract mixin class $SplashAuthenticatedCopyWith<$Res> implements $SplashStateCopyWith<$Res> {
  factory $SplashAuthenticatedCopyWith(SplashAuthenticated value, $Res Function(SplashAuthenticated) _then) = _$SplashAuthenticatedCopyWithImpl;
@useResult
$Res call({
 bool isVenue
});




}
/// @nodoc
class _$SplashAuthenticatedCopyWithImpl<$Res>
    implements $SplashAuthenticatedCopyWith<$Res> {
  _$SplashAuthenticatedCopyWithImpl(this._self, this._then);

  final SplashAuthenticated _self;
  final $Res Function(SplashAuthenticated) _then;

/// Create a copy of SplashState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isVenue = null,}) {
  return _then(SplashAuthenticated(
isVenue: null == isVenue ? _self.isVenue : isVenue // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SplashUnauthenticated implements SplashState {
  const SplashUnauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashUnauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState.unauthenticated()';
}


}




/// @nodoc


class SplashLocked implements SplashState {
  const SplashLocked();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashLocked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState.locked()';
}


}




// dart format on
