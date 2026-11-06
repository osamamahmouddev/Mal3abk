// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discover_teams_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiscoverTeamsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverTeamsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiscoverTeamsState()';
}


}

/// @nodoc
class $DiscoverTeamsStateCopyWith<$Res>  {
$DiscoverTeamsStateCopyWith(DiscoverTeamsState _, $Res Function(DiscoverTeamsState) __);
}


/// Adds pattern-matching-related methods to [DiscoverTeamsState].
extension DiscoverTeamsStatePatterns on DiscoverTeamsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DiscoverTeamsInitial value)?  initial,TResult Function( DiscoverTeamsLoading value)?  loading,TResult Function( DiscoverTeamsSuccess value)?  success,TResult Function( DiscoverTeamsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DiscoverTeamsInitial() when initial != null:
return initial(_that);case DiscoverTeamsLoading() when loading != null:
return loading(_that);case DiscoverTeamsSuccess() when success != null:
return success(_that);case DiscoverTeamsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DiscoverTeamsInitial value)  initial,required TResult Function( DiscoverTeamsLoading value)  loading,required TResult Function( DiscoverTeamsSuccess value)  success,required TResult Function( DiscoverTeamsError value)  error,}){
final _that = this;
switch (_that) {
case DiscoverTeamsInitial():
return initial(_that);case DiscoverTeamsLoading():
return loading(_that);case DiscoverTeamsSuccess():
return success(_that);case DiscoverTeamsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DiscoverTeamsInitial value)?  initial,TResult? Function( DiscoverTeamsLoading value)?  loading,TResult? Function( DiscoverTeamsSuccess value)?  success,TResult? Function( DiscoverTeamsError value)?  error,}){
final _that = this;
switch (_that) {
case DiscoverTeamsInitial() when initial != null:
return initial(_that);case DiscoverTeamsLoading() when loading != null:
return loading(_that);case DiscoverTeamsSuccess() when success != null:
return success(_that);case DiscoverTeamsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<TeamDiscoveryModel> teams,  bool hasMore,  int page)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DiscoverTeamsInitial() when initial != null:
return initial();case DiscoverTeamsLoading() when loading != null:
return loading();case DiscoverTeamsSuccess() when success != null:
return success(_that.teams,_that.hasMore,_that.page);case DiscoverTeamsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<TeamDiscoveryModel> teams,  bool hasMore,  int page)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case DiscoverTeamsInitial():
return initial();case DiscoverTeamsLoading():
return loading();case DiscoverTeamsSuccess():
return success(_that.teams,_that.hasMore,_that.page);case DiscoverTeamsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<TeamDiscoveryModel> teams,  bool hasMore,  int page)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case DiscoverTeamsInitial() when initial != null:
return initial();case DiscoverTeamsLoading() when loading != null:
return loading();case DiscoverTeamsSuccess() when success != null:
return success(_that.teams,_that.hasMore,_that.page);case DiscoverTeamsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class DiscoverTeamsInitial implements DiscoverTeamsState {
  const DiscoverTeamsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverTeamsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiscoverTeamsState.initial()';
}


}




/// @nodoc


class DiscoverTeamsLoading implements DiscoverTeamsState {
  const DiscoverTeamsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverTeamsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiscoverTeamsState.loading()';
}


}




/// @nodoc


class DiscoverTeamsSuccess implements DiscoverTeamsState {
  const DiscoverTeamsSuccess(final  List<TeamDiscoveryModel> teams, this.hasMore, this.page): _teams = teams;
  

 final  List<TeamDiscoveryModel> _teams;
 List<TeamDiscoveryModel> get teams {
  if (_teams is EqualUnmodifiableListView) return _teams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teams);
}

 final  bool hasMore;
 final  int page;

/// Create a copy of DiscoverTeamsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoverTeamsSuccessCopyWith<DiscoverTeamsSuccess> get copyWith => _$DiscoverTeamsSuccessCopyWithImpl<DiscoverTeamsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverTeamsSuccess&&const DeepCollectionEquality().equals(other._teams, _teams)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_teams),hasMore,page);

@override
String toString() {
  return 'DiscoverTeamsState.success(teams: $teams, hasMore: $hasMore, page: $page)';
}


}

/// @nodoc
abstract mixin class $DiscoverTeamsSuccessCopyWith<$Res> implements $DiscoverTeamsStateCopyWith<$Res> {
  factory $DiscoverTeamsSuccessCopyWith(DiscoverTeamsSuccess value, $Res Function(DiscoverTeamsSuccess) _then) = _$DiscoverTeamsSuccessCopyWithImpl;
@useResult
$Res call({
 List<TeamDiscoveryModel> teams, bool hasMore, int page
});




}
/// @nodoc
class _$DiscoverTeamsSuccessCopyWithImpl<$Res>
    implements $DiscoverTeamsSuccessCopyWith<$Res> {
  _$DiscoverTeamsSuccessCopyWithImpl(this._self, this._then);

  final DiscoverTeamsSuccess _self;
  final $Res Function(DiscoverTeamsSuccess) _then;

/// Create a copy of DiscoverTeamsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? teams = null,Object? hasMore = null,Object? page = null,}) {
  return _then(DiscoverTeamsSuccess(
null == teams ? _self._teams : teams // ignore: cast_nullable_to_non_nullable
as List<TeamDiscoveryModel>,null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class DiscoverTeamsError implements DiscoverTeamsState {
  const DiscoverTeamsError(this.message);
  

 final  String message;

/// Create a copy of DiscoverTeamsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoverTeamsErrorCopyWith<DiscoverTeamsError> get copyWith => _$DiscoverTeamsErrorCopyWithImpl<DiscoverTeamsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverTeamsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DiscoverTeamsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $DiscoverTeamsErrorCopyWith<$Res> implements $DiscoverTeamsStateCopyWith<$Res> {
  factory $DiscoverTeamsErrorCopyWith(DiscoverTeamsError value, $Res Function(DiscoverTeamsError) _then) = _$DiscoverTeamsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DiscoverTeamsErrorCopyWithImpl<$Res>
    implements $DiscoverTeamsErrorCopyWith<$Res> {
  _$DiscoverTeamsErrorCopyWithImpl(this._self, this._then);

  final DiscoverTeamsError _self;
  final $Res Function(DiscoverTeamsError) _then;

/// Create a copy of DiscoverTeamsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DiscoverTeamsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
