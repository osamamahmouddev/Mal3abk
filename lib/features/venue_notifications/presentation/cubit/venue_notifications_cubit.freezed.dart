// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_notifications_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueNotificationsState {

 List<NotificationModel> get items; int get unreadCount; int get page; bool get hasMore; bool get loading; bool get loadingMore; String? get error;
/// Create a copy of VenueNotificationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueNotificationsStateCopyWith<VenueNotificationsState> get copyWith => _$VenueNotificationsStateCopyWithImpl<VenueNotificationsState>(this as VenueNotificationsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueNotificationsState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),unreadCount,page,hasMore,loading,loadingMore,error);

@override
String toString() {
  return 'VenueNotificationsState(items: $items, unreadCount: $unreadCount, page: $page, hasMore: $hasMore, loading: $loading, loadingMore: $loadingMore, error: $error)';
}


}

/// @nodoc
abstract mixin class $VenueNotificationsStateCopyWith<$Res>  {
  factory $VenueNotificationsStateCopyWith(VenueNotificationsState value, $Res Function(VenueNotificationsState) _then) = _$VenueNotificationsStateCopyWithImpl;
@useResult
$Res call({
 List<NotificationModel> items, int unreadCount, int page, bool hasMore, bool loading, bool loadingMore, String? error
});




}
/// @nodoc
class _$VenueNotificationsStateCopyWithImpl<$Res>
    implements $VenueNotificationsStateCopyWith<$Res> {
  _$VenueNotificationsStateCopyWithImpl(this._self, this._then);

  final VenueNotificationsState _self;
  final $Res Function(VenueNotificationsState) _then;

/// Create a copy of VenueNotificationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? unreadCount = null,Object? page = null,Object? hasMore = null,Object? loading = null,Object? loadingMore = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<NotificationModel>,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueNotificationsState].
extension VenueNotificationsStatePatterns on VenueNotificationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueNotificationsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueNotificationsState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueNotificationsState value)  $default,){
final _that = this;
switch (_that) {
case _VenueNotificationsState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueNotificationsState value)?  $default,){
final _that = this;
switch (_that) {
case _VenueNotificationsState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NotificationModel> items,  int unreadCount,  int page,  bool hasMore,  bool loading,  bool loadingMore,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueNotificationsState() when $default != null:
return $default(_that.items,_that.unreadCount,_that.page,_that.hasMore,_that.loading,_that.loadingMore,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NotificationModel> items,  int unreadCount,  int page,  bool hasMore,  bool loading,  bool loadingMore,  String? error)  $default,) {final _that = this;
switch (_that) {
case _VenueNotificationsState():
return $default(_that.items,_that.unreadCount,_that.page,_that.hasMore,_that.loading,_that.loadingMore,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NotificationModel> items,  int unreadCount,  int page,  bool hasMore,  bool loading,  bool loadingMore,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _VenueNotificationsState() when $default != null:
return $default(_that.items,_that.unreadCount,_that.page,_that.hasMore,_that.loading,_that.loadingMore,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _VenueNotificationsState implements VenueNotificationsState {
  const _VenueNotificationsState({final  List<NotificationModel> items = const [], this.unreadCount = 0, this.page = 1, this.hasMore = false, this.loading = true, this.loadingMore = false, this.error}): _items = items;
  

 final  List<NotificationModel> _items;
@override@JsonKey() List<NotificationModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int unreadCount;
@override@JsonKey() final  int page;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool loading;
@override@JsonKey() final  bool loadingMore;
@override final  String? error;

/// Create a copy of VenueNotificationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueNotificationsStateCopyWith<_VenueNotificationsState> get copyWith => __$VenueNotificationsStateCopyWithImpl<_VenueNotificationsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueNotificationsState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),unreadCount,page,hasMore,loading,loadingMore,error);

@override
String toString() {
  return 'VenueNotificationsState(items: $items, unreadCount: $unreadCount, page: $page, hasMore: $hasMore, loading: $loading, loadingMore: $loadingMore, error: $error)';
}


}

/// @nodoc
abstract mixin class _$VenueNotificationsStateCopyWith<$Res> implements $VenueNotificationsStateCopyWith<$Res> {
  factory _$VenueNotificationsStateCopyWith(_VenueNotificationsState value, $Res Function(_VenueNotificationsState) _then) = __$VenueNotificationsStateCopyWithImpl;
@override @useResult
$Res call({
 List<NotificationModel> items, int unreadCount, int page, bool hasMore, bool loading, bool loadingMore, String? error
});




}
/// @nodoc
class __$VenueNotificationsStateCopyWithImpl<$Res>
    implements _$VenueNotificationsStateCopyWith<$Res> {
  __$VenueNotificationsStateCopyWithImpl(this._self, this._then);

  final _VenueNotificationsState _self;
  final $Res Function(_VenueNotificationsState) _then;

/// Create a copy of VenueNotificationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? unreadCount = null,Object? page = null,Object? hasMore = null,Object? loading = null,Object? loadingMore = null,Object? error = freezed,}) {
  return _then(_VenueNotificationsState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<NotificationModel>,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
