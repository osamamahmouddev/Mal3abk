// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deposit_methods_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DepositMethodsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepositMethodsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DepositMethodsState()';
}


}

/// @nodoc
class $DepositMethodsStateCopyWith<$Res>  {
$DepositMethodsStateCopyWith(DepositMethodsState _, $Res Function(DepositMethodsState) __);
}


/// Adds pattern-matching-related methods to [DepositMethodsState].
extension DepositMethodsStatePatterns on DepositMethodsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DepositMethodsLoading value)?  loading,TResult Function( DepositMethodsSuccess value)?  success,TResult Function( DepositMethodsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DepositMethodsLoading() when loading != null:
return loading(_that);case DepositMethodsSuccess() when success != null:
return success(_that);case DepositMethodsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DepositMethodsLoading value)  loading,required TResult Function( DepositMethodsSuccess value)  success,required TResult Function( DepositMethodsError value)  error,}){
final _that = this;
switch (_that) {
case DepositMethodsLoading():
return loading(_that);case DepositMethodsSuccess():
return success(_that);case DepositMethodsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DepositMethodsLoading value)?  loading,TResult? Function( DepositMethodsSuccess value)?  success,TResult? Function( DepositMethodsError value)?  error,}){
final _that = this;
switch (_that) {
case DepositMethodsLoading() when loading != null:
return loading(_that);case DepositMethodsSuccess() when success != null:
return success(_that);case DepositMethodsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<BookingPaymentMethodModel> methods)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DepositMethodsLoading() when loading != null:
return loading();case DepositMethodsSuccess() when success != null:
return success(_that.methods);case DepositMethodsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<BookingPaymentMethodModel> methods)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case DepositMethodsLoading():
return loading();case DepositMethodsSuccess():
return success(_that.methods);case DepositMethodsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<BookingPaymentMethodModel> methods)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case DepositMethodsLoading() when loading != null:
return loading();case DepositMethodsSuccess() when success != null:
return success(_that.methods);case DepositMethodsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class DepositMethodsLoading implements DepositMethodsState {
  const DepositMethodsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepositMethodsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DepositMethodsState.loading()';
}


}




/// @nodoc


class DepositMethodsSuccess implements DepositMethodsState {
  const DepositMethodsSuccess(final  List<BookingPaymentMethodModel> methods): _methods = methods;
  

 final  List<BookingPaymentMethodModel> _methods;
 List<BookingPaymentMethodModel> get methods {
  if (_methods is EqualUnmodifiableListView) return _methods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_methods);
}


/// Create a copy of DepositMethodsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepositMethodsSuccessCopyWith<DepositMethodsSuccess> get copyWith => _$DepositMethodsSuccessCopyWithImpl<DepositMethodsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepositMethodsSuccess&&const DeepCollectionEquality().equals(other._methods, _methods));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_methods));

@override
String toString() {
  return 'DepositMethodsState.success(methods: $methods)';
}


}

/// @nodoc
abstract mixin class $DepositMethodsSuccessCopyWith<$Res> implements $DepositMethodsStateCopyWith<$Res> {
  factory $DepositMethodsSuccessCopyWith(DepositMethodsSuccess value, $Res Function(DepositMethodsSuccess) _then) = _$DepositMethodsSuccessCopyWithImpl;
@useResult
$Res call({
 List<BookingPaymentMethodModel> methods
});




}
/// @nodoc
class _$DepositMethodsSuccessCopyWithImpl<$Res>
    implements $DepositMethodsSuccessCopyWith<$Res> {
  _$DepositMethodsSuccessCopyWithImpl(this._self, this._then);

  final DepositMethodsSuccess _self;
  final $Res Function(DepositMethodsSuccess) _then;

/// Create a copy of DepositMethodsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? methods = null,}) {
  return _then(DepositMethodsSuccess(
null == methods ? _self._methods : methods // ignore: cast_nullable_to_non_nullable
as List<BookingPaymentMethodModel>,
  ));
}


}

/// @nodoc


class DepositMethodsError implements DepositMethodsState {
  const DepositMethodsError(this.message);
  

 final  String message;

/// Create a copy of DepositMethodsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepositMethodsErrorCopyWith<DepositMethodsError> get copyWith => _$DepositMethodsErrorCopyWithImpl<DepositMethodsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepositMethodsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DepositMethodsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $DepositMethodsErrorCopyWith<$Res> implements $DepositMethodsStateCopyWith<$Res> {
  factory $DepositMethodsErrorCopyWith(DepositMethodsError value, $Res Function(DepositMethodsError) _then) = _$DepositMethodsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DepositMethodsErrorCopyWithImpl<$Res>
    implements $DepositMethodsErrorCopyWith<$Res> {
  _$DepositMethodsErrorCopyWithImpl(this._self, this._then);

  final DepositMethodsError _self;
  final $Res Function(DepositMethodsError) _then;

/// Create a copy of DepositMethodsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DepositMethodsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
