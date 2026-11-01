// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_feed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeFeedState {

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFeedState);
}

@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeFeedState()';
}

}

/// @nodoc
class $HomeFeedStateCopyWith<$Res>  {
$HomeFeedStateCopyWith(HomeFeedState _, $Res Function(HomeFeedState) __);
}


/// @nodoc


class HomeFeedInitial implements HomeFeedState {
  const HomeFeedInitial();
  

@override
String toString() {
  return 'HomeFeedState.initial()';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFeedInitial);
}

@override
int get hashCode => runtimeType.hashCode;

}




/// @nodoc


class HomeFeedLoading implements HomeFeedState {
  const HomeFeedLoading();
  

@override
String toString() {
  return 'HomeFeedState.loading()';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFeedLoading);
}

@override
int get hashCode => runtimeType.hashCode;

}




/// @nodoc


class HomeFeedSuccess implements HomeFeedState {
  const HomeFeedSuccess(this.feed);
  

 final  HomeFeedModel feed;

/// Create a copy of HomeFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeFeedSuccessCopyWith<HomeFeedSuccess> get copyWith => _$HomeFeedSuccessCopyWithImpl<HomeFeedSuccess>(this, _$identity);



@override
String toString() {
  return 'HomeFeedState.success(feed: $feed)';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFeedSuccess&&(identical(other.feed, feed) || other.feed == feed));
}

@override
int get hashCode => Object.hash(runtimeType,feed);

}

/// @nodoc
abstract class $HomeFeedSuccessCopyWith<$Res> implements $HomeFeedStateCopyWith<$Res> {
  factory $HomeFeedSuccessCopyWith(HomeFeedSuccess value, $Res Function(HomeFeedSuccess) _then) = _$HomeFeedSuccessCopyWithImpl;
@useResult
$Res call({
 HomeFeedModel feed
});




}
/// @nodoc
class _$HomeFeedSuccessCopyWithImpl<$Res>
    implements $HomeFeedSuccessCopyWith<$Res> {
  _$HomeFeedSuccessCopyWithImpl(this._self, this._then);

  final HomeFeedSuccess _self;
  final $Res Function(HomeFeedSuccess) _then;

/// Create a copy of HomeFeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? feed = null,}) {
  return _then(HomeFeedSuccess(
null == feed ? _self.feed : feed // ignore: cast_nullable_to_non_nullable
as HomeFeedModel,
  ));
}


}

/// @nodoc


class HomeFeedError implements HomeFeedState {
  const HomeFeedError(this.message);
  

 final  String message;

/// Create a copy of HomeFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeFeedErrorCopyWith<HomeFeedError> get copyWith => _$HomeFeedErrorCopyWithImpl<HomeFeedError>(this, _$identity);



@override
String toString() {
  return 'HomeFeedState.error(message: $message)';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFeedError&&(identical(other.message, message) || other.message == message));
}

@override
int get hashCode => Object.hash(runtimeType,message);

}

/// @nodoc
abstract class $HomeFeedErrorCopyWith<$Res> implements $HomeFeedStateCopyWith<$Res> {
  factory $HomeFeedErrorCopyWith(HomeFeedError value, $Res Function(HomeFeedError) _then) = _$HomeFeedErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$HomeFeedErrorCopyWithImpl<$Res>
    implements $HomeFeedErrorCopyWith<$Res> {
  _$HomeFeedErrorCopyWithImpl(this._self, this._then);

  final HomeFeedError _self;
  final $Res Function(HomeFeedError) _then;

/// Create a copy of HomeFeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(HomeFeedError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
