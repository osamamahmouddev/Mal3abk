// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_action_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountActionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountActionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountActionState()';
}


}

/// @nodoc
class $AccountActionStateCopyWith<$Res>  {
$AccountActionStateCopyWith(AccountActionState _, $Res Function(AccountActionState) __);
}


/// Adds pattern-matching-related methods to [AccountActionState].
extension AccountActionStatePatterns on AccountActionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AccountActionInitial value)?  initial,TResult Function( AccountActionLoading value)?  loading,TResult Function( AccountLanguageChanged value)?  languageChanged,TResult Function( AccountExported value)?  exported,TResult Function( AccountDeleted value)?  deleted,TResult Function( AccountActionError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AccountActionInitial() when initial != null:
return initial(_that);case AccountActionLoading() when loading != null:
return loading(_that);case AccountLanguageChanged() when languageChanged != null:
return languageChanged(_that);case AccountExported() when exported != null:
return exported(_that);case AccountDeleted() when deleted != null:
return deleted(_that);case AccountActionError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AccountActionInitial value)  initial,required TResult Function( AccountActionLoading value)  loading,required TResult Function( AccountLanguageChanged value)  languageChanged,required TResult Function( AccountExported value)  exported,required TResult Function( AccountDeleted value)  deleted,required TResult Function( AccountActionError value)  error,}){
final _that = this;
switch (_that) {
case AccountActionInitial():
return initial(_that);case AccountActionLoading():
return loading(_that);case AccountLanguageChanged():
return languageChanged(_that);case AccountExported():
return exported(_that);case AccountDeleted():
return deleted(_that);case AccountActionError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AccountActionInitial value)?  initial,TResult? Function( AccountActionLoading value)?  loading,TResult? Function( AccountLanguageChanged value)?  languageChanged,TResult? Function( AccountExported value)?  exported,TResult? Function( AccountDeleted value)?  deleted,TResult? Function( AccountActionError value)?  error,}){
final _that = this;
switch (_that) {
case AccountActionInitial() when initial != null:
return initial(_that);case AccountActionLoading() when loading != null:
return loading(_that);case AccountLanguageChanged() when languageChanged != null:
return languageChanged(_that);case AccountExported() when exported != null:
return exported(_that);case AccountDeleted() when deleted != null:
return deleted(_that);case AccountActionError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( AccountAction action)?  loading,TResult Function( String languageCode)?  languageChanged,TResult Function( Uint8List data)?  exported,TResult Function()?  deleted,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AccountActionInitial() when initial != null:
return initial();case AccountActionLoading() when loading != null:
return loading(_that.action);case AccountLanguageChanged() when languageChanged != null:
return languageChanged(_that.languageCode);case AccountExported() when exported != null:
return exported(_that.data);case AccountDeleted() when deleted != null:
return deleted();case AccountActionError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( AccountAction action)  loading,required TResult Function( String languageCode)  languageChanged,required TResult Function( Uint8List data)  exported,required TResult Function()  deleted,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case AccountActionInitial():
return initial();case AccountActionLoading():
return loading(_that.action);case AccountLanguageChanged():
return languageChanged(_that.languageCode);case AccountExported():
return exported(_that.data);case AccountDeleted():
return deleted();case AccountActionError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( AccountAction action)?  loading,TResult? Function( String languageCode)?  languageChanged,TResult? Function( Uint8List data)?  exported,TResult? Function()?  deleted,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case AccountActionInitial() when initial != null:
return initial();case AccountActionLoading() when loading != null:
return loading(_that.action);case AccountLanguageChanged() when languageChanged != null:
return languageChanged(_that.languageCode);case AccountExported() when exported != null:
return exported(_that.data);case AccountDeleted() when deleted != null:
return deleted();case AccountActionError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AccountActionInitial implements AccountActionState {
  const AccountActionInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountActionInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountActionState.initial()';
}


}




/// @nodoc


class AccountActionLoading implements AccountActionState {
  const AccountActionLoading(this.action);
  

 final  AccountAction action;

/// Create a copy of AccountActionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountActionLoadingCopyWith<AccountActionLoading> get copyWith => _$AccountActionLoadingCopyWithImpl<AccountActionLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountActionLoading&&(identical(other.action, action) || other.action == action));
}


@override
int get hashCode => Object.hash(runtimeType,action);

@override
String toString() {
  return 'AccountActionState.loading(action: $action)';
}


}

