// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExploreMapState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreMapState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExploreMapState()';
}


}

/// @nodoc
class $ExploreMapStateCopyWith<$Res>  {
$ExploreMapStateCopyWith(ExploreMapState _, $Res Function(ExploreMapState) __);
}


/// Adds pattern-matching-related methods to [ExploreMapState].
extension ExploreMapStatePatterns on ExploreMapState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ExploreMapLocating value)?  locating,TResult Function( ExploreMapReady value)?  ready,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ExploreMapLocating() when locating != null:
return locating(_that);case ExploreMapReady() when ready != null:
return ready(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ExploreMapLocating value)  locating,required TResult Function( ExploreMapReady value)  ready,}){
final _that = this;
switch (_that) {
case ExploreMapLocating():
return locating(_that);case ExploreMapReady():
return ready(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ExploreMapLocating value)?  locating,TResult? Function( ExploreMapReady value)?  ready,}){
final _that = this;
switch (_that) {
case ExploreMapLocating() when locating != null:
return locating(_that);case ExploreMapReady() when ready != null:
return ready(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  locating,TResult Function( GeoPoint center,  bool hasMyLocation,  List<MapVenuePinModel> pins,  bool searching,  bool truncated,  bool tooWide,  MapVenuePinModel? selected,  String? failure)?  ready,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ExploreMapLocating() when locating != null:
return locating();case ExploreMapReady() when ready != null:
return ready(_that.center,_that.hasMyLocation,_that.pins,_that.searching,_that.truncated,_that.tooWide,_that.selected,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  locating,required TResult Function( GeoPoint center,  bool hasMyLocation,  List<MapVenuePinModel> pins,  bool searching,  bool truncated,  bool tooWide,  MapVenuePinModel? selected,  String? failure)  ready,}) {final _that = this;
switch (_that) {
case ExploreMapLocating():
return locating();case ExploreMapReady():
return ready(_that.center,_that.hasMyLocation,_that.pins,_that.searching,_that.truncated,_that.tooWide,_that.selected,_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  locating,TResult? Function( GeoPoint center,  bool hasMyLocation,  List<MapVenuePinModel> pins,  bool searching,  bool truncated,  bool tooWide,  MapVenuePinModel? selected,  String? failure)?  ready,}) {final _that = this;
switch (_that) {
case ExploreMapLocating() when locating != null:
return locating();case ExploreMapReady() when ready != null:
return ready(_that.center,_that.hasMyLocation,_that.pins,_that.searching,_that.truncated,_that.tooWide,_that.selected,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ExploreMapLocating implements ExploreMapState {
  const ExploreMapLocating();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreMapLocating);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExploreMapState.locating()';
}


}




/// @nodoc


class ExploreMapReady implements ExploreMapState {
  const ExploreMapReady({required this.center, required this.hasMyLocation, final  List<MapVenuePinModel> pins = const <MapVenuePinModel>[], this.searching = false, this.truncated = false, this.tooWide = false, this.selected, this.failure}): _pins = pins;
  

 final  GeoPoint center;
 final  bool hasMyLocation;
 final  List<MapVenuePinModel> _pins;
@JsonKey() List<MapVenuePinModel> get pins {
  if (_pins is EqualUnmodifiableListView) return _pins;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pins);
}

@JsonKey() final  bool searching;
@JsonKey() final  bool truncated;
@JsonKey() final  bool tooWide;
 final  MapVenuePinModel? selected;
 final  String? failure;

/// Create a copy of ExploreMapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreMapReadyCopyWith<ExploreMapReady> get copyWith => _$ExploreMapReadyCopyWithImpl<ExploreMapReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreMapReady&&(identical(other.center, center) || other.center == center)&&(identical(other.hasMyLocation, hasMyLocation) || other.hasMyLocation == hasMyLocation)&&const DeepCollectionEquality().equals(other._pins, _pins)&&(identical(other.searching, searching) || other.searching == searching)&&(identical(other.truncated, truncated) || other.truncated == truncated)&&(identical(other.tooWide, tooWide) || other.tooWide == tooWide)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,center,hasMyLocation,const DeepCollectionEquality().hash(_pins),searching,truncated,tooWide,selected,failure);

@override
String toString() {
  return 'ExploreMapState.ready(center: $center, hasMyLocation: $hasMyLocation, pins: $pins, searching: $searching, truncated: $truncated, tooWide: $tooWide, selected: $selected, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ExploreMapReadyCopyWith<$Res> implements $ExploreMapStateCopyWith<$Res> {
  factory $ExploreMapReadyCopyWith(ExploreMapReady value, $Res Function(ExploreMapReady) _then) = _$ExploreMapReadyCopyWithImpl;
@useResult
$Res call({
 GeoPoint center, bool hasMyLocation, List<MapVenuePinModel> pins, bool searching, bool truncated, bool tooWide, MapVenuePinModel? selected, String? failure
});




}
/// @nodoc
class _$ExploreMapReadyCopyWithImpl<$Res>
    implements $ExploreMapReadyCopyWith<$Res> {
  _$ExploreMapReadyCopyWithImpl(this._self, this._then);

  final ExploreMapReady _self;
  final $Res Function(ExploreMapReady) _then;

/// Create a copy of ExploreMapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? center = null,Object? hasMyLocation = null,Object? pins = null,Object? searching = null,Object? truncated = null,Object? tooWide = null,Object? selected = freezed,Object? failure = freezed,}) {
  return _then(ExploreMapReady(
center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as GeoPoint,hasMyLocation: null == hasMyLocation ? _self.hasMyLocation : hasMyLocation // ignore: cast_nullable_to_non_nullable
as bool,pins: null == pins ? _self._pins : pins // ignore: cast_nullable_to_non_nullable
as List<MapVenuePinModel>,searching: null == searching ? _self.searching : searching // ignore: cast_nullable_to_non_nullable
as bool,truncated: null == truncated ? _self.truncated : truncated // ignore: cast_nullable_to_non_nullable
as bool,tooWide: null == tooWide ? _self.tooWide : tooWide // ignore: cast_nullable_to_non_nullable
as bool,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as MapVenuePinModel?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
