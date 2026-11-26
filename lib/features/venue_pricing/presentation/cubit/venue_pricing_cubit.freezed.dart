// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_pricing_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VenuePricingState {

 List<PriceRuleModel> get rules; bool get loading; bool get saving; String? get error;/// Show only rules for this pitch (and the ones for every pitch).
 String? get pitchFilter; PriceQuoteModel? get quote; String? get quoteError; bool get quoting;
/// Create a copy of VenuePricingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenuePricingStateCopyWith<VenuePricingState> get copyWith => _$VenuePricingStateCopyWithImpl<VenuePricingState>(this as VenuePricingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenuePricingState&&const DeepCollectionEquality().equals(other.rules, rules)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.error, error) || other.error == error)&&(identical(other.pitchFilter, pitchFilter) || other.pitchFilter == pitchFilter)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.quoteError, quoteError) || other.quoteError == quoteError)&&(identical(other.quoting, quoting) || other.quoting == quoting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(rules),loading,saving,error,pitchFilter,quote,quoteError,quoting);

@override
String toString() {
  return 'VenuePricingState(rules: $rules, loading: $loading, saving: $saving, error: $error, pitchFilter: $pitchFilter, quote: $quote, quoteError: $quoteError, quoting: $quoting)';
}


}

/// @nodoc
abstract mixin class $VenuePricingStateCopyWith<$Res>  {
  factory $VenuePricingStateCopyWith(VenuePricingState value, $Res Function(VenuePricingState) _then) = _$VenuePricingStateCopyWithImpl;
@useResult
$Res call({
 List<PriceRuleModel> rules, bool loading, bool saving, String? error, String? pitchFilter, PriceQuoteModel? quote, String? quoteError, bool quoting
});




}
/// @nodoc
class _$VenuePricingStateCopyWithImpl<$Res>
    implements $VenuePricingStateCopyWith<$Res> {
  _$VenuePricingStateCopyWithImpl(this._self, this._then);

  final VenuePricingState _self;
  final $Res Function(VenuePricingState) _then;

/// Create a copy of VenuePricingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rules = null,Object? loading = null,Object? saving = null,Object? error = freezed,Object? pitchFilter = freezed,Object? quote = freezed,Object? quoteError = freezed,Object? quoting = null,}) {
  return _then(_self.copyWith(
rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as List<PriceRuleModel>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,pitchFilter: freezed == pitchFilter ? _self.pitchFilter : pitchFilter // ignore: cast_nullable_to_non_nullable
as String?,quote: freezed == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as PriceQuoteModel?,quoteError: freezed == quoteError ? _self.quoteError : quoteError // ignore: cast_nullable_to_non_nullable
as String?,quoting: null == quoting ? _self.quoting : quoting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VenuePricingState].
extension VenuePricingStatePatterns on VenuePricingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenuePricingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenuePricingState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenuePricingState value)  $default,){
final _that = this;
switch (_that) {
case _VenuePricingState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenuePricingState value)?  $default,){
final _that = this;
switch (_that) {
case _VenuePricingState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PriceRuleModel> rules,  bool loading,  bool saving,  String? error,  String? pitchFilter,  PriceQuoteModel? quote,  String? quoteError,  bool quoting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenuePricingState() when $default != null:
return $default(_that.rules,_that.loading,_that.saving,_that.error,_that.pitchFilter,_that.quote,_that.quoteError,_that.quoting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PriceRuleModel> rules,  bool loading,  bool saving,  String? error,  String? pitchFilter,  PriceQuoteModel? quote,  String? quoteError,  bool quoting)  $default,) {final _that = this;
switch (_that) {
case _VenuePricingState():
return $default(_that.rules,_that.loading,_that.saving,_that.error,_that.pitchFilter,_that.quote,_that.quoteError,_that.quoting);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PriceRuleModel> rules,  bool loading,  bool saving,  String? error,  String? pitchFilter,  PriceQuoteModel? quote,  String? quoteError,  bool quoting)?  $default,) {final _that = this;
switch (_that) {
case _VenuePricingState() when $default != null:
return $default(_that.rules,_that.loading,_that.saving,_that.error,_that.pitchFilter,_that.quote,_that.quoteError,_that.quoting);case _:
  return null;

}
}

}

/// @nodoc


class _VenuePricingState implements VenuePricingState {
  const _VenuePricingState({final  List<PriceRuleModel> rules = const [], this.loading = true, this.saving = false, this.error, this.pitchFilter, this.quote, this.quoteError, this.quoting = false}): _rules = rules;
  

 final  List<PriceRuleModel> _rules;
@override@JsonKey() List<PriceRuleModel> get rules {
  if (_rules is EqualUnmodifiableListView) return _rules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rules);
}

@override@JsonKey() final  bool loading;
@override@JsonKey() final  bool saving;
@override final  String? error;
/// Show only rules for this pitch (and the ones for every pitch).
@override final  String? pitchFilter;
@override final  PriceQuoteModel? quote;
@override final  String? quoteError;
@override@JsonKey() final  bool quoting;

/// Create a copy of VenuePricingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenuePricingStateCopyWith<_VenuePricingState> get copyWith => __$VenuePricingStateCopyWithImpl<_VenuePricingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenuePricingState&&const DeepCollectionEquality().equals(other._rules, _rules)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.error, error) || other.error == error)&&(identical(other.pitchFilter, pitchFilter) || other.pitchFilter == pitchFilter)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.quoteError, quoteError) || other.quoteError == quoteError)&&(identical(other.quoting, quoting) || other.quoting == quoting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rules),loading,saving,error,pitchFilter,quote,quoteError,quoting);

@override
String toString() {
  return 'VenuePricingState(rules: $rules, loading: $loading, saving: $saving, error: $error, pitchFilter: $pitchFilter, quote: $quote, quoteError: $quoteError, quoting: $quoting)';
}


}

/// @nodoc
abstract mixin class _$VenuePricingStateCopyWith<$Res> implements $VenuePricingStateCopyWith<$Res> {
  factory _$VenuePricingStateCopyWith(_VenuePricingState value, $Res Function(_VenuePricingState) _then) = __$VenuePricingStateCopyWithImpl;
@override @useResult
$Res call({
 List<PriceRuleModel> rules, bool loading, bool saving, String? error, String? pitchFilter, PriceQuoteModel? quote, String? quoteError, bool quoting
});




}
/// @nodoc
class __$VenuePricingStateCopyWithImpl<$Res>
    implements _$VenuePricingStateCopyWith<$Res> {
  __$VenuePricingStateCopyWithImpl(this._self, this._then);

  final _VenuePricingState _self;
  final $Res Function(_VenuePricingState) _then;

/// Create a copy of VenuePricingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rules = null,Object? loading = null,Object? saving = null,Object? error = freezed,Object? pitchFilter = freezed,Object? quote = freezed,Object? quoteError = freezed,Object? quoting = null,}) {
  return _then(_VenuePricingState(
rules: null == rules ? _self._rules : rules // ignore: cast_nullable_to_non_nullable
as List<PriceRuleModel>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,pitchFilter: freezed == pitchFilter ? _self.pitchFilter : pitchFilter // ignore: cast_nullable_to_non_nullable
as String?,quote: freezed == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as PriceQuoteModel?,quoteError: freezed == quoteError ? _self.quoteError : quoteError // ignore: cast_nullable_to_non_nullable
as String?,quoting: null == quoting ? _self.quoting : quoting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
