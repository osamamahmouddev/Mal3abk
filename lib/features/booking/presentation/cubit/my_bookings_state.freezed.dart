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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( PlayerBookingsPagedListModel data)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MyBookingsInitial() when initial != null:
return initial();case MyBookingsLoading() when loading != null:
return loading();case MyBookingsSuccess() when success != null:
return success(_that.data);case MyBookingsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( PlayerBookingsPagedListModel data)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case MyBookingsInitial():
return initial();case MyBookingsLoading():
return loading();case MyBookingsSuccess():
return success(_that.data);case MyBookingsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( PlayerBookingsPagedListModel data)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case MyBookingsInitial() when initial != null:
return initial();case MyBookingsLoading() when loading != null:
return loading();case MyBookingsSuccess() when success != null:
return success(_that.data);case MyBookingsError() when error != null:
return error(_that.message);case _:
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
  const MyBookingsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyBookingsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyBookingsState.loading()';
}


}




/// @nodoc


class MyBookingsSuccess implements MyBookingsState {
  const MyBookingsSuccess(this.data);
  

 final  PlayerBookingsPagedListModel data;

/// Create a copy of MyBookingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyBookingsSuccessCopyWith<MyBookingsSuccess> get copyWith => _$MyBookingsSuccessCopyWithImpl<MyBookingsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyBookingsSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'MyBookingsState.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $MyBookingsSuccessCopyWith<$Res> implements $MyBookingsStateCopyWith<$Res> {
  factory $MyBookingsSuccessCopyWith(MyBookingsSuccess value, $Res Function(MyBookingsSuccess) _then) = _$MyBookingsSuccessCopyWithImpl;
@useResult
$Res call({
 PlayerBookingsPagedListModel data
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
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(MyBookingsSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PlayerBookingsPagedListModel,
  ));
}


}

/// @nodoc


class MyBookingsError implements MyBookingsState {
  const MyBookingsError(this.message);
  

 final  String message;

/// Create a copy of MyBookingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyBookingsErrorCopyWith<MyBookingsError> get copyWith => _$MyBookingsErrorCopyWithImpl<MyBookingsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyBookingsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MyBookingsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $MyBookingsErrorCopyWith<$Res> implements $MyBookingsStateCopyWith<$Res> {
  factory $MyBookingsErrorCopyWith(MyBookingsError value, $Res Function(MyBookingsError) _then) = _$MyBookingsErrorCopyWithImpl;
@useResult
$Res call({
 String message
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
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MyBookingsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
