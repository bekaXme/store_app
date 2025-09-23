// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductDetailState {

 Status get productStatus; Status get reviewsStatus; Status get statsStatus; String? get errorProduct; String? get errorReviews; String? get errorStats; ProductDetailModel? get product; List<ReviewsModel> get reviews; ReviewsStatsModel? get stats;
/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailStateCopyWith<ProductDetailState> get copyWith => _$ProductDetailStateCopyWithImpl<ProductDetailState>(this as ProductDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailState&&(identical(other.productStatus, productStatus) || other.productStatus == productStatus)&&(identical(other.reviewsStatus, reviewsStatus) || other.reviewsStatus == reviewsStatus)&&(identical(other.statsStatus, statsStatus) || other.statsStatus == statsStatus)&&(identical(other.errorProduct, errorProduct) || other.errorProduct == errorProduct)&&(identical(other.errorReviews, errorReviews) || other.errorReviews == errorReviews)&&(identical(other.errorStats, errorStats) || other.errorStats == errorStats)&&(identical(other.product, product) || other.product == product)&&const DeepCollectionEquality().equals(other.reviews, reviews)&&(identical(other.stats, stats) || other.stats == stats));
}


@override
int get hashCode => Object.hash(runtimeType,productStatus,reviewsStatus,statsStatus,errorProduct,errorReviews,errorStats,product,const DeepCollectionEquality().hash(reviews),stats);

@override
String toString() {
  return 'ProductDetailState(productStatus: $productStatus, reviewsStatus: $reviewsStatus, statsStatus: $statsStatus, errorProduct: $errorProduct, errorReviews: $errorReviews, errorStats: $errorStats, product: $product, reviews: $reviews, stats: $stats)';
}


}

/// @nodoc
abstract mixin class $ProductDetailStateCopyWith<$Res>  {
  factory $ProductDetailStateCopyWith(ProductDetailState value, $Res Function(ProductDetailState) _then) = _$ProductDetailStateCopyWithImpl;
@useResult
$Res call({
 Status productStatus, Status reviewsStatus, Status statsStatus, String? errorProduct, String? errorReviews, String? errorStats, ProductDetailModel? product, List<ReviewsModel> reviews, ReviewsStatsModel? stats
});




}
/// @nodoc
class _$ProductDetailStateCopyWithImpl<$Res>
    implements $ProductDetailStateCopyWith<$Res> {
  _$ProductDetailStateCopyWithImpl(this._self, this._then);

  final ProductDetailState _self;
  final $Res Function(ProductDetailState) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productStatus = null,Object? reviewsStatus = null,Object? statsStatus = null,Object? errorProduct = freezed,Object? errorReviews = freezed,Object? errorStats = freezed,Object? product = freezed,Object? reviews = null,Object? stats = freezed,}) {
  return _then(_self.copyWith(
productStatus: null == productStatus ? _self.productStatus : productStatus // ignore: cast_nullable_to_non_nullable
as Status,reviewsStatus: null == reviewsStatus ? _self.reviewsStatus : reviewsStatus // ignore: cast_nullable_to_non_nullable
as Status,statsStatus: null == statsStatus ? _self.statsStatus : statsStatus // ignore: cast_nullable_to_non_nullable
as Status,errorProduct: freezed == errorProduct ? _self.errorProduct : errorProduct // ignore: cast_nullable_to_non_nullable
as String?,errorReviews: freezed == errorReviews ? _self.errorReviews : errorReviews // ignore: cast_nullable_to_non_nullable
as String?,errorStats: freezed == errorStats ? _self.errorStats : errorStats // ignore: cast_nullable_to_non_nullable
as String?,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductDetailModel?,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ReviewsModel>,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ReviewsStatsModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDetailState].
extension ProductDetailStatePatterns on ProductDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductDetailState value)  $default,){
final _that = this;
switch (_that) {
case _ProductDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _ProductDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Status productStatus,  Status reviewsStatus,  Status statsStatus,  String? errorProduct,  String? errorReviews,  String? errorStats,  ProductDetailModel? product,  List<ReviewsModel> reviews,  ReviewsStatsModel? stats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductDetailState() when $default != null:
return $default(_that.productStatus,_that.reviewsStatus,_that.statsStatus,_that.errorProduct,_that.errorReviews,_that.errorStats,_that.product,_that.reviews,_that.stats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Status productStatus,  Status reviewsStatus,  Status statsStatus,  String? errorProduct,  String? errorReviews,  String? errorStats,  ProductDetailModel? product,  List<ReviewsModel> reviews,  ReviewsStatsModel? stats)  $default,) {final _that = this;
switch (_that) {
case _ProductDetailState():
return $default(_that.productStatus,_that.reviewsStatus,_that.statsStatus,_that.errorProduct,_that.errorReviews,_that.errorStats,_that.product,_that.reviews,_that.stats);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Status productStatus,  Status reviewsStatus,  Status statsStatus,  String? errorProduct,  String? errorReviews,  String? errorStats,  ProductDetailModel? product,  List<ReviewsModel> reviews,  ReviewsStatsModel? stats)?  $default,) {final _that = this;
switch (_that) {
case _ProductDetailState() when $default != null:
return $default(_that.productStatus,_that.reviewsStatus,_that.statsStatus,_that.errorProduct,_that.errorReviews,_that.errorStats,_that.product,_that.reviews,_that.stats);case _:
  return null;

}
}

}

