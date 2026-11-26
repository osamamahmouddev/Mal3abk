// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_overview_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenueOverviewState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueOverviewState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VenueOverviewState()';
}


}

/// @nodoc
class $VenueOverviewStateCopyWith<$Res>  {
$VenueOverviewStateCopyWith(VenueOverviewState _, $Res Function(VenueOverviewState) __);
}


/// Adds pattern-matching-related methods to [VenueOverviewState].
extension VenueOverviewStatePatterns on VenueOverviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VenueOverviewLoading value)?  loading,TResult Function( VenueOverviewSuccess value)?  success,TResult Function( VenueOverviewError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VenueOverviewLoading() when loading != null:
return loading(_that);case VenueOverviewSuccess() when success != null:
return success(_that);case VenueOverviewError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VenueOverviewLoading value)  loading,required TResult Function( VenueOverviewSuccess value)  success,required TResult Function( VenueOverviewError value)  error,}){
final _that = this;
switch (_that) {
case VenueOverviewLoading():
return loading(_that);case VenueOverviewSuccess():
return success(_that);case VenueOverviewError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VenueOverviewLoading value)?  loading,TResult? Function( VenueOverviewSuccess value)?  success,TResult? Function( VenueOverviewError value)?  error,}){
final _that = this;
switch (_that) {
case VenueOverviewLoading() when loading != null:
return loading(_that);case VenueOverviewSuccess() when success != null:
return success(_that);case VenueOverviewError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( VenueDashboardModel dashboard,  String? adminMessage,  bool refreshing)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VenueOverviewLoading() when loading != null:
return loading();case VenueOverviewSuccess() when success != null:
return success(_that.dashboard,_that.adminMessage,_that.refreshing);case VenueOverviewError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( VenueDashboardModel dashboard,  String? adminMessage,  bool refreshing)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case VenueOverviewLoading():
return loading();case VenueOverviewSuccess():
return success(_that.dashboard,_that.adminMessage,_that.refreshing);case VenueOverviewError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( VenueDashboardModel dashboard,  String? adminMessage,  bool refreshing)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case VenueOverviewLoading() when loading != null:
return loading();case VenueOverviewSuccess() when success != null:
return success(_that.dashboard,_that.adminMessage,_that.refreshing);case VenueOverviewError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class VenueOverviewLoading implements VenueOverviewState {
  const VenueOverviewLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueOverviewLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VenueOverviewState.loading()';
}


}




/// @nodoc


class VenueOverviewSuccess implements VenueOverviewState {
  const VenueOverviewSuccess({required this.dashboard, this.adminMessage, this.refreshing = false});
  

 final  VenueDashboardModel dashboard;
 final  String? adminMessage;
@JsonKey() final  bool refreshing;

/// Create a copy of VenueOverviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueOverviewSuccessCopyWith<VenueOverviewSuccess> get copyWith => _$VenueOverviewSuccessCopyWithImpl<VenueOverviewSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueOverviewSuccess&&(identical(other.dashboard, dashboard) || other.dashboard == dashboard)&&(identical(other.adminMessage, adminMessage) || other.adminMessage == adminMessage)&&(identical(other.refreshing, refreshing) || other.refreshing == refreshing));
}


@override
int get hashCode => Object.hash(runtimeType,dashboard,adminMessage,refreshing);

@override
String toString() {
  return 'VenueOverviewState.success(dashboard: $dashboard, adminMessage: $adminMessage, refreshing: $refreshing)';
}


}

/// @nodoc
abstract mixin class $VenueOverviewSuccessCopyWith<$Res> implements $VenueOverviewStateCopyWith<$Res> {
  factory $VenueOverviewSuccessCopyWith(VenueOverviewSuccess value, $Res Function(VenueOverviewSuccess) _then) = _$VenueOverviewSuccessCopyWithImpl;
@useResult
$Res call({
 VenueDashboardModel dashboard, String? adminMessage, bool refreshing
});




}
/// @nodoc
class _$VenueOverviewSuccessCopyWithImpl<$Res>
    implements $VenueOverviewSuccessCopyWith<$Res> {
  _$VenueOverviewSuccessCopyWithImpl(this._self, this._then);

  final VenueOverviewSuccess _self;
  final $Res Function(VenueOverviewSuccess) _then;

/// Create a copy of VenueOverviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dashboard = null,Object? adminMessage = freezed,Object? refreshing = null,}) {
  return _then(VenueOverviewSuccess(
dashboard: null == dashboard ? _self.dashboard : dashboard // ignore: cast_nullable_to_non_nullable
as VenueDashboardModel,adminMessage: freezed == adminMessage ? _self.adminMessage : adminMessage // ignore: cast_nullable_to_non_nullable
as String?,refreshing: null == refreshing ? _self.refreshing : refreshing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class VenueOverviewError implements VenueOverviewState {
  const VenueOverviewError(this.message);
  

 final  String message;

/// Create a copy of VenueOverviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueOverviewErrorCopyWith<VenueOverviewError> get copyWith => _$VenueOverviewErrorCopyWithImpl<VenueOverviewError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueOverviewError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'VenueOverviewState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $VenueOverviewErrorCopyWith<$Res> implements $VenueOverviewStateCopyWith<$Res> {
  factory $VenueOverviewErrorCopyWith(VenueOverviewError value, $Res Function(VenueOverviewError) _then) = _$VenueOverviewErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$VenueOverviewErrorCopyWithImpl<$Res>
    implements $VenueOverviewErrorCopyWith<$Res> {
  _$VenueOverviewErrorCopyWithImpl(this._self, this._then);

  final VenueOverviewError _self;
  final $Res Function(VenueOverviewError) _then;

/// Create a copy of VenueOverviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(VenueOverviewError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
