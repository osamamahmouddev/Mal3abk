// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_bookings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueBookingsState {

 VenueBookingsQuery get query;
/// Create a copy of VenueBookingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueBookingsStateCopyWith<VenueBookingsState> get copyWith => _$VenueBookingsStateCopyWithImpl<VenueBookingsState>(this as VenueBookingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueBookingsState&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'VenueBookingsState(query: $query)';
}


}

/// @nodoc
abstract mixin class $VenueBookingsStateCopyWith<$Res>  {
  factory $VenueBookingsStateCopyWith(VenueBookingsState value, $Res Function(VenueBookingsState) _then) = _$VenueBookingsStateCopyWithImpl;
@useResult
$Res call({
 VenueBookingsQuery query
});




}
/// @nodoc
class _$VenueBookingsStateCopyWithImpl<$Res>
    implements $VenueBookingsStateCopyWith<$Res> {
  _$VenueBookingsStateCopyWithImpl(this._self, this._then);

  final VenueBookingsState _self;
  final $Res Function(VenueBookingsState) _then;

/// Create a copy of VenueBookingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as VenueBookingsQuery,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueBookingsState].
extension VenueBookingsStatePatterns on VenueBookingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VenueBookingsLoading value)?  loading,TResult Function( VenueBookingsSuccess value)?  success,TResult Function( VenueBookingsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VenueBookingsLoading() when loading != null:
return loading(_that);case VenueBookingsSuccess() when success != null:
return success(_that);case VenueBookingsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VenueBookingsLoading value)  loading,required TResult Function( VenueBookingsSuccess value)  success,required TResult Function( VenueBookingsError value)  error,}){
final _that = this;
switch (_that) {
case VenueBookingsLoading():
return loading(_that);case VenueBookingsSuccess():
return success(_that);case VenueBookingsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VenueBookingsLoading value)?  loading,TResult? Function( VenueBookingsSuccess value)?  success,TResult? Function( VenueBookingsError value)?  error,}){
final _that = this;
switch (_that) {
case VenueBookingsLoading() when loading != null:
return loading(_that);case VenueBookingsSuccess() when success != null:
return success(_that);case VenueBookingsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( VenueBookingsQuery query)?  loading,TResult Function( VenueBookingsQuery query,  List<VenueBookingItemModel> items,  int totalCount,  int page,  Map<VenueBookingsTab, int> counts,  bool isLoadingMore,  String? actionBookingId)?  success,TResult Function( VenueBookingsQuery query,  String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VenueBookingsLoading() when loading != null:
return loading(_that.query);case VenueBookingsSuccess() when success != null:
return success(_that.query,_that.items,_that.totalCount,_that.page,_that.counts,_that.isLoadingMore,_that.actionBookingId);case VenueBookingsError() when error != null:
return error(_that.query,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( VenueBookingsQuery query)  loading,required TResult Function( VenueBookingsQuery query,  List<VenueBookingItemModel> items,  int totalCount,  int page,  Map<VenueBookingsTab, int> counts,  bool isLoadingMore,  String? actionBookingId)  success,required TResult Function( VenueBookingsQuery query,  String message)  error,}) {final _that = this;
switch (_that) {
case VenueBookingsLoading():
return loading(_that.query);case VenueBookingsSuccess():
return success(_that.query,_that.items,_that.totalCount,_that.page,_that.counts,_that.isLoadingMore,_that.actionBookingId);case VenueBookingsError():
return error(_that.query,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( VenueBookingsQuery query)?  loading,TResult? Function( VenueBookingsQuery query,  List<VenueBookingItemModel> items,  int totalCount,  int page,  Map<VenueBookingsTab, int> counts,  bool isLoadingMore,  String? actionBookingId)?  success,TResult? Function( VenueBookingsQuery query,  String message)?  error,}) {final _that = this;
switch (_that) {
case VenueBookingsLoading() when loading != null:
return loading(_that.query);case VenueBookingsSuccess() when success != null:
return success(_that.query,_that.items,_that.totalCount,_that.page,_that.counts,_that.isLoadingMore,_that.actionBookingId);case VenueBookingsError() when error != null:
return error(_that.query,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class VenueBookingsLoading implements VenueBookingsState {
  const VenueBookingsLoading({required this.query});
  

@override final  VenueBookingsQuery query;

/// Create a copy of VenueBookingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueBookingsLoadingCopyWith<VenueBookingsLoading> get copyWith => _$VenueBookingsLoadingCopyWithImpl<VenueBookingsLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueBookingsLoading&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'VenueBookingsState.loading(query: $query)';
}


}

/// @nodoc
abstract mixin class $VenueBookingsLoadingCopyWith<$Res> implements $VenueBookingsStateCopyWith<$Res> {
  factory $VenueBookingsLoadingCopyWith(VenueBookingsLoading value, $Res Function(VenueBookingsLoading) _then) = _$VenueBookingsLoadingCopyWithImpl;
@override @useResult
$Res call({
 VenueBookingsQuery query
});




}
/// @nodoc
class _$VenueBookingsLoadingCopyWithImpl<$Res>
    implements $VenueBookingsLoadingCopyWith<$Res> {
  _$VenueBookingsLoadingCopyWithImpl(this._self, this._then);

  final VenueBookingsLoading _self;
  final $Res Function(VenueBookingsLoading) _then;

/// Create a copy of VenueBookingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(VenueBookingsLoading(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as VenueBookingsQuery,
  ));
}


}

/// @nodoc


class VenueBookingsSuccess implements VenueBookingsState {
  const VenueBookingsSuccess({required this.query, required final  List<VenueBookingItemModel> items, required this.totalCount, required this.page, final  Map<VenueBookingsTab, int> counts = const {}, this.isLoadingMore = false, this.actionBookingId}): _items = items,_counts = counts;
  

@override final  VenueBookingsQuery query;
 final  List<VenueBookingItemModel> _items;
 List<VenueBookingItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  int totalCount;
 final  int page;
 final  Map<VenueBookingsTab, int> _counts;
@JsonKey() Map<VenueBookingsTab, int> get counts {
  if (_counts is EqualUnmodifiableMapView) return _counts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_counts);
}

@JsonKey() final  bool isLoadingMore;
 final  String? actionBookingId;

/// Create a copy of VenueBookingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueBookingsSuccessCopyWith<VenueBookingsSuccess> get copyWith => _$VenueBookingsSuccessCopyWithImpl<VenueBookingsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueBookingsSuccess&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.page, page) || other.page == page)&&const DeepCollectionEquality().equals(other._counts, _counts)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.actionBookingId, actionBookingId) || other.actionBookingId == actionBookingId));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_items),totalCount,page,const DeepCollectionEquality().hash(_counts),isLoadingMore,actionBookingId);

@override
String toString() {
  return 'VenueBookingsState.success(query: $query, items: $items, totalCount: $totalCount, page: $page, counts: $counts, isLoadingMore: $isLoadingMore, actionBookingId: $actionBookingId)';
}


}

/// @nodoc
abstract mixin class $VenueBookingsSuccessCopyWith<$Res> implements $VenueBookingsStateCopyWith<$Res> {
  factory $VenueBookingsSuccessCopyWith(VenueBookingsSuccess value, $Res Function(VenueBookingsSuccess) _then) = _$VenueBookingsSuccessCopyWithImpl;
@override @useResult
$Res call({
 VenueBookingsQuery query, List<VenueBookingItemModel> items, int totalCount, int page, Map<VenueBookingsTab, int> counts, bool isLoadingMore, String? actionBookingId
});




}
/// @nodoc
class _$VenueBookingsSuccessCopyWithImpl<$Res>
    implements $VenueBookingsSuccessCopyWith<$Res> {
  _$VenueBookingsSuccessCopyWithImpl(this._self, this._then);

  final VenueBookingsSuccess _self;
  final $Res Function(VenueBookingsSuccess) _then;

/// Create a copy of VenueBookingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? items = null,Object? totalCount = null,Object? page = null,Object? counts = null,Object? isLoadingMore = null,Object? actionBookingId = freezed,}) {
  return _then(VenueBookingsSuccess(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as VenueBookingsQuery,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<VenueBookingItemModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,counts: null == counts ? _self._counts : counts // ignore: cast_nullable_to_non_nullable
as Map<VenueBookingsTab, int>,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,actionBookingId: freezed == actionBookingId ? _self.actionBookingId : actionBookingId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class VenueBookingsError implements VenueBookingsState {
  const VenueBookingsError({required this.query, required this.message});
  

@override final  VenueBookingsQuery query;
 final  String message;

/// Create a copy of VenueBookingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueBookingsErrorCopyWith<VenueBookingsError> get copyWith => _$VenueBookingsErrorCopyWithImpl<VenueBookingsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueBookingsError&&(identical(other.query, query) || other.query == query)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,query,message);

@override
String toString() {
  return 'VenueBookingsState.error(query: $query, message: $message)';
}


}

/// @nodoc
abstract mixin class $VenueBookingsErrorCopyWith<$Res> implements $VenueBookingsStateCopyWith<$Res> {
  factory $VenueBookingsErrorCopyWith(VenueBookingsError value, $Res Function(VenueBookingsError) _then) = _$VenueBookingsErrorCopyWithImpl;
@override @useResult
$Res call({
 VenueBookingsQuery query, String message
});




}
/// @nodoc
class _$VenueBookingsErrorCopyWithImpl<$Res>
    implements $VenueBookingsErrorCopyWith<$Res> {
  _$VenueBookingsErrorCopyWithImpl(this._self, this._then);

  final VenueBookingsError _self;
  final $Res Function(VenueBookingsError) _then;

/// Create a copy of VenueBookingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? message = null,}) {
  return _then(VenueBookingsError(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as VenueBookingsQuery,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
