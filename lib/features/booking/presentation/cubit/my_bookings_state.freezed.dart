// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_bookings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyBookingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyBookingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyBookingsState()';
}


}

/// @nodoc
class $MyBookingsStateCopyWith<$Res>  {
$MyBookingsStateCopyWith(MyBookingsState _, $Res Function(MyBookingsState) __);
}


/// Adds pattern-matching-related methods to [MyBookingsState].
extension MyBookingsStatePatterns on MyBookingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MyBookingsInitial value)?  initial,TResult Function( MyBookingsLoading value)?  loading,TResult Function( MyBookingsSuccess value)?  success,TResult Function( MyBookingsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MyBookingsInitial() when initial != null:
return initial(_that);case MyBookingsLoading() when loading != null:
return loading(_that);case MyBookingsSuccess() when success != null:
return success(_that);case MyBookingsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MyBookingsInitial value)  initial,required TResult Function( MyBookingsLoading value)  loading,required TResult Function( MyBookingsSuccess value)  success,required TResult Function( MyBookingsError value)  error,}){
final _that = this;
switch (_that) {
case MyBookingsInitial():
return initial(_that);case MyBookingsLoading():
return loading(_that);case MyBookingsSuccess():
return success(_that);case MyBookingsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MyBookingsInitial value)?  initial,TResult? Function( MyBookingsLoading value)?  loading,TResult? Function( MyBookingsSuccess value)?  success,TResult? Function( MyBookingsError value)?  error,}){
final _that = this;
switch (_that) {
case MyBookingsInitial() when initial != null:
return initial(_that);case MyBookingsLoading() when loading != null:
return loading(_that);case MyBookingsSuccess() when success != null:
return success(_that);case MyBookingsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( MyBookingsTab tab)?  loading,TResult Function( MyBookingsTab tab,  List<PlayerBookingSummaryModel> items,  int page,  bool hasMore,  bool isLoadingMore)?  success,TResult Function( MyBookingsTab tab,  String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MyBookingsInitial() when initial != null:
return initial();case MyBookingsLoading() when loading != null:
return loading(_that.tab);case MyBookingsSuccess() when success != null:
return success(_that.tab,_that.items,_that.page,_that.hasMore,_that.isLoadingMore);case MyBookingsError() when error != null:
return error(_that.tab,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( MyBookingsTab tab)  loading,required TResult Function( MyBookingsTab tab,  List<PlayerBookingSummaryModel> items,  int page,  bool hasMore,  bool isLoadingMore)  success,required TResult Function( MyBookingsTab tab,  String message)  error,}) {final _that = this;
switch (_that) {
case MyBookingsInitial():
return initial();case MyBookingsLoading():
return loading(_that.tab);case MyBookingsSuccess():
return success(_that.tab,_that.items,_that.page,_that.hasMore,_that.isLoadingMore);case MyBookingsError():
return error(_that.tab,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( MyBookingsTab tab)?  loading,TResult? Function( MyBookingsTab tab,  List<PlayerBookingSummaryModel> items,  int page,  bool hasMore,  bool isLoadingMore)?  success,TResult? Function( MyBookingsTab tab,  String message)?  error,}) {final _that = this;
switch (_that) {
case MyBookingsInitial() when initial != null:
return initial();case MyBookingsLoading() when loading != null:
return loading(_that.tab);case MyBookingsSuccess() when success != null:
return success(_that.tab,_that.items,_that.page,_that.hasMore,_that.isLoadingMore);case MyBookingsError() when error != null:
return error(_that.tab,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class MyBookingsInitial implements MyBookingsState {
  const MyBookingsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyBookingsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyBookingsState.initial()';
}


}




/// @nodoc


class MyBookingsLoading implements MyBookingsState {
  const MyBookingsLoading(this.tab);
  

 final  MyBookingsTab tab;

/// Create a copy of MyBookingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyBookingsLoadingCopyWith<MyBookingsLoading> get copyWith => _$MyBookingsLoadingCopyWithImpl<MyBookingsLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyBookingsLoading&&(identical(other.tab, tab) || other.tab == tab));
}


@override
int get hashCode => Object.hash(runtimeType,tab);

@override
String toString() {
  return 'MyBookingsState.loading(tab: $tab)';
}


}

/// @nodoc
abstract mixin class $MyBookingsLoadingCopyWith<$Res> implements $MyBookingsStateCopyWith<$Res> {
  factory $MyBookingsLoadingCopyWith(MyBookingsLoading value, $Res Function(MyBookingsLoading) _then) = _$MyBookingsLoadingCopyWithImpl;
@useResult
$Res call({
 MyBookingsTab tab
});




}
/// @nodoc
class _$MyBookingsLoadingCopyWithImpl<$Res>
    implements $MyBookingsLoadingCopyWith<$Res> {
  _$MyBookingsLoadingCopyWithImpl(this._self, this._then);

  final MyBookingsLoading _self;
  final $Res Function(MyBookingsLoading) _then;

/// Create a copy of MyBookingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tab = null,}) {
  return _then(MyBookingsLoading(
null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as MyBookingsTab,
  ));
}


}

/// @nodoc


class MyBookingsSuccess implements MyBookingsState {
  const MyBookingsSuccess({required this.tab, required final  List<PlayerBookingSummaryModel> items, required this.page, required this.hasMore, this.isLoadingMore = false}): _items = items;
  

 final  MyBookingsTab tab;
 final  List<PlayerBookingSummaryModel> _items;
 List<PlayerBookingSummaryModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  int page;
 final  bool hasMore;
@JsonKey() final  bool isLoadingMore;

/// Create a copy of MyBookingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyBookingsSuccessCopyWith<MyBookingsSuccess> get copyWith => _$MyBookingsSuccessCopyWithImpl<MyBookingsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyBookingsSuccess&&(identical(other.tab, tab) || other.tab == tab)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,tab,const DeepCollectionEquality().hash(_items),page,hasMore,isLoadingMore);

@override
String toString() {
  return 'MyBookingsState.success(tab: $tab, items: $items, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $MyBookingsSuccessCopyWith<$Res> implements $MyBookingsStateCopyWith<$Res> {
  factory $MyBookingsSuccessCopyWith(MyBookingsSuccess value, $Res Function(MyBookingsSuccess) _then) = _$MyBookingsSuccessCopyWithImpl;
@useResult
$Res call({
 MyBookingsTab tab, List<PlayerBookingSummaryModel> items, int page, bool hasMore, bool isLoadingMore
});




}
/// @nodoc
class _$MyBookingsSuccessCopyWithImpl<$Res>
    implements $MyBookingsSuccessCopyWith<$Res> {
  _$MyBookingsSuccessCopyWithImpl(this._self, this._then);

  final MyBookingsSuccess _self;
  final $Res Function(MyBookingsSuccess) _then;

/// Create a copy of MyBookingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tab = null,Object? items = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,}) {
  return _then(MyBookingsSuccess(
tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as MyBookingsTab,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PlayerBookingSummaryModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class MyBookingsError implements MyBookingsState {
  const MyBookingsError(this.tab, this.message);
  

 final  MyBookingsTab tab;
 final  String message;

/// Create a copy of MyBookingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyBookingsErrorCopyWith<MyBookingsError> get copyWith => _$MyBookingsErrorCopyWithImpl<MyBookingsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyBookingsError&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,tab,message);

@override
String toString() {
  return 'MyBookingsState.error(tab: $tab, message: $message)';
}


}

/// @nodoc
abstract mixin class $MyBookingsErrorCopyWith<$Res> implements $MyBookingsStateCopyWith<$Res> {
  factory $MyBookingsErrorCopyWith(MyBookingsError value, $Res Function(MyBookingsError) _then) = _$MyBookingsErrorCopyWithImpl;
@useResult
$Res call({
 MyBookingsTab tab, String message
});




}
/// @nodoc
class _$MyBookingsErrorCopyWithImpl<$Res>
    implements $MyBookingsErrorCopyWith<$Res> {
  _$MyBookingsErrorCopyWithImpl(this._self, this._then);

  final MyBookingsError _self;
  final $Res Function(MyBookingsError) _then;

/// Create a copy of MyBookingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tab = null,Object? message = null,}) {
  return _then(MyBookingsError(
null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as MyBookingsTab,null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
