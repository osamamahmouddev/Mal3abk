// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_customers_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueCustomersState {

 List<VenueCustomerModel> get items; int get totalCount; int get page; String get search; VenueCustomersFilter get filter; bool get loading; String? get error;
/// Create a copy of VenueCustomersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueCustomersStateCopyWith<VenueCustomersState> get copyWith => _$VenueCustomersStateCopyWithImpl<VenueCustomersState>(this as VenueCustomersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueCustomersState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.page, page) || other.page == page)&&(identical(other.search, search) || other.search == search)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),totalCount,page,search,filter,loading,error);

@override
String toString() {
  return 'VenueCustomersState(items: $items, totalCount: $totalCount, page: $page, search: $search, filter: $filter, loading: $loading, error: $error)';
}


}

/// @nodoc
abstract mixin class $VenueCustomersStateCopyWith<$Res>  {
  factory $VenueCustomersStateCopyWith(VenueCustomersState value, $Res Function(VenueCustomersState) _then) = _$VenueCustomersStateCopyWithImpl;
@useResult
$Res call({
 List<VenueCustomerModel> items, int totalCount, int page, String search, VenueCustomersFilter filter, bool loading, String? error
});




}
/// @nodoc
class _$VenueCustomersStateCopyWithImpl<$Res>
    implements $VenueCustomersStateCopyWith<$Res> {
  _$VenueCustomersStateCopyWithImpl(this._self, this._then);

  final VenueCustomersState _self;
  final $Res Function(VenueCustomersState) _then;

/// Create a copy of VenueCustomersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalCount = null,Object? page = null,Object? search = null,Object? filter = null,Object? loading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<VenueCustomerModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as VenueCustomersFilter,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueCustomersState].
extension VenueCustomersStatePatterns on VenueCustomersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueCustomersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueCustomersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueCustomersState value)  $default,){
final _that = this;
switch (_that) {
case _VenueCustomersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueCustomersState value)?  $default,){
final _that = this;
switch (_that) {
case _VenueCustomersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VenueCustomerModel> items,  int totalCount,  int page,  String search,  VenueCustomersFilter filter,  bool loading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueCustomersState() when $default != null:
return $default(_that.items,_that.totalCount,_that.page,_that.search,_that.filter,_that.loading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VenueCustomerModel> items,  int totalCount,  int page,  String search,  VenueCustomersFilter filter,  bool loading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _VenueCustomersState():
return $default(_that.items,_that.totalCount,_that.page,_that.search,_that.filter,_that.loading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VenueCustomerModel> items,  int totalCount,  int page,  String search,  VenueCustomersFilter filter,  bool loading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _VenueCustomersState() when $default != null:
return $default(_that.items,_that.totalCount,_that.page,_that.search,_that.filter,_that.loading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _VenueCustomersState implements VenueCustomersState {
  const _VenueCustomersState({final  List<VenueCustomerModel> items = const [], this.totalCount = 0, this.page = 1, this.search = '', this.filter = VenueCustomersFilter.all, this.loading = true, this.error}): _items = items;
  

 final  List<VenueCustomerModel> _items;
@override@JsonKey() List<VenueCustomerModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int page;
@override@JsonKey() final  String search;
@override@JsonKey() final  VenueCustomersFilter filter;
@override@JsonKey() final  bool loading;
@override final  String? error;

/// Create a copy of VenueCustomersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueCustomersStateCopyWith<_VenueCustomersState> get copyWith => __$VenueCustomersStateCopyWithImpl<_VenueCustomersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueCustomersState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.page, page) || other.page == page)&&(identical(other.search, search) || other.search == search)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,page,search,filter,loading,error);

@override
String toString() {
  return 'VenueCustomersState(items: $items, totalCount: $totalCount, page: $page, search: $search, filter: $filter, loading: $loading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$VenueCustomersStateCopyWith<$Res> implements $VenueCustomersStateCopyWith<$Res> {
  factory _$VenueCustomersStateCopyWith(_VenueCustomersState value, $Res Function(_VenueCustomersState) _then) = __$VenueCustomersStateCopyWithImpl;
@override @useResult
$Res call({
 List<VenueCustomerModel> items, int totalCount, int page, String search, VenueCustomersFilter filter, bool loading, String? error
});




}
/// @nodoc
class __$VenueCustomersStateCopyWithImpl<$Res>
    implements _$VenueCustomersStateCopyWith<$Res> {
  __$VenueCustomersStateCopyWithImpl(this._self, this._then);

  final _VenueCustomersState _self;
  final $Res Function(_VenueCustomersState) _then;

/// Create a copy of VenueCustomersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? page = null,Object? search = null,Object? filter = null,Object? loading = null,Object? error = freezed,}) {
  return _then(_VenueCustomersState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<VenueCustomerModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as VenueCustomersFilter,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
