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


/// @nodoc


class MyBookingsInitial implements MyBookingsState {
  const MyBookingsInitial();
  

@override
String toString() {
  return 'MyBookingsState.initial()';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyBookingsInitial);
}

@override
int get hashCode => runtimeType.hashCode;

}




/// @nodoc


class MyBookingsLoading implements MyBookingsState {
  const MyBookingsLoading();
  

@override
String toString() {
  return 'MyBookingsState.loading()';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyBookingsLoading);
}

@override
int get hashCode => runtimeType.hashCode;

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
String toString() {
  return 'MyBookingsState.success(data: $data)';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyBookingsSuccess&&(identical(other.data, data) || other.data == data));
}

@override
int get hashCode => Object.hash(runtimeType,data);

}

/// @nodoc
abstract class $MyBookingsSuccessCopyWith<$Res> implements $MyBookingsStateCopyWith<$Res> {
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
String toString() {
  return 'MyBookingsState.error(message: $message)';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyBookingsError&&(identical(other.message, message) || other.message == message));
}

@override
int get hashCode => Object.hash(runtimeType,message);

}

/// @nodoc
abstract class $MyBookingsErrorCopyWith<$Res> implements $MyBookingsStateCopyWith<$Res> {
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
