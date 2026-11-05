// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaderboardState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderboardState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LeaderboardState()';
}


}

/// @nodoc
class $LeaderboardStateCopyWith<$Res>  {
$LeaderboardStateCopyWith(LeaderboardState _, $Res Function(LeaderboardState) __);
}


/// Adds pattern-matching-related methods to [LeaderboardState].
extension LeaderboardStatePatterns on LeaderboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LeaderboardInitial value)?  initial,TResult Function( LeaderboardLoading value)?  loading,TResult Function( LeaderboardSuccess value)?  success,TResult Function( LeaderboardError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LeaderboardInitial() when initial != null:
return initial(_that);case LeaderboardLoading() when loading != null:
return loading(_that);case LeaderboardSuccess() when success != null:
return success(_that);case LeaderboardError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LeaderboardInitial value)  initial,required TResult Function( LeaderboardLoading value)  loading,required TResult Function( LeaderboardSuccess value)  success,required TResult Function( LeaderboardError value)  error,}){
final _that = this;
switch (_that) {
case LeaderboardInitial():
return initial(_that);case LeaderboardLoading():
return loading(_that);case LeaderboardSuccess():
return success(_that);case LeaderboardError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LeaderboardInitial value)?  initial,TResult? Function( LeaderboardLoading value)?  loading,TResult? Function( LeaderboardSuccess value)?  success,TResult? Function( LeaderboardError value)?  error,}){
final _that = this;
switch (_that) {
case LeaderboardInitial() when initial != null:
return initial(_that);case LeaderboardLoading() when loading != null:
return loading(_that);case LeaderboardSuccess() when success != null:
return success(_that);case LeaderboardError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<TeamLeaderboardEntryModel> entries,  bool hasMore,  int page,  String? governorate,  Set<String> myTeamIds)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LeaderboardInitial() when initial != null:
return initial();case LeaderboardLoading() when loading != null:
return loading();case LeaderboardSuccess() when success != null:
return success(_that.entries,_that.hasMore,_that.page,_that.governorate,_that.myTeamIds);case LeaderboardError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<TeamLeaderboardEntryModel> entries,  bool hasMore,  int page,  String? governorate,  Set<String> myTeamIds)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case LeaderboardInitial():
return initial();case LeaderboardLoading():
return loading();case LeaderboardSuccess():
return success(_that.entries,_that.hasMore,_that.page,_that.governorate,_that.myTeamIds);case LeaderboardError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<TeamLeaderboardEntryModel> entries,  bool hasMore,  int page,  String? governorate,  Set<String> myTeamIds)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case LeaderboardInitial() when initial != null:
return initial();case LeaderboardLoading() when loading != null:
return loading();case LeaderboardSuccess() when success != null:
return success(_that.entries,_that.hasMore,_that.page,_that.governorate,_that.myTeamIds);case LeaderboardError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class LeaderboardInitial implements LeaderboardState {
  const LeaderboardInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderboardInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LeaderboardState.initial()';
}


}




/// @nodoc


class LeaderboardLoading implements LeaderboardState {
  const LeaderboardLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderboardLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LeaderboardState.loading()';
}


}




/// @nodoc


class LeaderboardSuccess implements LeaderboardState {
  const LeaderboardSuccess(final  List<TeamLeaderboardEntryModel> entries, this.hasMore, this.page, this.governorate, final  Set<String> myTeamIds): _entries = entries,_myTeamIds = myTeamIds;
  

 final  List<TeamLeaderboardEntryModel> _entries;
 List<TeamLeaderboardEntryModel> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

 final  bool hasMore;
 final  int page;
 final  String? governorate;
 final  Set<String> _myTeamIds;
 Set<String> get myTeamIds {
  if (_myTeamIds is EqualUnmodifiableSetView) return _myTeamIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_myTeamIds);
}


/// Create a copy of LeaderboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaderboardSuccessCopyWith<LeaderboardSuccess> get copyWith => _$LeaderboardSuccessCopyWithImpl<LeaderboardSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderboardSuccess&&const DeepCollectionEquality().equals(other._entries, _entries)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.page, page) || other.page == page)&&(identical(other.governorate, governorate) || other.governorate == governorate)&&const DeepCollectionEquality().equals(other._myTeamIds, _myTeamIds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_entries),hasMore,page,governorate,const DeepCollectionEquality().hash(_myTeamIds));

@override
String toString() {
  return 'LeaderboardState.success(entries: $entries, hasMore: $hasMore, page: $page, governorate: $governorate, myTeamIds: $myTeamIds)';
}


}

/// @nodoc
abstract mixin class $LeaderboardSuccessCopyWith<$Res> implements $LeaderboardStateCopyWith<$Res> {
  factory $LeaderboardSuccessCopyWith(LeaderboardSuccess value, $Res Function(LeaderboardSuccess) _then) = _$LeaderboardSuccessCopyWithImpl;
@useResult
$Res call({
 List<TeamLeaderboardEntryModel> entries, bool hasMore, int page, String? governorate, Set<String> myTeamIds
});




}
/// @nodoc
class _$LeaderboardSuccessCopyWithImpl<$Res>
    implements $LeaderboardSuccessCopyWith<$Res> {
  _$LeaderboardSuccessCopyWithImpl(this._self, this._then);

  final LeaderboardSuccess _self;
  final $Res Function(LeaderboardSuccess) _then;

/// Create a copy of LeaderboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? entries = null,Object? hasMore = null,Object? page = null,Object? governorate = freezed,Object? myTeamIds = null,}) {
  return _then(LeaderboardSuccess(
null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<TeamLeaderboardEntryModel>,null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,freezed == governorate ? _self.governorate : governorate // ignore: cast_nullable_to_non_nullable
as String?,null == myTeamIds ? _self._myTeamIds : myTeamIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

/// @nodoc


class LeaderboardError implements LeaderboardState {
  const LeaderboardError(this.message);
  

 final  String message;

/// Create a copy of LeaderboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaderboardErrorCopyWith<LeaderboardError> get copyWith => _$LeaderboardErrorCopyWithImpl<LeaderboardError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderboardError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LeaderboardState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $LeaderboardErrorCopyWith<$Res> implements $LeaderboardStateCopyWith<$Res> {
  factory $LeaderboardErrorCopyWith(LeaderboardError value, $Res Function(LeaderboardError) _then) = _$LeaderboardErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$LeaderboardErrorCopyWithImpl<$Res>
    implements $LeaderboardErrorCopyWith<$Res> {
  _$LeaderboardErrorCopyWithImpl(this._self, this._then);

  final LeaderboardError _self;
  final $Res Function(LeaderboardError) _then;

/// Create a copy of LeaderboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(LeaderboardError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
