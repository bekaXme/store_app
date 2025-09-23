part of "product_detail_bloc.dart";

sealed class ProductDetailEvent {}

class GetProductId extends ProductDetailEvent {
  final int id;

  GetProductId({required this.id});
}

class GetReviewsStat extends ProductDetailEvent {
  final int productId;

  GetReviewsStat({required this.productId});
}

class GetReviews extends ProductDetailEvent {
  final int productId;

  GetReviews({required this.productId});
}
