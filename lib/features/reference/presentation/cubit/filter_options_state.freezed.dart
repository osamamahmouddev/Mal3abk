// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_options_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FilterOptionsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterOptionsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FilterOptionsState()';
}


}

/// @nodoc
class $FilterOptionsStateCopyWith<$Res>  {
$FilterOptionsStateCopyWith(FilterOptionsState _, $Res Function(FilterOptionsState) __);
}


/// Adds pattern-matching-related methods to [FilterOptionsState].
extension FilterOptionsStatePatterns on FilterOptionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FilterOptionsLoading value)?  loading,TResult Function( FilterOptionsSuccess value)?  success,TResult Function( FilterOptionsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FilterOptionsLoading() when loading != null:
return loading(_that);case FilterOptionsSuccess() when success != null:
return success(_that);case FilterOptionsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FilterOptionsLoading value)  loading,required TResult Function( FilterOptionsSuccess value)  success,required TResult Function( FilterOptionsError value)  error,}){
final _that = this;
switch (_that) {
case FilterOptionsLoading():
return loading(_that);case FilterOptionsSuccess():
return success(_that);case FilterOptionsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FilterOptionsLoading value)?  loading,TResult? Function( FilterOptionsSuccess value)?  success,TResult? Function( FilterOptionsError value)?  error,}){
final _that = this;
switch (_that) {
case FilterOptionsLoading() when loading != null:
return loading(_that);case FilterOptionsSuccess() when success != null:
return success(_that);case FilterOptionsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( FilterOptionsModel options)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FilterOptionsLoading() when loading != null:
return loading();case FilterOptionsSuccess() when success != null:
return success(_that.options);case FilterOptionsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( FilterOptionsModel options)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case FilterOptionsLoading():
return loading();case FilterOptionsSuccess():
return success(_that.options);case FilterOptionsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( FilterOptionsModel options)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case FilterOptionsLoading() when loading != null:
return loading();case FilterOptionsSuccess() when success != null:
return success(_that.options);case FilterOptionsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class FilterOptionsLoading implements FilterOptionsState {
  const FilterOptionsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterOptionsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FilterOptionsState.loading()';
}


}




/// @nodoc


class FilterOptionsSuccess implements FilterOptionsState {
  const FilterOptionsSuccess(this.options);
  

 final  FilterOptionsModel options;

/// Create a copy of FilterOptionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterOptionsSuccessCopyWith<FilterOptionsSuccess> get copyWith => _$FilterOptionsSuccessCopyWithImpl<FilterOptionsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterOptionsSuccess&&(identical(other.options, options) || other.options == options));
}


@override
int get hashCode => Object.hash(runtimeType,options);

@override
String toString() {
  return 'FilterOptionsState.success(options: $options)';
}


}

/// @nodoc
abstract mixin class $FilterOptionsSuccessCopyWith<$Res> implements $FilterOptionsStateCopyWith<$Res> {
  factory $FilterOptionsSuccessCopyWith(FilterOptionsSuccess value, $Res Function(FilterOptionsSuccess) _then) = _$FilterOptionsSuccessCopyWithImpl;
@useResult
$Res call({
 FilterOptionsModel options
});




}
/// @nodoc
class _$FilterOptionsSuccessCopyWithImpl<$Res>
    implements $FilterOptionsSuccessCopyWith<$Res> {
  _$FilterOptionsSuccessCopyWithImpl(this._self, this._then);

  final FilterOptionsSuccess _self;
  final $Res Function(FilterOptionsSuccess) _then;

/// Create a copy of FilterOptionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? options = null,}) {
  return _then(FilterOptionsSuccess(
null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as FilterOptionsModel,
  ));
}


}

/// @nodoc


class FilterOptionsError implements FilterOptionsState {
  const FilterOptionsError(this.message);
  

 final  String message;

/// Create a copy of FilterOptionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterOptionsErrorCopyWith<FilterOptionsError> get copyWith => _$FilterOptionsErrorCopyWithImpl<FilterOptionsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterOptionsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FilterOptionsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $FilterOptionsErrorCopyWith<$Res> implements $FilterOptionsStateCopyWith<$Res> {
  factory $FilterOptionsErrorCopyWith(FilterOptionsError value, $Res Function(FilterOptionsError) _then) = _$FilterOptionsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FilterOptionsErrorCopyWithImpl<$Res>
    implements $FilterOptionsErrorCopyWith<$Res> {
  _$FilterOptionsErrorCopyWithImpl(this._self, this._then);

  final FilterOptionsError _self;
  final $Res Function(FilterOptionsError) _then;

/// Create a copy of FilterOptionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(FilterOptionsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