/// @nodoc
abstract mixin class $AccountActionLoadingCopyWith<$Res> implements $AccountActionStateCopyWith<$Res> {
  factory $AccountActionLoadingCopyWith(AccountActionLoading value, $Res Function(AccountActionLoading) _then) = _$AccountActionLoadingCopyWithImpl;
@useResult
$Res call({
 AccountAction action
});




}
/// @nodoc
class _$AccountActionLoadingCopyWithImpl<$Res>
    implements $AccountActionLoadingCopyWith<$Res> {
  _$AccountActionLoadingCopyWithImpl(this._self, this._then);

  final AccountActionLoading _self;
  final $Res Function(AccountActionLoading) _then;

/// Create a copy of AccountActionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? action = null,}) {
  return _then(AccountActionLoading(
null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as AccountAction,
  ));
}


}

/// @nodoc


class AccountLanguageChanged implements AccountActionState {
  const AccountLanguageChanged(this.languageCode);
  

 final  String languageCode;

/// Create a copy of AccountActionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountLanguageChangedCopyWith<AccountLanguageChanged> get copyWith => _$AccountLanguageChangedCopyWithImpl<AccountLanguageChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountLanguageChanged&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode);

@override
String toString() {
  return 'AccountActionState.languageChanged(languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class $AccountLanguageChangedCopyWith<$Res> implements $AccountActionStateCopyWith<$Res> {
  factory $AccountLanguageChangedCopyWith(AccountLanguageChanged value, $Res Function(AccountLanguageChanged) _then) = _$AccountLanguageChangedCopyWithImpl;
@useResult
$Res call({
 String languageCode
});




}
/// @nodoc
class _$AccountLanguageChangedCopyWithImpl<$Res>
    implements $AccountLanguageChangedCopyWith<$Res> {
  _$AccountLanguageChangedCopyWithImpl(this._self, this._then);

  final AccountLanguageChanged _self;
  final $Res Function(AccountLanguageChanged) _then;

/// Create a copy of AccountActionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? languageCode = null,}) {
  return _then(AccountLanguageChanged(
null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AccountExported implements AccountActionState {
  const AccountExported(this.data);
  

 final  Uint8List data;

/// Create a copy of AccountActionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountExportedCopyWith<AccountExported> get copyWith => _$AccountExportedCopyWithImpl<AccountExported>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountExported&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'AccountActionState.exported(data: $data)';
}


}

/// @nodoc
abstract mixin class $AccountExportedCopyWith<$Res> implements $AccountActionStateCopyWith<$Res> {
  factory $AccountExportedCopyWith(AccountExported value, $Res Function(AccountExported) _then) = _$AccountExportedCopyWithImpl;
@useResult
$Res call({
 Uint8List data
});




}
/// @nodoc
class _$AccountExportedCopyWithImpl<$Res>
    implements $AccountExportedCopyWith<$Res> {
  _$AccountExportedCopyWithImpl(this._self, this._then);

  final AccountExported _self;
  final $Res Function(AccountExported) _then;

/// Create a copy of AccountActionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(AccountExported(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc


class AccountDeleted implements AccountActionState {
  const AccountDeleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDeleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountActionState.deleted()';
}


}




/// @nodoc


class AccountActionError implements AccountActionState {
  const AccountActionError(this.message);
  

 final  String message;

/// Create a copy of AccountActionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountActionErrorCopyWith<AccountActionError> get copyWith => _$AccountActionErrorCopyWithImpl<AccountActionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountActionError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AccountActionState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $AccountActionErrorCopyWith<$Res> implements $AccountActionStateCopyWith<$Res> {
  factory $AccountActionErrorCopyWith(AccountActionError value, $Res Function(AccountActionError) _then) = _$AccountActionErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AccountActionErrorCopyWithImpl<$Res>
    implements $AccountActionErrorCopyWith<$Res> {
  _$AccountActionErrorCopyWithImpl(this._self, this._then);

  final AccountActionError _self;
  final $Res Function(AccountActionError) _then;

/// Create a copy of AccountActionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AccountActionError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
