// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExploreListState {

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreListState);
}

@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExploreListState()';
}

}

/// @nodoc
class $ExploreListStateCopyWith<$Res>  {
$ExploreListStateCopyWith(ExploreListState _, $Res Function(ExploreListState) __);
}


/// @nodoc


class ExploreListInitial implements ExploreListState {
  const ExploreListInitial();
  

@override
String toString() {
  return 'ExploreListState.initial()';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreListInitial);
}

@override
int get hashCode => runtimeType.hashCode;

}




/// @nodoc


class ExploreListLoading implements ExploreListState {
  const ExploreListLoading();
  

@override
String toString() {
  return 'ExploreListState.loading()';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreListLoading);
}

@override
int get hashCode => runtimeType.hashCode;

}




/// @nodoc


class ExploreListSuccess implements ExploreListState {
  const ExploreListSuccess(this.result);
  

 final  ExploreResultModel result;

/// Create a copy of ExploreListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreListSuccessCopyWith<ExploreListSuccess> get copyWith => _$ExploreListSuccessCopyWithImpl<ExploreListSuccess>(this, _$identity);



@override
String toString() {
  return 'ExploreListState.success(result: $result)';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreListSuccess&&(identical(other.result, result) || other.result == result));
}

@override
int get hashCode => Object.hash(runtimeType,result);

}

/// @nodoc
abstract class $ExploreListSuccessCopyWith<$Res> implements $ExploreListStateCopyWith<$Res> {
  factory $ExploreListSuccessCopyWith(ExploreListSuccess value, $Res Function(ExploreListSuccess) _then) = _$ExploreListSuccessCopyWithImpl;
@useResult
$Res call({
 ExploreResultModel result
});




}
/// @nodoc
class _$ExploreListSuccessCopyWithImpl<$Res>
    implements $ExploreListSuccessCopyWith<$Res> {
  _$ExploreListSuccessCopyWithImpl(this._self, this._then);

  final ExploreListSuccess _self;
  final $Res Function(ExploreListSuccess) _then;

/// Create a copy of ExploreListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(ExploreListSuccess(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ExploreResultModel,
  ));
}


}

/// @nodoc


class ExploreListError implements ExploreListState {
  const ExploreListError(this.message);
  

 final  String message;

/// Create a copy of ExploreListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreListErrorCopyWith<ExploreListError> get copyWith => _$ExploreListErrorCopyWithImpl<ExploreListError>(this, _$identity);



@override
String toString() {
  return 'ExploreListState.error(message: $message)';
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreListError&&(identical(other.message, message) || other.message == message));
}

@override
int get hashCode => Object.hash(runtimeType,message);

}

/// @nodoc
abstract class $ExploreListErrorCopyWith<$Res> implements $ExploreListStateCopyWith<$Res> {
  factory $ExploreListErrorCopyWith(ExploreListError value, $Res Function(ExploreListError) _then) = _$ExploreListErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ExploreListErrorCopyWithImpl<$Res>
    implements $ExploreListErrorCopyWith<$Res> {
  _$ExploreListErrorCopyWithImpl(this._self, this._then);

  final ExploreListError _self;
  final $Res Function(ExploreListError) _then;

/// Create a copy of ExploreListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ExploreListError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
