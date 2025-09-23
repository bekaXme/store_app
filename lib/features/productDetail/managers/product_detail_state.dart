import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/product_detail/product_detail_model.dart';
import '../../../data/models/product_detail/reviews_model.dart';
import '../../../data/models/product_detail/reviews_state_model.dart';
import '../../savedProducts/bloc/saved_products_state.dart';
part 'product_detail_state.freezed.dart';

@freezed
abstract class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState({
    required SavedProductsStatus productStatus,
    required SavedProductsStatus reviewsStatus,
    required SavedProductsStatus statsStatus,

    required String? errorProduct,
    required String? errorReviews,
    required String? errorStats,
    required ProductDetailModel? product,
    required List<ReviewsModel> reviews,
    required ReviewsStatsModel? stats,
  }) = _ProductDetailState;

  factory ProductDetailState.initial() => ProductDetailState(
    productStatus: SavedProductsStatus.initial,
    reviewsStatus: SavedProductsStatus.initial,
    statsStatus: SavedProductsStatus.initial,

    errorProduct: null,
    errorReviews: null,
    errorStats: null,

    reviews: [],
    stats: null,
    product: null,
  );
}
