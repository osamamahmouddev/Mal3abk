// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tactical_board_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TacticalBoardState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TacticalBoardState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TacticalBoardState()';
}


}

/// @nodoc
class $TacticalBoardStateCopyWith<$Res>  {
$TacticalBoardStateCopyWith(TacticalBoardState _, $Res Function(TacticalBoardState) __);
}


/// Adds pattern-matching-related methods to [TacticalBoardState].
extension TacticalBoardStatePatterns on TacticalBoardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TacticalBoardInitial value)?  initial,TResult Function( TacticalBoardLoading value)?  loading,TResult Function( TacticalBoardSuccess value)?  success,TResult Function( TacticalBoardError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TacticalBoardInitial() when initial != null:
return initial(_that);case TacticalBoardLoading() when loading != null:
return loading(_that);case TacticalBoardSuccess() when success != null:
return success(_that);case TacticalBoardError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TacticalBoardInitial value)  initial,required TResult Function( TacticalBoardLoading value)  loading,required TResult Function( TacticalBoardSuccess value)  success,required TResult Function( TacticalBoardError value)  error,}){
final _that = this;
switch (_that) {
case TacticalBoardInitial():
return initial(_that);case TacticalBoardLoading():
return loading(_that);case TacticalBoardSuccess():
return success(_that);case TacticalBoardError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TacticalBoardInitial value)?  initial,TResult? Function( TacticalBoardLoading value)?  loading,TResult? Function( TacticalBoardSuccess value)?  success,TResult? Function( TacticalBoardError value)?  error,}){
final _that = this;
switch (_that) {
case TacticalBoardInitial() when initial != null:
return initial(_that);case TacticalBoardLoading() when loading != null:
return loading(_that);case TacticalBoardSuccess() when success != null:
return success(_that);case TacticalBoardError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( TacticsBoardModel board,  int? selectedSlot)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TacticalBoardInitial() when initial != null:
return initial();case TacticalBoardLoading() when loading != null:
return loading();case TacticalBoardSuccess() when success != null:
return success(_that.board,_that.selectedSlot);case TacticalBoardError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( TacticsBoardModel board,  int? selectedSlot)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case TacticalBoardInitial():
return initial();case TacticalBoardLoading():
return loading();case TacticalBoardSuccess():
return success(_that.board,_that.selectedSlot);case TacticalBoardError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( TacticsBoardModel board,  int? selectedSlot)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case TacticalBoardInitial() when initial != null:
return initial();case TacticalBoardLoading() when loading != null:
return loading();case TacticalBoardSuccess() when success != null:
return success(_that.board,_that.selectedSlot);case TacticalBoardError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TacticalBoardInitial implements TacticalBoardState {
  const TacticalBoardInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TacticalBoardInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TacticalBoardState.initial()';
}


}




/// @nodoc


class TacticalBoardLoading implements TacticalBoardState {
  const TacticalBoardLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TacticalBoardLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TacticalBoardState.loading()';
}


}




/// @nodoc


class TacticalBoardSuccess implements TacticalBoardState {
  const TacticalBoardSuccess(this.board, this.selectedSlot);
  

 final  TacticsBoardModel board;
 final  int? selectedSlot;

/// Create a copy of TacticalBoardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TacticalBoardSuccessCopyWith<TacticalBoardSuccess> get copyWith => _$TacticalBoardSuccessCopyWithImpl<TacticalBoardSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TacticalBoardSuccess&&(identical(other.board, board) || other.board == board)&&(identical(other.selectedSlot, selectedSlot) || other.selectedSlot == selectedSlot));
}


@override
int get hashCode => Object.hash(runtimeType,board,selectedSlot);

@override
String toString() {
  return 'TacticalBoardState.success(board: $board, selectedSlot: $selectedSlot)';
}


}

/// @nodoc
abstract mixin class $TacticalBoardSuccessCopyWith<$Res> implements $TacticalBoardStateCopyWith<$Res> {
  factory $TacticalBoardSuccessCopyWith(TacticalBoardSuccess value, $Res Function(TacticalBoardSuccess) _then) = _$TacticalBoardSuccessCopyWithImpl;
@useResult
$Res call({
 TacticsBoardModel board, int? selectedSlot
});




}
/// @nodoc
class _$TacticalBoardSuccessCopyWithImpl<$Res>
    implements $TacticalBoardSuccessCopyWith<$Res> {
  _$TacticalBoardSuccessCopyWithImpl(this._self, this._then);

  final TacticalBoardSuccess _self;
  final $Res Function(TacticalBoardSuccess) _then;

/// Create a copy of TacticalBoardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? board = null,Object? selectedSlot = freezed,}) {
  return _then(TacticalBoardSuccess(
null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as TacticsBoardModel,freezed == selectedSlot ? _self.selectedSlot : selectedSlot // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class TacticalBoardError implements TacticalBoardState {
  const TacticalBoardError(this.message);
  

 final  String message;

/// Create a copy of TacticalBoardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TacticalBoardErrorCopyWith<TacticalBoardError> get copyWith => _$TacticalBoardErrorCopyWithImpl<TacticalBoardError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TacticalBoardError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TacticalBoardState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TacticalBoardErrorCopyWith<$Res> implements $TacticalBoardStateCopyWith<$Res> {
  factory $TacticalBoardErrorCopyWith(TacticalBoardError value, $Res Function(TacticalBoardError) _then) = _$TacticalBoardErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TacticalBoardErrorCopyWithImpl<$Res>
    implements $TacticalBoardErrorCopyWith<$Res> {
  _$TacticalBoardErrorCopyWithImpl(this._self, this._then);

  final TacticalBoardError _self;
  final $Res Function(TacticalBoardError) _then;

/// Create a copy of TacticalBoardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TacticalBoardError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