/// @nodoc


class _ProductDetailState implements ProductDetailState {
  const _ProductDetailState({required this.productStatus, required this.reviewsStatus, required this.statsStatus, required this.errorProduct, required this.errorReviews, required this.errorStats, required this.product, required final  List<ReviewsModel> reviews, required this.stats}): _reviews = reviews;
  

@override final  Status productStatus;
@override final  Status reviewsStatus;
@override final  Status statsStatus;
@override final  String? errorProduct;
@override final  String? errorReviews;
@override final  String? errorStats;
@override final  ProductDetailModel? product;
 final  List<ReviewsModel> _reviews;
@override List<ReviewsModel> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

@override final  ReviewsStatsModel? stats;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDetailStateCopyWith<_ProductDetailState> get copyWith => __$ProductDetailStateCopyWithImpl<_ProductDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDetailState&&(identical(other.productStatus, productStatus) || other.productStatus == productStatus)&&(identical(other.reviewsStatus, reviewsStatus) || other.reviewsStatus == reviewsStatus)&&(identical(other.statsStatus, statsStatus) || other.statsStatus == statsStatus)&&(identical(other.errorProduct, errorProduct) || other.errorProduct == errorProduct)&&(identical(other.errorReviews, errorReviews) || other.errorReviews == errorReviews)&&(identical(other.errorStats, errorStats) || other.errorStats == errorStats)&&(identical(other.product, product) || other.product == product)&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&(identical(other.stats, stats) || other.stats == stats));
}


@override
int get hashCode => Object.hash(runtimeType,productStatus,reviewsStatus,statsStatus,errorProduct,errorReviews,errorStats,product,const DeepCollectionEquality().hash(_reviews),stats);

@override
String toString() {
  return 'ProductDetailState(productStatus: $productStatus, reviewsStatus: $reviewsStatus, statsStatus: $statsStatus, errorProduct: $errorProduct, errorReviews: $errorReviews, errorStats: $errorStats, product: $product, reviews: $reviews, stats: $stats)';
}


}

/// @nodoc
abstract mixin class _$ProductDetailStateCopyWith<$Res> implements $ProductDetailStateCopyWith<$Res> {
  factory _$ProductDetailStateCopyWith(_ProductDetailState value, $Res Function(_ProductDetailState) _then) = __$ProductDetailStateCopyWithImpl;
@override @useResult
$Res call({
 Status productStatus, Status reviewsStatus, Status statsStatus, String? errorProduct, String? errorReviews, String? errorStats, ProductDetailModel? product, List<ReviewsModel> reviews, ReviewsStatsModel? stats
});




}
/// @nodoc
class __$ProductDetailStateCopyWithImpl<$Res>
    implements _$ProductDetailStateCopyWith<$Res> {
  __$ProductDetailStateCopyWithImpl(this._self, this._then);

  final _ProductDetailState _self;
  final $Res Function(_ProductDetailState) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productStatus = null,Object? reviewsStatus = null,Object? statsStatus = null,Object? errorProduct = freezed,Object? errorReviews = freezed,Object? errorStats = freezed,Object? product = freezed,Object? reviews = null,Object? stats = freezed,}) {
  return _then(_ProductDetailState(
productStatus: null == productStatus ? _self.productStatus : productStatus // ignore: cast_nullable_to_non_nullable
as Status,reviewsStatus: null == reviewsStatus ? _self.reviewsStatus : reviewsStatus // ignore: cast_nullable_to_non_nullable
as Status,statsStatus: null == statsStatus ? _self.statsStatus : statsStatus // ignore: cast_nullable_to_non_nullable
as Status,errorProduct: freezed == errorProduct ? _self.errorProduct : errorProduct // ignore: cast_nullable_to_non_nullable
as String?,errorReviews: freezed == errorReviews ? _self.errorReviews : errorReviews // ignore: cast_nullable_to_non_nullable
as String?,errorStats: freezed == errorStats ? _self.errorStats : errorStats // ignore: cast_nullable_to_non_nullable
as String?,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductDetailModel?,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ReviewsModel>,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ReviewsStatsModel?,
  ));
}


}

// dart format on
