// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'governorates_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GovernoratesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GovernoratesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GovernoratesState()';
}


}

/// @nodoc
class $GovernoratesStateCopyWith<$Res>  {
$GovernoratesStateCopyWith(GovernoratesState _, $Res Function(GovernoratesState) __);
}


/// Adds pattern-matching-related methods to [GovernoratesState].
extension GovernoratesStatePatterns on GovernoratesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GovernoratesInitial value)?  initial,TResult Function( GovernoratesLoading value)?  loading,TResult Function( GovernoratesSuccess value)?  success,TResult Function( GovernoratesError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GovernoratesInitial() when initial != null:
return initial(_that);case GovernoratesLoading() when loading != null:
return loading(_that);case GovernoratesSuccess() when success != null:
return success(_that);case GovernoratesError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GovernoratesInitial value)  initial,required TResult Function( GovernoratesLoading value)  loading,required TResult Function( GovernoratesSuccess value)  success,required TResult Function( GovernoratesError value)  error,}){
final _that = this;
switch (_that) {
case GovernoratesInitial():
return initial(_that);case GovernoratesLoading():
return loading(_that);case GovernoratesSuccess():
return success(_that);case GovernoratesError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GovernoratesInitial value)?  initial,TResult? Function( GovernoratesLoading value)?  loading,TResult? Function( GovernoratesSuccess value)?  success,TResult? Function( GovernoratesError value)?  error,}){
final _that = this;
switch (_that) {
case GovernoratesInitial() when initial != null:
return initial(_that);case GovernoratesLoading() when loading != null:
return loading(_that);case GovernoratesSuccess() when success != null:
return success(_that);case GovernoratesError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<GovernorateModel> governorates)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GovernoratesInitial() when initial != null:
return initial();case GovernoratesLoading() when loading != null:
return loading();case GovernoratesSuccess() when success != null:
return success(_that.governorates);case GovernoratesError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<GovernorateModel> governorates)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case GovernoratesInitial():
return initial();case GovernoratesLoading():
return loading();case GovernoratesSuccess():
return success(_that.governorates);case GovernoratesError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<GovernorateModel> governorates)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case GovernoratesInitial() when initial != null:
return initial();case GovernoratesLoading() when loading != null:
return loading();case GovernoratesSuccess() when success != null:
return success(_that.governorates);case GovernoratesError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class GovernoratesInitial implements GovernoratesState {
  const GovernoratesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GovernoratesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GovernoratesState.initial()';
}


}




/// @nodoc


class GovernoratesLoading implements GovernoratesState {
  const GovernoratesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GovernoratesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GovernoratesState.loading()';
}


}




/// @nodoc


class GovernoratesSuccess implements GovernoratesState {
  const GovernoratesSuccess(final  List<GovernorateModel> governorates): _governorates = governorates;
  

 final  List<GovernorateModel> _governorates;
 List<GovernorateModel> get governorates {
  if (_governorates is EqualUnmodifiableListView) return _governorates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_governorates);
}


/// Create a copy of GovernoratesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GovernoratesSuccessCopyWith<GovernoratesSuccess> get copyWith => _$GovernoratesSuccessCopyWithImpl<GovernoratesSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GovernoratesSuccess&&const DeepCollectionEquality().equals(other._governorates, _governorates));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_governorates));

@override
String toString() {
  return 'GovernoratesState.success(governorates: $governorates)';
}


}

/// @nodoc
abstract mixin class $GovernoratesSuccessCopyWith<$Res> implements $GovernoratesStateCopyWith<$Res> {
  factory $GovernoratesSuccessCopyWith(GovernoratesSuccess value, $Res Function(GovernoratesSuccess) _then) = _$GovernoratesSuccessCopyWithImpl;
@useResult
$Res call({
 List<GovernorateModel> governorates
});




}
/// @nodoc
class _$GovernoratesSuccessCopyWithImpl<$Res>
    implements $GovernoratesSuccessCopyWith<$Res> {
  _$GovernoratesSuccessCopyWithImpl(this._self, this._then);

  final GovernoratesSuccess _self;
  final $Res Function(GovernoratesSuccess) _then;

/// Create a copy of GovernoratesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? governorates = null,}) {
  return _then(GovernoratesSuccess(
null == governorates ? _self._governorates : governorates // ignore: cast_nullable_to_non_nullable
as List<GovernorateModel>,
  ));
}


}

/// @nodoc


class GovernoratesError implements GovernoratesState {
  const GovernoratesError(this.message);
  

 final  String message;

/// Create a copy of GovernoratesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GovernoratesErrorCopyWith<GovernoratesError> get copyWith => _$GovernoratesErrorCopyWithImpl<GovernoratesError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GovernoratesError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'GovernoratesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $GovernoratesErrorCopyWith<$Res> implements $GovernoratesStateCopyWith<$Res> {
  factory $GovernoratesErrorCopyWith(GovernoratesError value, $Res Function(GovernoratesError) _then) = _$GovernoratesErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$GovernoratesErrorCopyWithImpl<$Res>
    implements $GovernoratesErrorCopyWith<$Res> {
  _$GovernoratesErrorCopyWithImpl(this._self, this._then);

  final GovernoratesError _self;
  final $Res Function(GovernoratesError) _then;

/// Create a copy of GovernoratesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(GovernoratesError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
